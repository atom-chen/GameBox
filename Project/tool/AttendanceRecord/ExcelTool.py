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
      self._limitTime = limitTime   # 加班限定时间


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

         # 遍历
         sheetData = []
         for rowx in range(1, ROWS):      # 遍历行
            rowData = []
            for colx in range(0, COLS):   # 遍历列
               cell = sheet.cell(rowx, colx)
               cellType = cell.ctype      # 单元格类型: 0-empty 1-string 2-number 3-date 4-boolean 5-error
               cellValue = cell.value     # 单元格数值,unicode格式
               if colx == 0:
                  # 记录姓名信息
                  rowData.append(cellValue)
               else:
                  # 记录加班时间
                  overTime = self.CalculateOverTime(cellValue, dateDict[colx])
                  rowData.append(overTime)
            
            # 存储每行数据
            sheetData.append(rowData)
         
         '''
         # for i in range(len(sheetData)):
         #    print(i, sheetData[i])

         # 写入excel表中
         newXlsName = 'New{0}_{1}.xls'.format(os.path.splitext(fileName)[0], index)
         newSheetName = sheetNames[index]
         newbook = xlwt.Workbook()
         newSheet = newbook.add_sheet(newSheetName)
         
         # 写入行标题
         for colx in range(0, COLS):
            cell = sheet.cell(0, colx)
            newSheet.write(0, colx, cell.value)
         
         # 写入内容
         for rowx in range(len(sheetData)):
            for colx in range(len(sheetData[rowx])):
               newSheet.write(rowx+1, colx, sheetData[rowx][colx])

         newbook.save(newXlsName)
         print(u'生成新Excel表:{0}'.format(newXlsName))
         '''

   '''
   @function: 计算加班时间，19:00后且加班30分钟后，算加班
   @param: cellValue 单元格数值，根据最后一个时间段判定是否大于19：30,获取加班时间
   @param: dateType, 日期类型 0-工作日 1-周六日 2-节假日
   注意： 年份和日期暂定
   '''
   def CalculateOverTime(self, cellValue, dateType):
      minutes = []
      utfStr = cellValue.encode('utf-8')

      if dateType == 2:
         # 节假日
         print(u'节假日时间，全天算加班，加班时长计算为8小时')
         return 8 * 60
      elif dateType == 1:
         # 休息日
         print(u'周六日必须保证有两次打卡时间，才算加班，否则加班无效')
      else:
         # 工作日
         print(u'工作日在19:30后打卡，算加班，加班时长为最后打卡时间 - 19:00')
         strs = str.split(utfStr)
         for _str in strs:
            hour, minute = _str.strip().split(':')
            minute = int(hour) * 60 + int(minute)       # 换算成分钟
            minutes.append(minute)

         # 判定最后一个时间段是否超过19:00且大于19:30
         overTime = minutes[-1] - (19*60 + 30)
         if overTime >= 0:
            return minutes[-1] - 19*60
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

      
