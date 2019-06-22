-- 
local UIChapterEach = require("app.UI.chapter.UIChapterEach")
local ChapterService = require("app.Service.ChapterService")

local ChapterScene = class("ChapterScene", function()
    return cc.Scene:create()
end)

function ChapterScene:ctor()
    self:_initData() 
    self:_initUI()
    local function onNodeEvent(event)
        if event == "enter" then
            self:onEnter()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function ChapterScene:_initData()
    self._root = nil 
    self._bgImg = nil           -- 背景图片
    self._titleImg = nil        -- 章标题
    self._leftBtn = nil         -- 左按钮
    self._rightBtn = nil        -- 右按钮
    self._backBtn = nil         -- 返回按钮
    self._shopBtn = nil         -- 商店按钮

    -- 章相关
    self._chapterNode = nil             -- 章Node
    self._chapterBgImg = nil            -- 章背景图片
    self._chapterMedalLabel = nil       -- 章勋章数目
    self._chapterClosepanel = nil       -- 章关闭panel

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

    self._bgImg = ccui.Helper:seekNodeByName(self._root, "Image_bg")
    self._titleImg = ccui.Helper:seekNodeByName(self._root, "Image_title")
    self._backBtn = ccui.Helper:seekNodeByName(self._root, "Button_1")
    self._shopBtn = ccui.Helper:seekNodeByName(self._root, "Button_2")

    -- 章相关
    self._chapterNode = ccui.Helper:seekNodeByName(self._root, "Node_Chapter")
    self._leftBtn = ccui.Helper:seekNodeByName(self._chapterNode, "Button_left")
    self._rightBtn = ccui.Helper:seekNodeByName(self._chapterNode, "Button_right")
    self._chapterBgImg = ccui.Helper:seekNodeByName(self._chapterNode, "Image_1")
    self._chapterMedalLabel = ccui.Helper:seekNodeByName(self._chapterNode, "Text_1")
    self._chapterClosepanel = ccui.Helper:seekNodeByName(self._chapterNode, "Panel_close")

    -- 节相关
    local eachNode = ccui.Helper:seekNodeByName(self._root, "Node_Each")
    self._eachNode = UIChapterEach.new(self._root)
    eachNode:setVisible(false)

    BindTouchEvent(self._backBtn, handler(self, self._clickBackEvent))
    BindTouchEvent(self._shopBtn, handler(self, self._clickShopEvent))
    BindTouchEvent(self._leftBtn, handler(self, self._clickLeftEvent))
    BindTouchEvent(self._rightBtn, handler(self, self._clickRightEvent))

    --
    --cc.SpriteFrameCache:getInstance():addSpriteFrames("res/art/_chapter.plist")
end 

function ChapterScene:onEnter()
    self:_updateUI()
end 

-- 刷新UI
function ChapterScene:_updateUI(selectIndex)
    local chapterId = nil 
    if not selectIndex then 
        chapterId = self._chapterService:getCurChapterId()
    else 
        chapterId = self._chapterService:getChapterIdByIndex(selectIndex)
    end 
    
    local titleRes, bgRes, chapterRes, closeRes = self._chapterService:getChapterRes(chapterId)
    -- 标题
    if titleRes then 
        
        self._titleImg:loadTexture(titleRes, ccui.TextureResType.plistType)
    end 
    -- 背景
    if bgRes then 
        self._bgImg:loadTexture(bgRes, ccui.TextureResType.localType)
    end 
    -- 章背景
    if chapterRes then 
        self._chapterBgImg:loadTexture(chapterRes, ccui.TextureResType.plistType)
    end 

    local data = self._chapterService:getChapterData(chapterId)
    if not data then 
        return 
    end 

    -- 章勋章数目
    local curNum, maxnum = data.chaptercurMedal, data.chaptertotalMedal
    self._chapterMedalLabel:setString(curNum .. "/" .. maxnum)

    -- 是否开启
    print("是否开启：", data.isopen)
    self._chapterClosepanel:setVisible(not data.isopen)
    if not data.isopen and closeRes then 
        self._chapterClosepanel:setBackGroundImage(closeRes, ccui.TextureResType.plistType)
    end 
end 

-- 左点击事件
function ChapterScene:_clickLeftEvent(sender)
    if self._curSelectIndex <= 1 then 
        return 
    end 
    self._curSelectIndex = self._curSelectIndex - 1

    self:_updateUI(self._curSelectIndex)
end 

-- 右点击事件
function ChapterScene:_clickRightEvent(sender)
    local chapterNum = self._chapterService:getChapterNum()
    if self._curSelectIndex >= chapterNum then 
        return 
    end 
    self._curSelectIndex = self._curSelectIndex + 1

    self:_updateUI(self._curSelectIndex)
end 

-- 点击章事件
function ChapterScene:_clickEvent(sender)
    -- 判定该章是否开启， 若未开启直接弹窗
    --[[
    local isOpen = self:getIsOpen(self._chapterId)
    if not isOpen then 
        return 
    end 
    ]]

    -- 打开节目录
end 

-- 返回事件
function ChapterScene:_clickBackEvent(sender)
    -- 在main页面可返回大厅，在each页面可返回到main页面
    if self._curLayer == "main" then 
        -- 返回大厅场景
    elseif self._curLayer == "each" then 
        -- 返回章页面
    end 
    local mainScene = require("app.UI.MainScene"):create()
    cc.Director:getInstance():replaceScene(mainScene)
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
