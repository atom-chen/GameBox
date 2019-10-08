#-*- coding:utf-8 -*-

import os
# import time
from xml.dom import minidom
from FrameMgr import FrameLuaText
import Tkinter
from Tkinter import *
import tkFileDialog

# 默认文件目录
SOURCE_FILE = 'csdFile'
DEST_FILE = 'outFile'

# 转换的文件格式, 以后会拓展为C++，javaScript等相关
FORMATE = ['Lua']


# 消息框模块
class MsgBox:
    def __init__(self):
        # 目录相关
        self.sourcepath = os.path.abspath(SOURCE_FILE)
        self.outpath = os.path.abspath(DEST_FILE)

        self.root = Tkinter.Tk()
        self.showMsgBox()
        self.root.mainloop()
    
    # 显示消息框
    def showMsgBox(self):
        root = self.root
        root.title('转换工具')
        root.geometry('500x120')
        #
        Label(root, text='源文件目录(csd):').grid(row=1, column=0, sticky='E')
        Button(root, text='...', command=self.selectCsdPathEvent).grid(row=1, column=2, sticky='E', padx='10')
        self.csdVar = StringVar()
        self.csdVar.set(self.sourcepath)
        Entry(root, textvariable=self.csdVar, width=50).grid(row=1, column=1)
        
        #
        Label(root, text='输出目录(lua):').grid(row=2, column=0, sticky='E')
        Button(root, text='...', command=self.selectOutPathEvent).grid(row=2, column=2, sticky='E', padx='10')
        self.outVar = StringVar()
        self.outVar.set(self.outpath)
        Entry(root,textvariable=self.outVar, width=50).grid(row=2, column=1)
        #
        Label(root, text='转换格式:').grid(row=3, column=0, sticky='E')
        self.radioVar = IntVar()
        for i in range(len(FORMATE)):
            Radiobutton(root, text=FORMATE[i], variable=self.radioVar, value=i).grid(row=3, column=1, sticky='W', padx=60*i)
        #
        Button(root, text='确认', command=self.sureEvent).grid(row=4, column=1)

    def selectCsdPathEvent(self):
        newDir = tkFileDialog.askdirectory(initialdir=self.sourcepath)
        if len(newDir) == 0:
            return

        self.csdVar.set(newDir)
        self.sourcepath = newDir

    def selectOutPathEvent(self):
        newDir = tkFileDialog.askdirectory(initialdir=self.outpath)
        if len(newDir) == 0:
            return

        self.outVar.set(newDir)
        self.outpath = newDir

    def sureEvent(self):
        formatIndex = self.radioVar.get()
        strFormat = FORMATE[formatIndex]
        # 判定目录是否合法
        if len(self.sourcepath) == 0:
            print(u'请设置源文件目录')
            return 
        elif len(self.outpath) == 0:
            print(u'请设置输出目录')
            return 
        elif os.path.exists(self.sourcepath) is False:
            print(u'源文件目录不存在，请重新设置')
        elif os.path.exists(self.outpath) is False:
            print(u'存储目录不存在，请重新设置')

        print(u'打开的文件目录为:' + self.sourcepath)
        print(u'另存为的文件目录为:' + self.outpath)
        print(u'转换的格式为:' + strFormat)
        csdTool = CsdTool(self.sourcepath, self.outpath)
        csdTool.outFile() 

# csd模块
class CsdTool:
    def __init__(self, sourcepath, outpath):
        self._sourcepath = sourcepath
        self._outpath = outpath
    
    # 获取属性值
    def getAttrValue(self, node, atrrname):
        return node.getAttribute(atrrname) if node else ''

    # 获取csd名
    def getCsdName(self, root):
        csd_names = []
        property_groups = root.getElementsByTagName("PropertyGroup")
        for item in property_groups:
            attr = self.getAttrValue(item, "Name")
            csd_names.append(attr)
        if csd_names.__len__() == 1:
            return csd_names[0]
        else:
            return ""

    # ???
    def getCsdAnilist(self, node):
        animtion_name_list = []
        anim_list = node.getElementsByTagName("AnimationInfo")
        for item in anim_list:
            item_name = self.getAttrValue(item, "Name")
            animtion_name_list.append(item_name)
        return animtion_name_list

    # 获取指定csd的所有控件
    def getCsdRootItem(self, node):
        root_objects = []
        nodes = node.getElementsByTagName("AbstractNodeData")
        for item in nodes:
            item_name = self.getAttrValue(item, "Name")
            item_type = self.getAttrValue(item, "ctype")
            anim = {}
            anim["name"] = item_name
            anim["type"] = item_type
            root_objects.append(anim)
        return root_objects

    # 解析csd文件到Lua中
    def analysisCsdToFile(self, fileName, outpath):
        o_f = os.path.splitext(os.path.split(fileName)[1])[0]
        luapath = os.path.join(outpath, o_f + ".lua")
        # 判断字符串是否以后缀结尾
        if fileName.endswith(".csd") is False:
            return
        # 判定文件是否存在
        if os.path.exists(fileName) is False:
            return

        doc = minidom.parse(fileName)
        root = doc.documentElement
        # 根据UI控件相关获取内容
        csdName = self.getCsdName(root)
        items = self.getCsdRootItem(root)
        frameText = FrameLuaText(csdName, items)
        content = frameText.getLuaFileContent()
        # 写入文件
        file_obj = open(luapath, "w")
        file_obj.write(content)
        file_obj.close()
        # 日志
        strLog = u'转换完成，已将{0}.csd文件转换为{0}.lua'.format(o_f)
        print(strLog)

    # ???
    def analysisPathToLuaFile(self):
        print("do something")

    # 输出文件相关
    def outFile(self):
        if self._sourcepath == '':
            print('Error: the sourceFile is !!!')
            return
        # 判定其路径是否是一个存在的文件
        if os.path.isfile(self._sourcepath):
            # 判定文件是否是一个以.csd结尾的文件
            if (os.path.isfile(self._sourcepath) and self._sourcepath.endswith(".csd")):
                self.analysisCsdToFile(self._sourcepath, self._outpath)
        # 判定其路径是否是一个存在的目录
        elif os.path.isdir(self._sourcepath):
            for item in os.listdir(self._sourcepath):
                file = os.path.join(self._sourcepath, item)
                # 判定文件是否是一个以.csd结尾的文件
                if (os.path.isfile(file) and file.endswith(".csd")):
                    self.analysisCsdToFile(file, self._outpath)
        else:
            print('Error: the file is nil, the fileName:' + self._sourcepath)
            return

    # 输出日志相关
    def outLog(self, fileName):
        print('outLog......')

