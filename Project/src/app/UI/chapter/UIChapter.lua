-- 
local ChapterService = require("app.Service.ChapterService")
local UIChapter = class("UIChapter") 

function UIChapter:ctor(parent, chapterId)
    self:_initData(parent)
    self:_initUI()
end 

function UIChapter:_initData(parent)
    self._parentNode = parent 
    self._chapterId = chapterId

    self._root = nil 
    self._medalLabel = nil      -- 勋章
    self._bgImg = nil           -- 背景图
    self._closepanel = nil      -- 未开放panel

    -- 当前页面，有:main-章页面 each-节页面，在main页面可返回大厅，在each页面可返回到main页面
    self._curLayer = "main"     
    self._curSelectIndex = 1    -- 当前选择章索引
end 

function UIChapter:_initUI()
    self._root = ccui.Helper:seekNodeByName(self._parentNode, "Node_Chapter")
    self._medalLabel = ccui.Helper:seekNodeByName(self._root, "")
    self._bgImg = ccui.Helper:seekNodeByName(self._root, "Image_1")
    self._closepanel = ccui.Helper:seekNodeByName(self._root, "Panel_close")
    self._leftBtn = ccui.Helper:seekNodeByName(self._root, "Button_left")
    self._rightBtn = ccui.Helper:seekNodeByName(self._root, "Button_right")

    BindTouchEvent(self._leftBtn, handler(self, self._clickLeftEvent))
    BindTouchEvent(self._rightBtn, handler(self, self._clickRightEvent))
end 

-- 更新界面
function UIChapter:updateUI(chapterData)
    dump(chapterData)
end 

-- 左点击事件
function ChapterScene:_clickLeftEvent(sender)
    --
end 

-- 右点击事件
function ChapterScene:_clickRightEvent(sender)
    --
end 

-- 点击章事件
function UIChapter:_clickEvent(sender)
    -- 判定该章是否开启， 若未开启直接弹窗
    --[[
    local isOpen = self:getIsOpen(self._chapterId)
    if not isOpen then 
        return 
    end 
    ]]

    -- 打开节目录
end 


return UIChapter 
