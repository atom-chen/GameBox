-- 登录页面
local UILoginScene = class("UILoginScene", function()
    return cc.Scene:create()
end) 

function UILoginScene:ctor()
    local function onNodeEvent(event)
        if event == "enter" then
            self:init()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function UILoginScene:init()
    self:_initData()
    self:_initUI() 
end 

function UILoginScene:_initData()
    self._root = nil            -- 根节点
    self._startBtn = nil        -- 开始按钮
    self._shopBtn = nil         -- 商店按钮
    self._rankBtn = nil         -- 排行榜按钮
    self._achieveBtn = nil      -- 成就按钮
    self._moreBtn = nil         -- 更多按钮
    self._dailyBtn = nil        -- 每日奖励按钮
    self._exitBtn = nil         -- 退出游戏按钮
end 

function UILoginScene:_initUI()    
    self._root = cc.CSLoader:createNode("res/csd/mainScene.csb")
    local size = self._root:getContentSize()
    self._root:setPosition(cc.p((display.width-size.width)/2, (display.height-size.height)/2))
    self:addChild(self._root)

    self._startBtn = ccui.Helper:seekNodeByName(self._root, "Button_start")
    self._shopBtn = ccui.Helper:seekNodeByName(self._root, "Button_Shop")
    self._rankBtn = ccui.Helper:seekNodeByName(self._root, "Button_rank")
    self._achieveBtn = ccui.Helper:seekNodeByName(self._root, "Button_achieve")
    self._moreBtn = ccui.Helper:seekNodeByName(self._root, "Button_more")
    --self._dailyBtn = ccui.Helper:seekNodeByName(self._root, "Image_daily")
    self._exitBtn = ccui.Helper:seekNodeByName(self._root, "Button_exit")

    ButtonTouchEvent(self._startBtn, handler(self, self._onStartEvent))
    ButtonTouchEvent(self._shopBtn, handler(self, self._onShopEvent))
    ButtonTouchEvent(self._rankBtn, handler(self, self._onRankEvent))
    ButtonTouchEvent(self._achieveBtn, handler(self, self._onAchieveEvent))
    ButtonTouchEvent(self._moreBtn, handler(self, self._onMoreEvent))
    ButtonTouchEvent(self._exitBtn, handler(self, self._onExitEvent))
end 

function UILoginScene:_onStartEvent(sender)
    print("您点击了开始游戏按钮")
    do return end 
    local layer = require("app.views.login.UISelectRole"):create()
    self:addChild(layer)
end 

function UILoginScene:_onShopEvent(sender)
    print("您点击了开始游戏按钮")
end 

function UILoginScene:_onRankEvent(sender)
    print("您点击了排行榜按钮")
end 

function UILoginScene:_onAchieveEvent(sender)
    print("您点击了成就按钮")
end 

function UILoginScene:_onMoreEvent(sender)
    print("您点击了其他按钮")
end 

function UILoginScene:_onExitEvent(sender)
    local layer = require("app.views.login.UIQuit"):create()
    self:addChild(layer)
end 

return UILoginScene 
