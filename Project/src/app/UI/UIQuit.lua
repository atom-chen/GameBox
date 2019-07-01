-- 退出游戏
local UIQuit = class("UIQuit", function()
    return newLayerColor(cc.size(display.width, display.height), 120)
end) 

function UIQuit:ctor()
    local function onNodeEvent(event)
        if event == "enter" then
            self:init()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function UIQuit:init()
    local root = cc.CSLoader:createNode("res/csd/UIQuit.csb")
    self:addChild(root)

    -- 确认按钮
    local sureBtn = ccui.Helper:seekNodeByName(root, "Button_1")
    BindTouchEvent(sureBtn, function(sender)
        cc.Director:getInstance():endToLua()
    end)

    -- 取消按钮
    local cancelBtn = ccui.Helper:seekNodeByName(root, "Button_1_0")
    BindTouchEvent(cancelBtn, function(sender)
        self:removeFromParent()
    end)
end 

return UIQuit 
