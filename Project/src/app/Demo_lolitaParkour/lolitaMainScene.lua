-- 萝莉跑酷主页面
local ACTION = require("app.Demo_lolitaParkour.lolitaConst").ACTION
local UIMap = require("app.Demo_lolitaParkour.lolitaMap")
local UIRole = require("app.Demo_lolitaParkour.lolitaRole")
local UIStar = require("app.Demo_lolitaParkour.lolitaStar")

local lolitaMainScene = class("lolitaMainScene", function()
    return cc.Scene:create()
end)

function lolitaMainScene:ctor()
    self._bgNode = nil              -- 背景
    self._roleNode = nil            -- 角色
    self._stars = {}                -- 星星
    self._scoreLabel = nil          -- 分数

    self:_init()
end 

function lolitaMainScene:_init()
    cc.SpriteFrameCache:getInstance():addSpriteFrames("lolitaParkour/lolitaRole.plist")

    -- 背景
    self._bgNode = UIMap.new()
    self:addChild(self._bgNode, 0)

    -- 角色
    self._roleNode = UIRole.new()
    self._roleNode:setPosition(cc.p(display.width/6, display.height/3))
    self._roleNode:changeRoleAction(ACTION.RUN)
    self:addChild(self._roleNode, 1)

    -- 星星
    --[[
    for i = 1, 9 do 
        self._stars[i] = UIStar.new()
        self._stars[i]:setPosition(cc.p(display.width/6 + (i-1)*100, display.height/3 + 80))
        self:addChild(self._stars[i])
    end 
    ]]

    -- 分数相关
    self._scoreLabel = ccui.Text:create()
    self._scoreLabel:setPosition(cc.p(display.width - 20, display.height - 20))
    self._scoreLabel:setAnchorPoint(cc.p(1, 0.5))
    self._scoreLabel:setString("分数： 0")
    self._scoreLabel:setFontSize(30)
    self:addChild(self._scoreLabel)

    -- 触摸监听
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(handler(self, self.onTouchBegan),cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(handler(self, self.onTouchEnded),cc.Handler.EVENT_TOUCH_ENDED)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)

    -- 定时器监听
    --self:scheduleUpdateWithPriorityLua(handler(self, self._update), 0)
end 

function lolitaMainScene:onTouchBegan(sender, event)
    return true 
end 

function lolitaMainScene:onTouchEnded(sender, event)
    self._roleNode:changeRoleAction(ACTION.JUMP)
end 

function lolitaMainScene:_update(dt)
    -- 检测星星是否与人物碰撞
    local roleposx, roleposy = self._roleNode:getPosition()
    local roleSize = self._roleNode:getContentSize()
    local roleRect = cc.rect(roleposx, roleposy, roleSize.width, roleSize.height)
    for i = 1, 9 do 
        local starposx, starposy = self._stars[i]:getPosition()
        local starsize = self._stars[i]:getContentSize()
        local starrect = cc.rect(starposx, starposy, starsize.width, starsize.height)
        if cc.rectIntersectsRect(roleRect, starrect) then 
            self._stars[i]:setIsShow(false)
        end 
    end 
end

return lolitaMainScene