--[[
手雷类，不同的英雄有不同的手雷
]]

local Grenade = class("Grenade")

-- 创建手雷, 可参考：GrenadeCreate
function Grenade:create()
    --
end 

-- 手雷移动
function Grenade:Move()
    -- 注意监测是否碰撞到地面
    -- 注意监测是否掉落地面下
    -- 注意监测是否碰撞到怪物
end 

-- 手雷爆炸
function Grenade:Bomb()
    --
end 

-- 手雷销毁
function Grenade:Remove()
    -- 删除动作
    -- 删除Node
end 

return Grenade
