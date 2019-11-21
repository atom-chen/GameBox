#!/usr/bin/python
# -*- coding: UTF-8 -*-
import os
import xlrd
import xlwt
import fnmatch
import json 
import urllib2
import datetime
import calendar
from enum import Enum 

# 日期类型
class DATETYPE():
   WORK = 0          # 工作日
   REST = 1          # 休息日
   HOLI = 2          # 节假日

# 时间统计类型
class TIMETYPE():
   HOUR = 0             # 时长
   MINUTE = 1           # 分钟长

# 显示类型
#class CELLTYPE(Enum):


# 添加设置默认编码，避免：UnicodeEncodeError: 'ascii' codec can't encode characters ...
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

class ExcelTool:
   def __init__(self, curPath, timeType, isHoliDay, isRestDay, curMonth, limitTime):
      print(u'选择路径为:' + curPath)
      print(u'时间类型(0-时长 1-分钟长):' + str(timeType))
      print(u'是否节假日算加班:' + str(isHoliDay))
      print(u'是否周六日算加班:' + str(isRestDay))
      print(u'当前月份为:' + str(curMonth))
      print(u'加班限定:' + str(limitTime))
      self._curpath = curPath       # 当前选择的路径
      self._timeType = timeType     # 时间类型： 0-时长 1-分钟长
      self._isHoliday = isHoliDay   # 节假日是否算加班
      self._isRestDay = isRestDay   # 周六日是否算加班
      self._curMonth = curMonth     # 当前月份
      self._limitTime = limitTime   # 加班限定时间,比如19:30

   # 分析文件
   def AnalyzeFile(self):
      for root, dirs, files in os.walk(self._curpath):
        for filename in fnmatch.filter(files, "*.xlsx"):
            if os.path.isfile(filename):
               print(u'-------------------- 遍历文件名为:' + filename + '--------------------')
               self.ReadExcel(filename)

   # 读取Excel文件
   def ReadExcel(self, fileName):
      # 打开excel文件读取数据
      workbook = xlrd.open_workbook(fileName, encoding_override='utf-8')
      # 获取所有Sheet的名字
      sheetNames = workbook.sheet_names()
      sheetnum = len(sheetNames)
      # 遍历sheets表
      for index in range(sheetnum):
         sheet = workbook.sheet_by_index(index)
         ROWS = sheet.nrows  # 获取指定sheet的有效行
         COLS = sheet.ncols  # 获取指定sheet的有效列
         print(u'Sheet名:{0} (行:{1}, 列:{2})'.format(sheet.name, ROWS, COLS))

         # 获取日期列表
         dateDict = self.getColHoliDayData(COLS)

         # 普通加班时间遍历，生成新的excel列表
         # 获取指定月份下的19:00 ~ 21:00，以及周六日，节假日的加班数据
         sheetData = self.getNormalSheetData(ROWS, COLS, sheet, dateDict)
         self.WriteNormalNewExcel(fileName, sheetNames[index], dateDict, sheetData)

   '''
   @function: 获取指定月份下的19:00 ~ 21:00，以及周六日，节假日的加班数据
   @param: ROWS excel列表的行数
   @param: COLS excel列表的列数
   @param: sheet sheet数据
   @param: dateDict 日期列表数据
   '''
   def getNormalSheetData(self, ROWS, COLS, sheet, dateDict):
      sheetData = []
      for rowx in range(0, ROWS):       # 遍历行
         rowData = []                   # 每行存储的数据
         workOverTime = 0               # 工作日加班时间
         restOverTime = 0               # 周六日加班时间
         holidayOverTime = 0            # 节假日加班时间
         totalOverTime = 0              # 总加班时间

         for colx in range(0, COLS):    # 遍历列
            cell = sheet.cell(rowx, colx)
            cellValue = str(cell.value).encode('utf-8')     # 单元格数值,unicode格式
            if rowx == 0:
               # 记录标题信息
               rowData.append(cellValue)
               if colx + 1 == COLS:
                  rowData.append(u'工作日时间')
                  rowData.append(u'休息日时间')
                  rowData.append(u'节假日时间')
                  rowData.append(u'总时间')
            else:
               if colx == 0:
                  # 记录姓名信息
                  rowData.append(cellValue)
               else:
                  # 记录加班时间
                  dateType = dateDict[colx]
                  overTime = self.CalculateOverMinutes(cellValue, dateType)
                  if self._timeType == TIMETYPE.HOUR:
                     overTime = round(overTime*1.0/60, 2)
                  rowData.append(overTime)

                  # 统计各个加班分钟长
                  totalOverTime += overTime
                  if dateType == DATETYPE.WORK:
                     workOverTime += overTime 
                  elif dateType == DATETYPE.REST:
                     restOverTime += overTime
                  elif dateType == DATETYPE.HOLI:
                     holidayOverTime += overTime
                     
                  if colx + 1 == COLS:
                     rowData.append(round(workOverTime, 2))
                     rowData.append(round(restOverTime, 2))
                     rowData.append(round(holidayOverTime,2))
                     rowData.append(round(totalOverTime, 2))
         # 存储数据
         sheetData.append(rowData) 
      return sheetData

   '''
   @function: 写入新的excel列表
   @param: fileName 原excel列表名
   @param: sheetName 原excel列表sheet名
   @param: dateDict 日期列表(0工作日 1周六日 2节假日)
   @param: sheetData 加班数据
   '''
   def WriteNormalNewExcel(self, fileName, sheetName, dateDict, sheetData):
      # 创建新的excel
      newbook = xlwt.Workbook(encoding = 'utf-8')
      # 创建新的Sheet
      newSheet = newbook.add_sheet(sheetName)
      
      # 写入内容
      dateLen = len(dateDict)
      print(dateLen,dateDict)
      rowCount = len(sheetData) 
      for rowx in range(rowCount):                          # 遍历每行
         for colx in range(len(sheetData[rowx])):           # 遍历每列
            cellValue = sheetData[rowx][colx]
            if colx == 0:
               newSheet.write(rowx, colx, cellValue)
            else:
               if colx <= dateLen:
                  dateType = dateDict[colx]
               else: 
                  # 表示列表已超过该月份的最大天数了
                  dateType = None
               style = self.GetExcelStyle(rowx, colx, dateType, cellValue)
               newSheet.write(rowx, colx, cellValue, style)

      newXlsName = '{0}_New.xls'.format(os.path.splitext(fileName)[0])
      newbook.save(newXlsName)
      print(u'生成新Excel表:{0}'.format(newXlsName))

   '''
   @function: 设置excel表格式相关
   @param: rowIndex 行索引
   @param: colIndex 列索引
   @param: dateType 日期类型
   @param: cellValue 数值
   '''
   def GetExcelStyle(self, rowIndex, colIndex, dateType, cellValue):
      # 初始化样式
      style = xlwt.XFStyle()
   
      '''
      设置字体，属性有：
         name:字体类型，比如宋体 
         bold:是否为粗体 
         colour_index:字体颜色 
         height:字体大小 
         italic:是否为斜体
         struck_out:删除线 
         underline:下划线
      '''
      font = xlwt.Font()

      '''
      设置排列格式，属性有:
      '''
      alignment = xlwt.Alignment()
      alignment.horz = xlwt.Alignment.HORZ_CENTER  # 水平居中
      alignment.vert = xlwt.Alignment.VERT_CENTER  # 垂直居中

      '''
      设置边框，属性有：
      NO_LINE: 没有边框 THIN: 实线
      '''
      borders = xlwt.Borders()
      
      '''
      # 为样式设置背景颜色,属性有：
      # pattern: 色值颜色模式
      # pattern_fore_colour: 背景颜色
      '''
      pattern = xlwt.Pattern()
      
      if rowIndex == 0:
         font.name = 'Arial'
         font.bold = True 
      else:
         if dateType != None :
            if dateType == DATETYPE.WORK and cellValue <= 0:
               pattern.pattern_fore_colour = 1     # 设置为红色
            elif dateType == DATETYPE.REST and cellValue > 0:
               font.bold = True
               pattern.pattern_fore_colour = 4
               pattern.pattern = xlwt.Pattern.SOLID_PATTERN
            elif dateType == DATETYPE.HOLI and cellValue > 0:
               font.bold = True 
               pattern.pattern_fore_colour = 2
               pattern.pattern = xlwt.Pattern.SOLID_PATTERN

      # 定义格式
      style.font = font 
      style.borders = borders 
      style.alignment = alignment
      style.pattern = pattern
      
      return style 

   '''
   @function: 计算加班分钟数
   @param: cellValue 单元格数值，即打卡时间段
   @param: dateType, 日期类型 0-工作日 1-周六日 2-节假日
   '''
   def CalculateOverMinutes(self, cellValue, dateType):
      utfStr = cellValue.encode('utf-8')
      strs = str.split(utfStr)         # 上班时间列表
      clockTimeCount = len(strs)       # 打卡时间次数

      # 每天打卡的分钟数
      minutes = []
      if clockTimeCount > 0:              
         for _str in strs:
            hour, minute = _str.strip().split(':')
            minute = int(hour) * 60 + int(minute)
            minutes.append(minute)

      if dateType == DATETYPE.HOLI:
         # 节假日全天算加班，加班时长计算为8小时
         if not self._isHoliday:
            return 0
         return 8 * 60
      elif dateType == DATETYPE.REST:
         # 休息日(周六日)必须保证有两次打卡时间，才算加班，否则加班无效
         if not self._isRestDay:
            return 0
         elif clockTimeCount < 2:
            return 0
         else:
            return minutes[-1] - minutes[0]
      elif dateType == DATETYPE.WORK:
         # 工作日,在19:30后打卡，算加班，加班时长为最后打卡时间 - 19:00
         # 判定最后一个时间段是否超过19:00且大于19:30
         if clockTimeCount < 2:
            return 0
         
         hour, minute = self._limitTime.strip().split(':')
         limitMinute = int(hour) * 60 + int(minute)
         if minutes[-1] - limitMinute >= 0:
            return minutes[-1] - 19*60
         return 0
      
      return 0

   '''
   @function: 获取指定列的日期数据
   @param: 当前列数目
   @return
   data = {
      [colIndex1] = 0/1/2      # None -无效 0-工作日  1-周六日  2-节假日
      [colIndex2] = 0/1/2
      ...
   }
   注意：
   1. 一般情况下，Excel列表下的第1列为姓名，第2列为当月的第1号,因此计算日期时，忽略第1列即0列
   '''
   def getColHoliDayData(self, cols):
      curYear = datetime.datetime.now().year
      curMonthMaxDay = calendar.monthrange(curYear, self._curMonth)[1]
      
      dateDict = {}
      strDate = ''
      for colIndex in range(1, cols):
         # 添加判定，避免列数超过指定月的天数
         if colIndex > curMonthMaxDay:
            break
         # 日期字符串，比如：20190101
         curDate = "{0}{1:0>2d}{2:0>2d}".format(curYear, self._curMonth, colIndex)
         strDate += curDate + ','
         dateDict[colIndex] = curDate

      # 获取当前日期是否为节假日,返回数据：0-工作日 1-休息日 2-节假日
      url = 'http://www.easybots.cn/api/holiday.php?d=' + strDate[0:-1] 
      urlRequest = urllib2.Request(url)
      response = urllib2.urlopen(urlRequest)
      code = response.read()
      codeDict = json.loads(code.encode('utf-8'))

      # 将codeDict下的value根据其key拷贝到dateDict下的对应的Value中
      for colIndex, date in dateDict.items():
         if codeDict.has_key(date):
            dateDict[colIndex] = int(codeDict[date].encode('utf-8'))

      #for key, value in dateDict.items():
      #   print(key, value)
      return dateDict

      
