#!/usr/bin/python
# -*- coding: UTF-8 -*-
import os
import xlrd
import xlwt
import fnmatch
import json 
import urllib2

# 添加设置默认编码，避免：UnicodeEncodeError: 'ascii' codec can't encode characters ...
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

'''
# 获取当前日期是否为节假日，地址格式: http://api.goseek.cn/Tools/holiday?date=20198030
# 返回数据：0-工作日 1-休息日 2-节假日 
'''
def getHoliDayType(date):
   urlRequest = urllib2.Request('http://api.goseek.cn/Tools/holiday?date=' + date )
   response = urllib2.urlopen(urlRequest)
   dateData = json.loads(response.read())
   return dateData['data']

'''
@function: 计算加班时间，19:00后且加班30分钟后，算加班
@param: cellValue 单元格数值，根据最后一个时间段判定是否大于19：30,获取加班时间
@param: colx, 列索引，除去第0列的名字外，其它可作为某月的第几号
注意： 年份和日期暂定
'''
def CalculateOverTimeMinute(cellValue, colx):
   minutes = []
   utfStr = cellValue.encode('utf-8')

   if len(utfStr.strip()) == 0:
      # 数据为空，判定下当前是否为节假日或消息日
      curDate = '201909' + str(colx)
      '''
      holidayType = getHoliDayType(curDate)
      if holidayType == 2:
         return 8 * 60
      '''
      return 0
   else:
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


# 读取Excel文件
def ReadExcel(fileName):
   curpath = os.getcwd()
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
      print(u'[excel] SheetName:{0} (row:{1}, col:{2})'.format(sheet.name, ROWS, COLS))

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
               overTime = CalculateOverTimeMinute(cellValue, colx)
               rowData.append(overTime)
         
         # 存储每行数据
         sheetData.append(rowData)
      
      for i in range(len(sheetData)):
         print(i, sheetData[i])

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


if __name__ == '__main__':
   curpath = os.getcwd()
   print(curpath)
   for root, dirs, files in os.walk(curpath):
        for filename in fnmatch.filter(files, "*.xlsx"):
            if os.path.isfile(filename):
               print(u'遍历文件名为:' + filename)
               ReadExcel(filename)