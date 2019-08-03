-- 角色动作基类
-- 用于玩家或敌人通过切换状态来改变动作 共有5种状态，可参考：Fist_Const.ActionState

local RES_PATH = "fistFight/pd_role.plist"
local ACTION = require("app.Demo_FistFight.Fist_Const").ActionState
local Fist_ActionBase = class("Fist_ActionBase", function()
    return cc.Sprite:create()
end)

function Fist_ActionBase:ctor()
    self._idleAction = nil              -- 站立动作
    self._walkAction = nil              -- 走动动作
    self._attackAction = nil            -- 攻击动作           
    self._hurtAction = nil              -- 被攻击动作
    self._dieAction = nil               -- 死亡动作

    self._actionState = ACTION.NONE             -- 状态
    self._walkSpeed = nil                       -- 走动速度
    self._damage = nil                          -- 伤害值
    self._hpNum = 100                           -- 血量

    self:_init()
end 

function Fist_ActionBase:_init()
    local isLoad = cc.SpriteFrameCache:getInstance():isSpriteFramesWithFileLoaded(RES_PATH)
    if not isLoad then 
        cc.SpriteFrameCache:getInstance():addSpriteFrames(RES_PATH)
    end 

    self:initWithSpriteFrameName("hero_idle_00.png")
    self:setTag(100)
end 

-- 站立
function Fist_ActionBase:idle()
    if self._actionState == ACTION.IDLE then 
        return 
    end 
    self._actionState = ACTION.IDLE
    self:stopAllActions()
    self:runAction(self._idleAction)
end 

-- 走动
function Fist_ActionBase:walkWithDirection(direction)
    -- 判定是否为站立状态，若是的话，开始走动
    if self._actionState == ACTION.IDLE then 
        self._actionState = ACTION.WALK
        self:stopAllActions()
        self:runAction(self._walkAction)
    end 

    -- 待处理
    if self._actionState == ACTION.WALK then 
        -- 设定移动相关
    end 
end 

-- 攻击
function Fist_ActionBase:attack()
    print("播放攻击状态", self._actionState)
    -- 判定是否为死亡状态
    if self._actionState == ACTION.NONE or self._actionState == ACTION.DIE then 
        return
    end 
    self._actionState = ACTION.ATTACK
    self:stopAllActions()
    print(tolua.type(self._attackAction))
    print(tolua.isnull(self._attackAction))
    self:runAction(self._attackAction)
end 

-- 被攻击
function Fist_ActionBase:hurtWithDamage(damageNum)

    if self._actionState == ACTION.DIE then 
        return 
    end 
    self._actionState = ACTION.HURT
    self:stopAllActions()
    self:runAction(self._hurtAction)

    -- 避免伤害值不合法
    damageNum = tonumber(damageNum) or 10
    self._HpNum = self._HpNum - damageNum
    if self._HpNum <= 0 then 
        self:die()
    end 
end 

-- 死亡
function Fist_ActionBase:die()
    if self._actionState == ACTION.DIE then 
        return 
    end 
    self._actionState = ACTION.DIE
    self:stopAllActions()
    self:runAction(self._dieAction)
end

return Fist_ActionBase