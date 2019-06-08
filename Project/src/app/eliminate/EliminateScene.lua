-- 消除Demo
local EliminateScene = class("EliminateScene", function()
    return cc.Scene:create()
end) 

function EliminateScene:ctor()
    local root = cc.CSLoader:createNode("res/eliminate/csd/EliminateStart.csb")
    self:addChild(root)

    -- 开始按钮
    local startBtn = root:getChildByName("Button_Play")
    local aboutBtn = root:getChildByName("Button_About")
    local backBtn = root:getChildByName("Button_Back")

    startBtn:addTouchEventListener(handler(self, self._onPlayEvt))
    aboutBtn:addTouchEventListener(handler(self, self._onAboutEvt))   
    backBtn:addTouchEventListener(handler(self, self._onBackEvt))
end 

function EliminateScene:_onPlayEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    local layer = require("app.eliminate.EliminatePlay"):create()
    self:addChild(layer)
end 

function EliminateScene:_onAboutEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    local layer = require("app.eliminate.EliminateAbout"):create()
    self:addChild(layer)
end 

function EliminateScene:_onBackEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 

    local scene = require("app.views.main.MainScene"):create()
    cc.Director:getInstance():replaceScene(scene)
end 

return EliminateScene 
