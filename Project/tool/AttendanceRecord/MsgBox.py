#!/usr/bin/python
#-*- coding:utf-8 -*-

import os
import datetime
import Tkinter
from Tkinter import *
import tkFileDialog

FORMATE = ['时长', '分钟长']

content = '''
1. 用于统计每个人在指定月份下的加班时间
2. 工作日在19:30后打卡，算加班，加班时长为最后打卡时间 - 19:00
3. 周六日必须保证有两次打卡时间，才算加班，否则加班无效
4. 节假日时间，全天算加班，加班时长为8小时
'''


# 消息框模块
class MsgBox:
    def __init__(self):
        # 目录相关
        self.sourcepath = os.getcwd()                           # 选择路径
        self._curMonth = datetime.datetime.now().month          # 当前月份

        self.root = Tkinter.Tk()
        self.root.title('加班统计工具')
        self.showMsgBox()
        self.root.mainloop()


    
    # 显示消息框
    def showMsgBox(self):
        line = 0
        # 路径相关
        self.pathVar = StringVar()
        self.pathVar.set(self.sourcepath)
        Label(self.root, text='路径:').grid(row=line, column=0, sticky='W')
        Entry(self.root, textvariable=self.pathVar, width=50).grid(row=line, column=1, sticky='W')
        Button(self.root, text=' ... ', command=self.onClickPathEvent).grid(row=line, column=2, sticky='E')
        line += 1

        # 多选框相关(互斥)
        Label(self.root, text='时间类型:').grid(row=line, column=0, sticky='W')
        self.radioVar = IntVar()
        for i in range(len(FORMATE)):
            radio = Radiobutton(self.root, text=FORMATE[i], variable=self.radioVar, value=i)
            radio.grid(row=line, column=1, sticky='W', padx=150*i)
        line += 1

        # 多选框相关(不互斥) 
        Label(self.root, text='加班条件:').grid(row=line, column=0, sticky='W')
        self.chkVar1 = IntVar()
        chkBtn1 = Checkbutton(self.root, text='节假日算加班', variable=self.chkVar1)
        chkBtn1.grid(row=line, column=1, sticky='W')
        self.chkVar2 = IntVar()
        chkBtn2 = Checkbutton(self.root, text='周六日算加班', variable=self.chkVar2)
        chkBtn2.grid(row=line, column=1, sticky='W', padx=150)
        line += 1

        # 月份相关
        self.monthVar = IntVar()
        self.monthVar.set(self._curMonth)
        Label(self.root, text='选择月份:').grid(row=line, column=0, sticky='W')
        spin = Spinbox(self.root, from_=1, to=12, increment=1, textvariable=self.monthVar)
        spin.grid(row=line, column=1, sticky='W')
        line += 1

        # 加班限定相关
        self.limitVar = StringVar()
        self.limitVar.set('19:30')
        Label(self.root, text='加班限定:').grid(row=line, column=0, sticky='W')
        entry = Entry(self.root, textvariable=self.limitVar)
        entry.grid(row=line, column=1, sticky='W')
        line += 1
        
        # 说明
        label = Label(self.root, text=content, bg='gray', fg='red')
        label.grid(row=line, column=1, sticky='W')
        line += 1

        # 确定按钮
        Button(self.root, text='确认', command=self.sureEvent).grid(row=line, column=1)

    # 选择路径事件
    def onClickPathEvent(self):
        newDir = tkFileDialog.askdirectory(initialdir=self.sourcepath)
        if len(newDir) != 0:
            self.pathVar.set(newDir)
            self.sourcepath = newDir
    
    # 确定事件
    def sureEvent(self):
        path = self.sourcepath
        timeType = self.radioVar.get()
        isHoliday = True if self.chkVar1.get() == 1 else False  
        isRestDay = True if self.chkVar2.get() == 1 else False 
        curMonth = self.monthVar.get()
        limitTime = self.limitVar.get()
        print(u'选择路径为:' + path)
        print(u'时间类型(0-时长 1-分钟长):' + str(timeType))
        print(u'是否节假日算加班:' + str(isHoliday))
        print(u'是否周六日算加班:' + str(isRestDay))
        print(u'当前月份为:' + str(curMonth))
        print(u'加班限定:' + str(limitTime))

if __name__ == '__main__':
    box = MsgBox()