# -*- coding:utf-8 -*-
'''
通用字符编码检测
官网： https://pypi.org/project/chardet/
安装方式：pip/pip3 install chardet
版本要求：pythhon 2.6, 2.7 or 3.3+

'''
import os
import sys 
import codecs
import chardet

# 检测文件
def _detectfile(filename):
    f = open(filename, 'rb')
    byte_str = f.read()

    _dict = chardet.detect(byte_str)
    _dict['path'] = filename
    del _dict['language']
    del _dict['confidence']
    f.close()

    return _dict

# 分析文件(路径，是否忽略utf-8，是否转换)
def _analyfile(path, isIgnore, isConvert):
    print('isIgnore', isIgnore)
    print('isConvert', isConvert)
    _map = []
    filenum = 0
    ignorenum = 0
    for root, dirs, files in os.walk(path):
        for filename in files:
            fullpath = os.path.join(root, filename)
            if os.path.isfile(fullpath):
                _dict = _detectfile(fullpath)
                if (isIgnore is True) and _dict['encoding'] == 'utf-8':
                    ignorenum += 1
                else:
                    print(_dict)
                    if isConvert is True:
                        _convertEncodeFile(_dict)
                    _map.append(_dict)
                    filenum += 1
                    
            else:
                print(fullpath + ' is not exsit file!!!')

    print(u'遍历文件数目为:'+ str(filenum))
    print(u'忽略 utf-8 编码文件数目为:'+ str(ignorenum))
    # 写入日志
    f = open('log.txt', 'a')
    for item in _map:
        f.write(str(item) + '\n')
    f.close()


# 转换文件
def _convertEncodeFile(_dict):
    filename = _dict['path']            # 文件路径
    encoding = _dict['encoding']        # 文件编码
    content = ''                        # 文件内容

    print(u'转换文件:' + filename)
    # 读取文件
    with codecs.open(filename, 'r', encoding) as sourcefile:
        content = sourcefile.read()

    # 转换文件编码
    with codecs.open(filename, 'w', 'utf-8') as targetfile:
        targetfile.write(content)


if __name__ == '__main__':
    # 获取转换目录
    path = raw_input('please input directory:')
    path = path.replace(' ', '')
    if len(path) == 0:
        print('directory error !!!')
        sys.exit()

    # 是否忽略检测utf-8编码文件
    ignoreCode = raw_input('whether to ignore utf-8 files(y/n):')
    if len(ignoreCode) == 0:
        print('please input y or n !!!') 
        sys.exit()

    isIgnore = False 
    if str.lower(ignoreCode) == 'y':
        isIgnore = True 
    # 是否转换非utf-8编码文件
    convertCode = raw_input('whether to convert not utf-8 files. and if so, the file will be replaced.(y/n):')
    if len(convertCode) == 0:
        print('please input y or n !!!') 
        sys.exit()
    
    isConvert = False
    if str.lower(convertCode) == 'y':
        isConvert = True

    _analyfile(path, isIgnore, isConvert)