-- 角色类
local super = require("app.Demo_FistFight.Fist_ActionBase")
local Fist_Role = class("Fist_Role", super)

function Fist_Role:ctor()
    print("初始化 Fist_Role ctor。。。。。")
    self.super.ctor(self)

    --self:_initAction()
end 

function Fist_Role:_initAction()
    -- idle
    local aniFrames = {}
    for i = 1, 6 do 
        local strName = string.format("hero_idle_%02d.png", i-1)
        aniFrames[i] = cc.SpriteFrameCache:getInstance():getSpriteFrame(strName)
    end 
    local animation = cc.Animation:createWithSpriteFrames(aniFrames, 1.0/12)
    self._idleAction = cc.RepeatForever:create(cc.Animate:create(animation))
    
    -- walk
    -- attack
    -- hurt 
    -- die
end 

return Fist_Role