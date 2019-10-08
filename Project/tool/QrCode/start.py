#!/usr/bin/env python
# coding=utf-8

import sys
import qrcode

def Start(strUrl, isSave):
    # 生成二维码
    qr = qrcode.QRCode(
        # 设置Version，范围1~40 即21*21 ~ 177*177
        version=1,
        # 错误容错率，有L,M,Q,H四种，分别对应7%，15%，25%，30%，默认为ERROR_CORRECT_M
        error_correction=qrcode.constants.ERROR_CORRECT_M,
        # 每个方块的像素个数
        box_size=10,
        # 二维码距图像外围边框的距离，默认为4
        border=4,
    )
	# 设置二维码数据
    qr.add_data(strUrl)
	
	# 启用二维码颜色设置
    qr.make(fit=True)
    img = qr.make_image(fill_color="green", back_color="white")

    if isSave is True:
        # 保存二维码图片
        img.save('qrCode.png')
    else:
        # 直接显示二维码
        img.show()
    
    print("Sucess")

if __name__ == '__main__':
    # 请输入网址
    url = raw_input('please input Url:')
    if len(url) == 0:
        print('url is error !!!')
        sys.exit()

    #是否保存二维码为图片
    isSave = False
    strResult = raw_input('Save the qrCode as a picture(Y/N)')
    if len(strResult) == 0:
        print('please input Y or N !!!')
        sys.exit()

    if str.lower(strResult) == 'y':
        isSave = True

    Start(url, isSave)
