-- 大厅页面

local UIMainScene = class("UIMainScene", function()
    return cc.CSLoader:createNode("res/csd/UILogin.csb")
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
    self._phoneDemoBtn = nil            -- 飞机Demo按钮
    self._eliminateDemoBtn = nil        -- 钻石消除Demo按钮
end 

function UIMainScene:_initUI()
    self._debugDemoBtn = ccui.Helper:seekNodeByName(self, "Button_Debug")
    self._phoneDemoBtn = ccui.Helper:seekNodeByName(self, "Button_phone")
    self._EliminateDemoBtn = ccui.Helper:seekNodeByName(self, "Button_Diamond")

    self._debugDemoBtn:addTouchEventListener(handler(self, self._onDebugDemoEvt))
    self._phoneDemoBtn:addTouchEventListener(handler(self, self._onPhoneDemoEvt))
    self._eliminateDemoBtn:addTouchEventListener(handler(self, self._onEliminateDemoEvt))
end 

function UIMainScene:_onDebugDemoEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    print("您点击了个人示例按钮")
end 

function UIMainScene:_onPhoneDemoEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    print("您点击了phone示例按钮")
end 

function UIMainScene:_onEliminateDemoEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 

    print("您点击了Eliminate示例按钮")
end 

return UIMainScene 