-- UI控制类
local RES_PATH = "fistFight/UI.plist"
local Fist_UI = class("Fist_UI", function()
    return newLayerColor(cc.size(display.width, display.height), 0)
end)

function Fist_UI:ctor(parent)
    self._parent = parent           -- 场景节点
    self._attackBtn = nil           -- 攻击按钮

    self:_initUI()
end 

function Fist_UI:_initUI()
    local isLoad = cc.SpriteFrameCache:getInstance():isSpriteFramesWithFileLoaded(RES_PATH)
    if not isLoad then 
        cc.SpriteFrameCache:getInstance():addSpriteFrames(RES_PATH)
    end 

    -- 节点相关
    self._roleNode = self._parent:getHeroNode()

    -- 攻击按钮
    self._attackBtn = ccui.Button:create()
    self._attackBtn:loadTextureNormal("button-default.png", UI_TEX_TYPE_PLIST)
    self._attackBtn:loadTexturePressed("button-pressed.png", UI_TEX_TYPE_PLIST)
    self._attackBtn:loadTextureDisabled("button-activated.png", UI_TEX_TYPE_PLIST)
    local attackSize = self._attackBtn:getContentSize()
    self._attackBtn:setPosition(cc.p(display.width - attackSize.width, 50))
    self._attackBtn:addTouchEventListener(handler(self, self._attackEvent))
    self:addChild(self._attackBtn)
end 

-- 攻击事件
function Fist_UI:_attackEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    self._roleNode:attack()
end 

return Fist_UI
