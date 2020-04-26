-- Test的基类

local BaseTest = class("BaseTest", function()
    return cc.LayerColor:create(cc.c4b(0,100,100,255), display.width, display.height)
end)

function BaseTest:ctor()
    print("BaseTest:ctor...")
    self:_initBaseUI()
    self:initUI()
end 

function BaseTest:initUI()
    print("BaseTest:initUI...")
end 

function BaseTest:_initBaseUI()
    -- 返回按钮相关
    local backBtn = ccui.Button:create(Res.BTN_N, Res.BTN_P, Res.BTN_D)
    backBtn:setPosition(cc.p(display.width - 30, 30))
    backBtn:setTitleFontSize(18)
    backBtn:setTitleColor(cc.c3b(0,0,0))
    backBtn:setTitleText("返 回")
    backBtn:addTouchEventListener(handler(self, self._onRemoveEvent))
    self:addChild(backBtn)
end 

function BaseTest:_onRemoveEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return     
    end 

    -- 删除UI
    self:removeFromParent()
    AudioEngine.stopMusic()
end 

return BaseTest