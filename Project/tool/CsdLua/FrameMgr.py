#-*- coding:utf-8 -*-

import os
import sys
import time
from xml.dom import minidom

# 引用相关
STR_REQUIRE = '''
--[[

]]
local super = require("app.game.ui.UIBase")
local _M = class("_M", super, function() 
    return kod.LoadCSBNode("ui/csb/_M.csb") 
end)
'''

# 默认方法相关
STR_PUBLIC = '''
function _M:onShow()
    -- do something
end

function _M:onHide()
    -- do something
end

function _M:needBlackMask()
    return true
end

function _M:closeWhenClickMask()
    return true
end
return _M
'''
# 初始化
INIT_TEMP = 'self.{0} = seekNodeByName(self, "{0}", "{1}")'

# 按钮事件绑定
BIND_TEMP = 'bindEventCallBack(self.{0}, handler(self, self.onClick_{0}),ccui.TouchEventType.ended)'

# 按钮事件回调: _M:方法名 UIM:控件名
CALL_TEMP = '''
function {0}:onClick_{1}(sender,eventType)
    -- do something
end
'''

# csb属性相关
csbProperty = {
    "GameNodeObjectData": "ccui.Node",
    "TextObjectData": "ccui.Text",
    "ButtonObjectData": "ccui.Button",
    "CheckBoxObjectData": "ccui.CheckBox",
    "PanelObjectData": "ccui.Layout",
    "TextFieldObjectData": "ccui.TextField",
    "ListViewObjectData": "ccui.ListView",
    "SpriteObjectData": "ccui.Sprite",
    "ImageViewObjectData": "ccui.ImageView",
}


def getProperty(strtype):
    if strtype in csbProperty:
        return csbProperty[strtype]
    else:
        return strtype


# Lua文本模块
class FrameLuaText:
    def __init__(self, csbName, items):
        self._csbName = csbName
        self._items = items

    # 获取lua文件内容
    def getLuaFileContent(self):
        content = ''
        # require相关
        requireStr = self.getRequireText()
        content = content + requireStr
        # init相关
        initStr = self.getInitText()
        content = content + initStr
        # 回调相关
        callStr = self.getAllCallTexts()
        content = content + callStr
        # public相关
        publicStr = self.getPublicText()
        content = content + publicStr

        return content

    # 获取require文本
    def getRequireText(self):
        newStr = STR_REQUIRE.replace('_M', self._csbName) + '\n'
        return newStr

    # 获取public方法文本
    def getPublicText(self):
        newStr = STR_PUBLIC.replace('_M', self._csbName) + '\n'
        return newStr

    # 获取init方法文本
    def getInitText(self):
        strInit = 'function ' + self._csbName + ':init()' + '\n'
        # 定义变量
        for item in self._items:
            strName = item['name']
            strType = getProperty(item["type"])
            strInit = strInit + '    ' + INIT_TEMP.format(strName, strType) + '\n'
        strInit = strInit + '\n'

        # 设置按钮事件绑定
        for item in self._items:
            strName = item['name']
            strType = getProperty(item["type"])
            if strType.find('Button') != -1:
                strInit = strInit + '    ' + BIND_TEMP.format(strName) + '\n'
        strInit = strInit + 'end'

        return strInit

    # 获取事件回调方法Text
    def getAllCallTexts(self):
        strCall = ""
        for item in self._items:
            strType = getProperty(item["type"])
            if strType.find('Button') != -1:
                strCall = strCall + CALL_TEMP.format(self._csbName, item['name'])
        return strCall
