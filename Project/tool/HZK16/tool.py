# -*- coding:UTF-8 -*-
#!/usr/bin/env python

'''
参考：
https://blog.twofei.com/embedded/hzk.html
https://www.jb51.net/article/155543.htm
'''
import os
import math
import binascii
from PIL import Image

# 用于解决错误：UnicodeEncodeError: 'ascii' codec encode characters in position 31-57: ordinal not in range(128)
# 原因在于调用ascii编码处理字符流时，若字符流不属于ascii范围内就会报错
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

# 每张头像裁剪后尺寸
HEAD_CLIPSIZE = 75

# 每行列头像数目，即每点：2*2
HEAD_NUM = 2

#
RECT_WIDTH = 16                          
RECT_HEIGHT = 16                     
BYTE_COUNT_PER_ROW = RECT_WIDTH/8
BYTE_COUNT_PER_FONT = BYTE_COUNT_PER_ROW*RECT_HEIGHT

'''
HZK16字库是符合GB2312国家标准的16×16点阵字库，HZK16的GB2312-80支持的汉字有6763个，符号682个
GB2312汉字是由两个字节编码的，范围为0xA1A1~0xFEFE。A1-A9为符号区，B0-F7为汉字区.
汉字占两个字节，这两个中前一个字节为该汉字的区号，后一个字节为该字的位号.其中，每个区记录94个汉字，位号为该字在该区中的位置。

要获取一个汉字的位置，就需要得到他的区码和位码
* 区码：汉字的第一个字节-0xA0，因为汉字编码是从0xA0区开始的，所以文件最前面就是从0xA0区开始，要算出相对区码
* 位码：汉字的第二个字节-0xA0
这样我们就可以得到汉字在HZK16中的绝对偏移位置：offset = (94*(区码-1)+(位码-1))*32。

注解：
* 区码减1是因为数组是以0为开始而区号位号是以1为开始的
* (94*(区号-1)+位号-1)是一个汉字字模占用的字节数
* 最后乘以32是因为汉字库文应从该位置起的32字节信息记录该字的字模信息(前面提到一个汉字要有32个字节显示)

摘抄于：https://blog.twofei.com/embedded/hzk.html
'''
# 将文字转换为点阵
# 代码参考：https://www.jb51.net/article/155543.htm
def char2bit(textStr):
    KEYS = [0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01]
    target = []
    global count
    count = 0
    for x in range(len(textStr)):
        text = textStr[x]
        rect_list = [] * RECT_HEIGHT
        for i in range(RECT_HEIGHT):
            rect_list.append([] * RECT_WIDTH)

        # 获取GB2312编码字符
        gb2312 = text.encode('gb2312')
        hex_str = binascii.b2a_hex(gb2312)
        result = str(hex_str)
        # 区码
        area = eval('0x' + result[:2]) - 0xA0       
        # 位码    
        index = eval('0x' + result[2:]) - 0xA0
        # 绝对偏移值
        offset = (94 * (area-1) + (index-1)) * BYTE_COUNT_PER_FONT

        font_rect = None
        with open("HZK16", "rb") as f:
            f.seek(offset)
            font_rect = f.read(BYTE_COUNT_PER_FONT)

        for k in range(len(font_rect)/BYTE_COUNT_PER_ROW):
            row_list = rect_list[k]
            for j in range(BYTE_COUNT_PER_ROW):
                for i in range(8):
                    asc = binascii.b2a_hex(font_rect[k * BYTE_COUNT_PER_ROW + j])
                    asc = asc = eval('0x' + asc)
                    flag = asc & KEYS[i]
                    row_list.append(flag)

        output = []
        for row in rect_list:
            for i in row:
                if i:
                    output.append('1')
                    count+=1
                    #print('0', end=' ')
                else:
                    output.append('0')
                    #print('.', end=' ')
            #print()

        target.append(''.join(output))
    return target

def head2char(index, outlist):
    # 获取资源列表
    imgList = []
    workspace = os.getcwd()
    respath = os.path.join(workspace, 'res')
    for root, dirs, files in os.walk(respath):
        for filename in files:
            imgList.append(os.path.join(root, filename))

    # 图片数目
    imgCount = len(imgList)

    #变量n用于循环遍历头像图片，即当所需图片大于头像总数时，循环使用头像图片
    n = 0

    for item in outlist:
        # 创建新图片
        canvasWidth = RECT_WIDTH * HEAD_NUM * HEAD_CLIPSIZE
        canvasHeight = RECT_HEIGHT * HEAD_NUM * HEAD_CLIPSIZE
        canvas = Image.new('RGB', (canvasWidth, canvasHeight), '#E0EEE0')
        # 遍历 RECT_WIDTH * RECT_HEIGHT 矩阵
        for i in range(RECT_WIDTH * RECT_HEIGHT):
            #点阵信息为1，即代表此处要显示头像来组字
            if item[i] != '1':
                continue 

            # 每个点使用放置几个矩阵，比如2*2，3*3
            for count in range(pow(HEAD_NUM, 2)):
                # 获取图片索引
                imgIndex = (n + count) % imgCount
                # 读取图片          
                headImg = Image.open(imgList[imgIndex])  
                # 重置图片大小       
                headImg = headImg.resize((HEAD_CLIPSIZE, HEAD_CLIPSIZE), Image.ANTIALIAS)
                # 拼接图片
                posx = ((i % RECT_WIDTH) * HEAD_NUM + (count%HEAD_NUM)) * HEAD_CLIPSIZE
                posy = ((i // RECT_HEIGHT) * HEAD_NUM + (count//HEAD_NUM)) * HEAD_CLIPSIZE
                canvas.paste(headImg, (posx, posy))

            #调整n以读取后续图片
            n = (n+4) % imgCount

        # 保存图片 quality代表图片质量，1-100
        canvas.save('result_{0}.jpg'.format(index), quality=100)

# 将gbk转换为unicode格式
def transGbk2Unicode(str_v):
    str_s = str_v.replace(r'%', r'\x')
    res = eval(repr(str_s).replace('\\\\', '\\'))
    return res.decode('gb2312')
        

if __name__=="__main__":
    inputStr = u'请输入您想要生成的文字(ENTER结束):'
    # 输入内容，将中文从unicode转换为gbk，防止乱码
    content = raw_input(inputStr.encode('gbk'))
    # 将gbk转换为unicode，以方便遍历时能够遍历每个文字或字母
    content = transGbk2Unicode(content)

    print(u'注意:指定文字每个仅能生成一个')
    # 循环遍历
    index = 0
    for _str in content:
        print(u'生成汉字:' + _str)

        #将字转化为汉字库的点阵数据
        outlist = char2bit(_str)

        #将头像图片按点阵拼接成单字图片                           
        head2char(index, outlist)
        index += 1

    print(u'生成成功!!!')
