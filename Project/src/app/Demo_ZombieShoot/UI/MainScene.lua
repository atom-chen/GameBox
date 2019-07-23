-- 登录页面
local MainScene = class("MainScene", function()
    return cc.Scene:create()
end) 

function MainScene:ctor()
    local function onNodeEvent(event)
        if event == "enter" then
            self:init()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function MainScene:init()
    self:_initData()
    self:_initUI() 
end 

function MainScene:_initData()
    self._root = nil            -- 根节点
    self._startBtn = nil        -- 开始按钮
    self._shopBtn = nil         -- 商店按钮
    self._rankBtn = nil         -- 排行榜按钮
    self._achieveBtn = nil      -- 成就按钮
    self._moreBtn = nil         -- 更多按钮
    self._dailyBtn = nil        -- 每日奖励按钮
    self._exitBtn = nil         -- 退出游戏按钮
end 

function MainScene:_initUI()    
    self._root = cc.CSLoader:createNode("res/csd/mainScene.csb")
    self:addChild(self._root)

    local action = cc.CSLoader:createTimeline("res/csd/mainScene.csb")
    self._root:runAction(action)
    action:gotoFrameAndPlay(0, false)

    self._startBtn = ccui.Helper:seekNodeByName(self._root, "Button_start")
    self._shopBtn = ccui.Helper:seekNodeByName(self._root, "Button_Shop")
    self._rankBtn = ccui.Helper:seekNodeByName(self._root, "Button_rank")
    self._achieveBtn = ccui.Helper:seekNodeByName(self._root, "Button_achieve")
    self._moreBtn = ccui.Helper:seekNodeByName(self._root, "Button_more")
    self._dailyBtn = ccui.Helper:seekNodeByName(self._root, "Button_3")
    self._exitBtn = ccui.Helper:seekNodeByName(self._root, "Button_exit")

    BindTouchEvent(self._startBtn, handler(self, self._onStartEvent))
    BindTouchEvent(self._shopBtn, handler(self, self._onShopEvent))
    BindTouchEvent(self._rankBtn, handler(self, self._onRankEvent))
    BindTouchEvent(self._achieveBtn, handler(self, self._onAchieveEvent))
    BindTouchEvent(self._moreBtn, handler(self, self._onMoreEvent))
    BindTouchEvent(self._dailyBtn, handler(self, self._onDaliyEvent))
    BindTouchEvent(self._exitBtn, handler(self, self._onExitEvent))
end 

function MainScene:_onStartEvent(sender)
    local layer = require("app.Demo_ZombieShoot.UI.UISelectRole"):create()
    self:addChild(layer)
end 

function MainScene:_onShopEvent(sender)
    print("您点击了商店按钮")
end 

function MainScene:_onRankEvent(sender)
    MsgTip("您点击了排行榜事件")
end 

function MainScene:_onAchieveEvent(sender)
    local layer = require("app.Demo_ZombieShoot.UI.UIAchieve"):create()
    self:addChild(layer)
end 

function MainScene:_onMoreEvent(sender)
    local layer = require("app.Demo_ZombieShoot.UI.UIMore"):create()
    self:addChild(layer)
end 

function MainScene:_onDaliyEvent(sender)
    print("您点击了每日奖励按钮")
end 

function MainScene:_onExitEvent(sender)
    local layer = require("app.Demo_ZombieShoot.UI.UIQuit"):create()
    self:addChild(layer)
end 

return MainScene 
