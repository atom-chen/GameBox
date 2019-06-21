-- 
local UIChapter = require("app.UI.chapter.UIChapter")
local UIChapterEach = require("app.UI.chapter.UIChapterEach")
local ChapterService = require("app.Service.ChapterService")

local ChapterScene = class("ChapterScene", function()
    return cc.Scene:create()
end)

function ChapterScene:ctor()
    self:init()
    local function onNodeEvent(event)
        if event == "enter" then
            self:onEnter()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function ChapterScene:init()
    self:_initData() 
    self:_initUI()
end 

function ChapterScene:_initData()
    self._root = nil 
    self._titlespr = nil        -- 章标题
    self._leftBtn = nil         -- 左按钮
    self._rightBtn = nil        -- 右按钮
    self._backBtn = nil         -- 返回按钮
    self._shopBtn = nil         -- 商店按钮
    self._chapterNode = nil     -- 章Node
    self._eachNode = nil        -- 节node

    -- 当前页面，有:main-章页面 each-节页面，在main页面可返回大厅，在each页面可返回到main页面
    self._curLayer = "main"     
    self._curSelectIndex = 1    -- 当前选择章索引
    self._chapterService = ChapterService:getInstance()
end 

function ChapterScene:_initUI()
    self._root = cc.CSLoader:createNode("res/csd/ChapterScene.csb")
    local size = self._root:getContentSize()
    self._root:setPosition(cc.p((display.width-size.width)/2, (display.height-size.height)/2))
    self:addChild(self._root)

    self._titlespr = ccui.Helper:seekNodeByName(self._root, "")
    self._leftBtn = ccui.Helper:seekNodeByName(self._root, "")
    self._rightBtn = ccui.Helper:seekNodeByName(self._root, "")
    self._backBtn = ccui.Helper:seekNodeByName(self._root, "")
    self._shopBtn = ccui.Helper:seekNodeByName(self._root, "")

    -- 初始化组件
    self._chapterNode = UIChapter:create(self._root)
    self._eachNode = UIChapterEach:create(self._root)

    BindTouchEvent(self._leftBtn, handler(self, self._clickLeftEvent))
    BindTouchEvent(self._rightBtn, handler(self, self._clickRightEvent))
    BindTouchEvent(self._backBtn, handler(self, self._clickBackEvent))
    BindTouchEvent(self._shopBtn, handler(self, self._clickShopEvent))
end 

function ChapterScene:onEnter()
    --
end 

-- 左点击事件
function ChapterScene:_clickLeftEvent(sender)
    --
end 

-- 右点击事件
function ChapterScene:_clickRightEvent(sender)
    --
end 

-- 返回事件
function ChapterScene:_clickBackEvent(sender)
    -- 在main页面可返回大厅，在each页面可返回到main页面
    if self._curLayer == "main" then 
        -- 返回大厅场景
    elseif self._curLayer == "each" then 
        -- 返回章页面
    end 
end 

-- 商店事件
function ChapterScene:_clickShopEvent(sender)
    --
end 

-- 点击章事件
function ChapterScene:_clickChapterEvent(sender, eventType)
    -- 按下显示章信息
    -- 松开进入节目录
end 

-- 更新章UI
function ChapterScene:_updateChapterUI(selectIndex)
    -- 切换背景res
    -- 切换标题res
    -- 切换章目录数据
end 

return ChapterScene
