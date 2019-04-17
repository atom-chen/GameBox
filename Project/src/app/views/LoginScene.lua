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
end 

function UILoginScene:_initUI()    
    self._root = cc.CSLoader:createNode("res/csd/UILogin.csb")
    self:addChild(self._root)

    self._startBtn = ccui.Helper:seekNodeByName(self._root, "Button_Start")
    self._startBtn:addTouchEventListener(handler(self, self._onClickStartEvent))
end 

function UILoginScene:_onClickStartEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    print("您点击了开始游戏按钮")
end 

return UILoginScene 
