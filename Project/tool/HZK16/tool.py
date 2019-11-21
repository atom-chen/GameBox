# -*- coding:UTF-8 -*-
#!/usr/bin/env python

'''
参考：
https://blog.twofei.com/embedded/hzk.html
https://www.jb51.net/article/155543.htm
'''

import binascii
import os
from PIL import Image

# 用于解决错误：UnicodeEncodeError: 'ascii' codec encode characters in position 31-57: ordinal not in range(128)
# 原因在于调用ascii编码处理字符流时，若字符流不属于ascii范围内就会报错
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

#颜色列表
COLORTAB = [
    '#FFFACD',      # 黄色
    '#F0FFFF',      # 白色
    '#BFEFFF',      # 蓝色
    '#b7facd',      # 青色
    '#ffe7cc',      # 浅橙色
    '#fbccff',      # 浅紫色
    '#d1ffb8',      # 淡绿色
    '#febec0',      # 淡红色
    '#E0EEE0',      # 灰色
]

#设置头像裁剪后尺寸
eachSize = 75

RECT_HEIGHT = 16
RECT_WIDTH = 16
BYTE_COUNT_PER_ROW = RECT_WIDTH/8
BYTE_COUNT_PER_FONT = BYTE_COUNT_PER_ROW*RECT_HEIGHT

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
        # 区码：
        area = eval('0x' + result[:2]) - 0xA0           
        index = eval('0x' + result[2:]) - 0xA0
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

def head2char(num, outlist):
    # 获取资源列表
    imgList = []
    workspace = os.getcwd()
    respath = os.path.join(workspace, 'res')
    for root, dirs, files in os.walk(respath):
        for filename in files:
            imgList.append(os.path.join(root, filename))

    imgCount = len(imgList)

    #变量n用于循环遍历头像图片，即当所需图片大于头像总数时，循环使用头像图片
    n=0

    #变量count用于为最终生成的单字图片编号
    count = 0

    #index用来改变不同字的背景颜色
    index = 0
    #每个item对应不同字的点阵信息
    for item in outlist:
        #新建一个带有背景色的画布，16*16点阵，每个点处填充2*2张头像图片，故长为16*2*100
        canvasSize = 16*2*eachSize
        canvas = Image.new('RGB', (canvasSize, canvasSize), COLORTAB[index])  # 新建一块画布
        #index变换，用于变换背景颜色
        index = (index+1)%9
        count += 1

        #每个16*16点阵中的点，用四张100*100的头像来填充
        for i in range(16*16):
            #点阵信息为1，即代表此处要显示头像来组字
            if item[i] != '1':
                continue 

            #循环读取连续的四张头像图片
            x1 = n % imgCount
            x2 = (n+1) % imgCount
            x3 = (n+2) % imgCount
            x4 = (n+3) % imgCount

            #点阵处左上角图片1/4
            img = Image.open(imgList[x1])                                           # 打开图片
            img = img.resize((eachSize, eachSize), Image.ANTIALIAS)                 # 缩小图片
            canvas.paste(img, ((i % 16) * 2 * eachSize, (i // 16) * 2 * eachSize))  # 拼接图片
                
            # 点阵处右上角图片2/4
            img = Image.open(imgList[x2])
            img = img.resize((eachSize, eachSize), Image.ANTIALIAS)
            canvas.paste(img, (((i % 16) * 2 + 1) * eachSize, (i // 16) * 2 * eachSize))
            
            # 点阵处左下角图片3/4
            img = Image.open(imgList[x3])
            img = img.resize((eachSize, eachSize), Image.ANTIALIAS)
            canvas.paste(img, ((i % 16) * 2 * eachSize, ((i // 16) * 2 + 1 ) * eachSize))

            # 点阵处右下角图片4/4
            img = Image.open(imgList[x4])
            img = img.resize((eachSize, eachSize), Image.ANTIALIAS) 
            canvas.paste(img, (((i % 16) * 2 + 1) * eachSize, ((i // 16) * 2 + 1) * eachSize)) 

            #调整n以读取后续图片
            n= (n+4) % len(imgList)

        # 保存图片 quality代表图片质量，1-100
        canvas.save('result_{0}.jpg'.format(num), quality=100)

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
