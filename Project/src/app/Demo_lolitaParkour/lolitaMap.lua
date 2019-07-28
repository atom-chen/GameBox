-- 地图类

local lolitaMap = class("lolitaMap", function()
    return cc.Node:create()
end)

function lolitaMap:ctor() 
    self._bgSpr = {}
    --[[
    -- 后背景相关
    local backSpr = cc.Sprite:create("lolitaParkour/bg_1.png")
    backSpr:setAnchorPoint(cc.p(0,0))

    -- 中背景相关
    local midSpr = cc.Sprite:create("lolitaParkour/bg_2.png")
    midSpr:setAnchorPoint(cc.p(0,0))

    local voidNode = cc.ParallaxNode:create()
    voidNode:addChild(backSpr, -2, cc.p(0.4, 0.5), cc.p(0,0))
    voidNode:addChild(midSpr, -1, cc.p(0.4, 0.5), cc.p(0,0))

    local goUp = cc.MoveBy:create(10,cc.p(-500, 0))
    local goDown = goUp:reverse()
    local seq = cc.Sequence:create(goUp, goDown)
    voidNode:runAction((cc.RepeatForever:create(seq)))

    self:addChild(voidNode)
    ]]


    local backSpr = cc.Sprite:create("lolitaParkour/bg_1.png")
    backSpr:setPosition(display.center)
    self:addChild(backSpr)

    local midSpr = cc.Sprite:create("lolitaParkour/bg_2.png")
    midSpr:setPosition(display.center)
    self:addChild(midSpr)
end 



return lolitaMap