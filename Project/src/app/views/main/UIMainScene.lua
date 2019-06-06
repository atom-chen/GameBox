-- 大厅页面

local UIMainScene = class("UIMainScene", function()
    return cc.Scene:create()
end) 

function UIMainScene:ctor()
    local function onNodeEvent(event)
        if event == "enter" then
            self:init()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function UIMainScene:init()
    self:_initData()
    self:_initUI()
end 

function UIMainScene:_initData()
    self._debugDemoBtn = nil            -- 示例代码按钮
    self._soldierDemoBtn = nil            -- 飞机Demo按钮
    self._eliminateDemoBtn = nil        -- 钻石消除Demo按钮
end 

function UIMainScene:_initUI()
    self._root = cc.CSLoader:createNode("res/csd/UIHall.csb")
    self:addChild(self._root)

    self._debugDemoBtn = ccui.Helper:seekNodeByName(self._root, "Button_Debug")
    self._soldierDemoBtn = ccui.Helper:seekNodeByName(self._root, "Button_phone")
    self._eliminateDemoBtn = ccui.Helper:seekNodeByName(self._root, "Button_Diamond")

    self._debugDemoBtn:addTouchEventListener(handler(self, self._onDebugDemoEvt))
    self._soldierDemoBtn:addTouchEventListener(handler(self, self._onSoldierDemoEvt))
    self._eliminateDemoBtn:addTouchEventListener(handler(self, self._onEliminateDemoEvt))
end 

function UIMainScene:_onDebugDemoEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    local testScene = require("app.personTest.TestScene"):create()
    cc.Director:getInstance():replaceScene(testScene)
end 

function UIMainScene:_onSoldierDemoEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    
    local _scene = nil 
end 

function UIMainScene:_onEliminateDemoEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    local testScene = require("app.eliminate.EliminateScene"):create()
    cc.Director:getInstance():replaceScene(testScene)
end 

return UIMainScene 
