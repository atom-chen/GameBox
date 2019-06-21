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
    self._bgImg = nil           -- 背景图片
    self._titlespr = nil        -- 章标题
    self._leftBtn = nil         -- 左按钮
    self._rightBtn = nil        -- 右按钮
    self._backBtn = nil         -- 返回按钮
    self._shopBtn = nil         -- 商店按钮
    self._chapterNode = nil     -- 章Node
    self._eachNode = nil        -- 节node

    self._chapterService = ChapterService:getInstance()
end 

function ChapterScene:_initUI()
    self._root = cc.CSLoader:createNode("res/csd/ChapterScene.csb")
    local size = self._root:getContentSize()
    self._root:setPosition(cc.p((display.width-size.width)/2, (display.height-size.height)/2))
    self:addChild(self._root)

    self._bgImg = ccui.Helper:seekNodeByName(self._root, "Image_bg")
    self._titlespr = ccui.Helper:seekNodeByName(self._root, "Sprite_title")
    self._backBtn = ccui.Helper:seekNodeByName(self._root, "Button_1")
    self._shopBtn = ccui.Helper:seekNodeByName(self._root, "Button_2")

    -- 初始化组件
    self._chapterNode = UIChapter:create(self._root)
    self._eachNode = UIChapterEach:create(self._root)

    BindTouchEvent(self._backBtn, handler(self, self._clickBackEvent))
    BindTouchEvent(self._shopBtn, handler(self, self._clickShopEvent))

    --
    cc.SpriteFrameCache:getInstance():addSpriteFrames("res/art/_chapter.plist")
end 

function ChapterScene:onEnter()
    self:_playUIAni()
    self:_updateUI()
end 

-- 播放动画
function ChapterScene:_playUIAni()
    -- do something
end 

-- 刷新UI
function ChapterScene:_updateUI()
    local curChapterId = self._chapterService:getCurChapterId()
    local data = self._chapterService:getChapterData(curChapterId)
    if not data then 
        self._chapterNode:setVisible(false)
        return 
    end 

    -- 标题
    self._titlespr:setSpriteFrame(data.titleRes)
    -- 背景
    self._bgImg:loadTexture(data.bgRes, ccui.TextureResType.plistType)
    -- 章
    self._chapterNode:updateUI(data)  
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
