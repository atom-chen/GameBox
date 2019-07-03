
--[[
-- 创建新的环境newgt
local newgt = {}
-- newgt 继承了原有的 _G 的环境变量 
-- 这样任何新的赋值操作可在 newgt 中进行，不用担心误操作了全局变量表
setmetatable(newgt, {__index = _G})
setfenv(1, newgt)
]]


cc.exports.ENUM = {}

-- 英雄类型
ENUM.HERO_ZOMBIE = 0            -- 僵尸克星
ENUM.HERO_TAIJI = 1             -- 太极之子
ENUM.HERO_ROBOT = 2             -- 机械战神

-- 英雄数目
ENUM.HERO_MAXNUM = 3            -- 英雄数目

-- 武器类型
ENUM.WEAPON_GUN = 1             -- 枪
ENUM.WEAPON_KNIFE = 2           -- 刀
ENUM.WEAPON_BOMB = 3            -- 手榴弹

-- 章数目
ENUM.CHAPTER_NUM = 6            -- 章数目

return ENUM