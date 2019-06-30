--[[
英雄类，可参考Hero.h/Hero.cpp,  
]]

local Hero = class("Hero")

function Hero:ctor()
    self._hero = nil            -- 英雄节点
    self._rotation = nil        -- 翻转类型(1-脸向右，2-脸向左)
    self._bAttack = false       -- 是否可攻击
end 

-- 创建英雄
function Hero:CreateHero(data)
    --[[
    数据data中包含数据为:
        heroType: 英雄类型
        gunType: 枪械类型
        knifeType: 刀类型
        grenadeType: 手雷类型
    ]]

    -- 创建英雄，并初始化指定位置
    -- 创建武器，默认枪械
end 

-- 改变武器类型
function Hero:ChangeWeapon(changeType)
    --[[
    changeType的参数有：
        GUN: 修改为枪械
        KNIFE: 修改为刀具
        GRENADE: 修改为拿手雷
    ]]
end 

-- 监测玩家攻击
function Hero:AttackCheck()
    --
end 

-- 播放指定类型的动作
function Hero:playHeroAction(type, _frame)
    -- 比如射击
    -- 比如跳跃
    -- 比如使用手雷
end 

-- 暂停英雄
function Hero:PauseHero()
    -- 主要用于暂停游戏中使用，暂停英雄的动作相关
end 

-- 恢复英雄
function Hero:ResumeHero()
    -- 主要用于恢复游戏中使用
end 

-- 获取翻转类型
function Hero:getRotationType()
    return self._rotation
end 

return Hero