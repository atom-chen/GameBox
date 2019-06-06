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
    local size = root:getContentSize()
    root:setPosition(cc.p((display.width-size.width)/2, (display.height-size.height)/2))
    self:addChild(root)

    -- 确认按钮
    local sureBtn = ccui.Helper:seekNodeByName(root, "Button_1")
    ButtonTouchEvent(sureBtn, function(sender)
        cc.Director:getInstance():endToLua()
    end)

    -- 取消按钮
    local cancelBtn = ccui.Helper:seekNodeByName(root, "Button_1_0")
    ButtonTouchEvent(cancelBtn, function(sender)
        self:removeFromParent()
    end)
end 

return UIQuit 
