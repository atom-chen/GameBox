--[[
    子弹类，不同的英雄有不同的子弹
]]

local Bullet = class("Bullet")

-- 创建, 可参考：GrenadeCreate
function Bullet:create()
    --
end 

-- 移动
function Bullet:Move()
    -- 注意监测是否碰撞到地面
    -- 注意监测是否掉落地面下
    -- 注意监测是否碰撞到怪物
end 

-- 销毁
function Bullet:Remove()
    -- 删除动作
    -- 删除Node
end 

return Bullet
