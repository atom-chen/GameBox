-- 
local ChapterService = require("app.Service.ChapterService")
local UIChapterEach = class("UIChapterEach") 

local SPACE_W, SPACE_H = 20, 10     -- 间隔
local INIT_NUM = 6                  -- 初始化数目
 
function UIChapterEach:ctor(parent)
    print("UIChapterEach:ctor ...1")
    self:_initData(parent)
    self:_initUI()
end 

function UIChapterEach:_initData(parent)
    self._parentNode = parent 
    self._root = nil 
    self._tmpItem = nil 
    self._panels = {}
end 

function UIChapterEach:_initUI()
    self._root = ccui.Helper:seekNodeByName(self._parentNode, "Node_Each")

    self._tmpItem = self._root:getChildByName("Panel_1")
    self._tmpItem:retain()
    self._tmpItem:removeFromParent(false)

    -- 默认初始化数目
    local startx, starty = self._tmpItem:getPosition()
    local _size = self._tmpItem:getContentSize()
    local line, col = 0,0                               -- 行，列
    for i = 1, INIT_NUM do 
        if i%3 == 0 then 
            col = 3
            line = math.floor(i/3)
        else 
            col = i%3
            line = math.floor(i/3) + 1
        end 
        self._panels[i] = self._tmpItem:clone()
        local posx, posy = startx + (col - 1) * (_size.width + SPACE_W), starty - (line - 1) * (_size.height + SPACE_H)
        self._panels[i]:setPosition(cc.p(posx, posy))
        self._panels[i]:addTouchEventListener(handler(self, self._clickEachEvent))
        self._panels[i]:setVisible(false)
        self._root:addChild(self._panels[i])

    end 
end 

function UIChapterEach:updateUI(chapterId)
    local data = ChapterService:getInstance():getChapterEachDatas(chapterId)
    if not data then 
        return 
    end 
    dump(data)

    -- 每章节数不会超过6个
    for i, v in ipairs(data) do 
        -- 标题
        local titleImg = self._panels[i]:getChildByName("Image_8")
        titleImg:loadTexture(v.titleRes, ccui.TextureResType.plistType)
        -- 头像
        local iconImg = self._panels[i]:getChildByName("Image_Icon")
        if i == 6 then 
            iconImg:loadTexture(v.headRes, ccui.TextureResType.plistType)
        end 

        self._panels[i]:setVisible(true)
    end 
    
end 

-- 点击节事件
function UIChapterEach:_clickEachEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then
        return 
    end 
    -- 判定该节是否开启， 若未开启直接弹窗
    local isOpen = false  
    if isOpen then 
        MsgTip("该章未开启哦")
        return 
    end 

    -- 显示相关
    --[[
    local chapterId = self._chapterService:getChapterIdByIndex(self._curSelectIndex)
    self._eachNode:updateUI(chapterId)
    self._eachNode:setEachShow(true)
    self._curLayer = "each"
    self._chapterNode:setVisible(false)
    ]]

    local _scene = require("app.UI.battle.BattleScene"):create()
    cc.Director:getInstance():replaceScene(_scene)
end 

function UIChapterEach:setEachShow(b)
    self._root:setVisible(b)
end 

return UIChapterEach 
