#!/usr/bin/env python3
# -*- coding:UTF-8 -*-
import os
import sys
import xlrd
import fnmatch

# 添加设置默认编码，避免python2.7运行报错：UnicodeEncodeError: 'ascii' codec can't encode characters ...
reload(sys)
sys.setdefaultencoding('utf-8')

# 源文件目录路径
SRC_PATH = 'src'
# 输出文件目录路径
OUT_PATH = 'out'

# 获取表头数据相关，即前三行的中文名，英文名，类型
def getHeadDict(sheet):
    headdict = {}
    cols = sheet.ncols
    for row in range(0, 3):
        _list = []
        for col in range(0, cols):
            cell = sheet.cell(row, col)         # 获取单元格对象
            celltype = cell.ctype               # 获取单元格数据类型
            cellvalue = cell.value              # 获取单元格数值
            if(celltype != 1):
                print('[excel] sheet found invalid col name, col:' + str(col))
            else:
                # 将对象值存储到列表中
                _list.append(str(cellvalue))
        # 将列表存储到字典中
        headdict[row] = _list
    return headdict


# 解析每行数据
def getRowList(rowIndex, sheet, headdict):
    row_list = []
    cols = sheet.ncols
    for col in range(0, cols):
        cell = sheet.cell(rowIndex, col)
        ctype = cell.ctype
        
        # 判定是否存在"_"，若存在，则忽略掉此列数据
        k = headdict[1][col]
        if str(k).startswith('_'):
            continue

        # 根据类型整合数据
        head_type = headdict[2][col]
        if head_type == 'bool':
            # 布尔类型
            if ctype == 0:
                v = 'false'
            elif ctype == 2:
                if v > 0:
                    v = 'true'
                else:
                    v = 'false'
        elif head_type == 'number':
            # 数字
            if ctype == 0:
                v = 'nil'
            else:
                v = int(cell.value)
        elif head_type == 'string':
            # 字符串
            if ctype == 0:
                v = '\"\"'
            else:
                v = '\"%s\"' % (cell.value)
        elif head_type == 'data':
            # 表数据
            if ctype == 0:
                v = '{}'
            else:
                v = cell.value
        elif head_type == 'date':
            # 日期
            v = cell.value
        else:
            v = cell.value

        # 加入列表
        row_list.append([k, v])
    return row_list


# 转换
def excel2lua(root, filename):
    filepath = os.path.join(root, filename)
    # 打开excel文件读取数据
    workbook = xlrd.open_workbook(filepath, encoding_override='utf-8')
    # 获取所有工作表的名字
    sheetNames = workbook.sheet_names()
    sheetnum = len(sheetNames)
    # 遍历sheets表
    for index in range(sheetnum):
        # 通过索引顺序获取指定工作表数据
        sheet = workbook.sheet_by_index(index)
        rows = sheet.nrows  # 获取指定工作表的有效行数
        cols = sheet.ncols  # 获取指定工作表中的有效列数
        print('[excel] sheetname:{0} (row:{1}, col:{2})'.format(sheet.name, rows, cols))

        # 获取头文件数据
        headdict = getHeadDict(sheet)
        # 构造行数据
        excel_dict = {}
        for row in range(3, rows):
            # 获取ID对象
            cellId = sheet.cell(row, 0)
            ctype = cellId.ctype  # 类型
            value = cellId.value  # 数值
            if(ctype != 2):
                print('[excel] row:{} id is not number'.format(row))
                continue
            # 获取指定行数据，并将数据存储到列表中
            excel_dict[value] = getRowList(row, sheet, headdict)

        # 写入文件
        if(sheetnum > 1):
            outname = os.path.splitext(filename)[0] + '_' + sheetNames[index] + 'Config'
        else:
            outname = os.path.splitext(filename)[0] + 'Config'
        outpath = os.path.join(OUT_PATH, outname + '.lua')
        newfile = open(outpath, 'w')
        newfile.write('local {0}'.format(outname))
        newfile.write(' = {\n')
        for k, v in excel_dict.items():
            newfile.write('\t[' + str(int(k)) + '] = {')
            for row_data in v:
                newfile.write('{0} = {1},'.format(row_data[0], row_data[1]))
            newfile.write('},\n')

        newfile.write('}\n')
        newfile.write('return {0}'.format(outname))
        newfile.close()
        print('write filepath:{} sucess'.format(outpath))


# 遍历src文件下目录
def walkFiles():
    for root, dirs, files in os.walk(SRC_PATH):
        for filename in fnmatch.filter(files, "*.xlsx"):
            excel2lua(root, filename)


if __name__ == '__main__':
    walkFiles()