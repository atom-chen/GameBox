--[[
英雄类, 使用cocos 自带的骨骼动画资源吧，否则调整主角UI存在问题太多了
]]

-- 枪械资源
local gunRes = {
    "qiangqiang7.png", "qiangqiang8.png", "qiangqiang9.png", "qiangqiang11.png",
	"qiangqiang12.png", "qiangqiang13.png", "qiangqiang14.png", "qiangqiang15.png", 
	"qiangqiangfire.png", 
}
local GUN_MAXNUM = #gunRes

-- 刀具资源
local knifeRes = {"tulongdao2.png", "tulongdao111.png", "kaishanfu111.png"}
local KNIFE_MAXNUM = #knifeRes

-- 英雄动作
local ACTION = {
    NONE = 0,               -- 站立
    RUN = 1,                -- 跑动
    JUMP_1 = 2,             -- 跳跃1
    JUMP_2 = 3,             -- 跳跃2
    ROLL = 4,               -- 滚动 
    SHOOT = 5,              -- 射击
    KNIFT_STAND = 6,        -- 拿着刀站立
    KNIFT_RUN = 7,          -- 拿着刀跑动
    KNIFT_ATTACK = 8,       -- 拿着刀攻击
    KNIFT_BE_ATTACK = 13,   -- 拿着刀被攻击
    GUN_BE_ATTACK = 12,     -- 拿着枪被攻击
}

-- 英雄移动间隔
local MOVE_OFFSET_X = 10

local Hero = class("Hero")
function Hero:ctor(parent)
    self._parent = parent 
    self._hero = nil            -- 英雄节点
    self._heroType = nil        -- 英雄类型(0~2)
    self._rotation = nil        -- 翻转类型(1-脸向右，2-脸向左)
    self._bAttack = false       -- 是否可攻击
    self._bIsMove = false       -- 是否在移动中
    self._dirIndex = 1          -- 玩家方向： -1 向左  1 向右

    -- 
    self._bomb = nil            -- 手雷
    self._bombIsMove = false    -- 手雷是否在移动中
    -- 
    self._gunIndex = 1          -- 枪械选择索引
    self._knifeIndex = 1        -- 刀具选择索引

    --
    self._bulletCache = {}
    self.playIndex = 1
end 

-- 创建英雄
function Hero:CreateHero(_heroType)
    _heroType = _heroType or ENUM.HERO_ZOMBIE
    self._heroType = _heroType
    local ArmatureMgr = ccs.ArmatureDataManager:getInstance()
    if _heroType == ENUM.HERO_ZOMBIE then 
        ArmatureMgr:addSpriteFrameFromFile("zhujiao_1.plist", "zhujiao_1.png")
        ArmatureMgr:addArmatureFileInfo("zhujiao.png", "zhujiao.plist", "zhujiao.json")
        ArmatureMgr:addArmatureFileInfo("qiangqiang.png", "qiangqiang.plist", "qiangqiang.json")
        ArmatureMgr:addArmatureFileInfo("tulongdao.png", "tulongdao.plist", "tulongdao.json")
    elseif _heroType == ENUM.HERO_TAIJI then 
        ArmatureMgr:addArmatureFileInfo("zhujiao2.png", "zhujiao2.plist", "zhujiao2.json")
        ArmatureMgr:addArmatureFileInfo("qiangqiang2.png", "qiangqiang2.plist", "qiangqiang2.json")
        ArmatureMgr:addArmatureFileInfo("tulongdao2.png", "tulongdao2.plist", "tulongdao2.json")
    end 

    -- 创建英雄
    if _heroType == ENUM.HERO_ZOMBIE then 
        self._hero = ccs.Armature:create("dongzuo1")
    else 
        self._hero = ccs.Armature:create("dongzuo")
    end 
    -- 设置动画播放速率
    self._hero:getAnimation():setSpeedScale(0.5)
    -- 设置英雄站立
    self._hero:getAnimation():playWithIndex(ACTION.NONE)
    -- 设置英雄位置
    self._hero:setPosition(cc.p(100, 120))
    -- 将英雄添加到地图节点中
    self._parent:getMapUI():getFrontMap():addChild(self._hero, 4)

    -- 创建枪械，道具(机器人是没有切换武器的)
    if _heroType ~= ENUM.HERO_ROBOT then 
        -- 获取手的骨骼节点
        local handBone = self._hero:getBone("shou1")
        handBone:setScale(1.25)
        for i, name in ipairs(gunRes) do 
            local skin = ccs.Skin:createWithSpriteFrameName(name)
            handBone:addDisplay(skin, i-1)
        end 

        -- 获取刀的骨骼节点
        local knifeBone = self._hero:getBone("dao")
        for i, name in ipairs(knifeRes) do 
            local skin = ccs.Skin:createWithSpriteFrameName(name)
            knifeBone:addDisplay(skin, i-1)
        end 
    end
end 

-- 改变武器
function Hero:ChangeWeapon(changeType)
    -- 判定英雄类型
    if self._heroType == ENUM.HERO_ROBOT then 
        return 
    end 

    -- 先使用测试数据
    changeType = changeType or "GUN" 
    math.newrandomseed()

    if changeType == "GUN" then 
        -- 获取手的骨骼节点
        local handBone = self._hero:getBone("shou1")
        -- 根据索引改变显示内容
        self._gunIndex = math.random(1, GUN_MAXNUM-1)
        handBone:changeDisplayWithIndex(self._gunIndex, true)
        -- 播放英雄动作
        self._hero:getAnimation():playWithIndex(ACTION.SHOOT)
    elseif changeType == "KNIFE" then 
        -- 获取刀的骨骼节点
        local knifeBone = self._hero:getBone("dao")
        -- 根据索引改变显示内容
        self._knifeIndex = math.random(1, KNIFE_MAXNUM-1)
        knifeBone:changeDisplayWithIndex(self._knifeIndex, true)
        self._hero:getAnimation():playWithIndex(ACTION.KNIFT_STAND)
    end 
end 

-- 英雄移动
-- @pram: -1 向左 1 像右
function Hero:StartMove(direction)
    if direction < 0 then 
        direction = -1
        self._hero:setScaleX(direction)
    else 
        direction = 1
        self._hero:setScaleX(direction)
    end 

    local heroposx = self._hero:getPositionX()
    heroposx = heroposx + MOVE_OFFSET_X * direction
    self._hero:setPositionX(heroposx)

    if not self._bIsMove then 
        self._bIsMove = true 
        self._dirIndex  = direction
        self._hero:getAnimation():playWithIndex(ACTION.RUN)
        self._hero:getAnimation():setSpeedScale(0.45)
    end 
end 

-- 停止移动
function Hero:StopMove()
    self._hero:getAnimation():playWithIndex(ACTION.NONE)
    self._hero:getAnimation():setSpeedScale(0.5)
    self._bIsMove = false 
end 

-- 英雄射击
function Hero:StartShoot()
    local bullet = cc.Sprite:create("art/role/bullet/bullet_0.png")
    bullet:setPosition(cc.p(14, 52))
    self._hero:addChild(bullet)

    -- 子弹移动
    local bulletSize = bullet:getContentSize()
    local act1 = cc.MoveBy:create(2.0, cc.p(display.width + bulletSize.width, 0))
    local act2 = cc.CallFunc:create(function()
        bullet:removeFromParent()
    end)
    local action = cc.Sequence:create(act1, act2)
    bullet:runAction(action)
    -- 
    self._hero:getAnimation():playWithIndex(ACTION.SHOOT)
end 

-- 英雄跳跃
function Hero:StartJump()
    local heroposx, heroposy = self._hero:getPosition()
    local len = 100                                                         -- 跳跃长度
    local startpos = cc.p(heroposx, heroposy)                               -- 起始点
    local endpos = cc.p(heroposx + 200 * self._dirIndex, heroposy)          -- 结束点
    local height = 30                                                       -- 高度
    local angle = 40                                                        -- 角度

    -- 将角度转换为弧度
    local radian = angle * math.pi/180
    -- 第一个控制点
    local point1_x = startpos.x + len/4
    local point1 = cc.p(point1_x, height + startpos.y + math.cos(radian) * point1_x)
    -- 第二个控制点
    local point2_x = startpos.x + len/2
    local point2 = cc.p(point2_x, height + startpos.y + math.cos(radian) * point2_x)

    -- 曲线配置
    local MOVETIME = 0.8
    local bezier = {point1, point2, endpos}
    local act1 = cc.BezierTo:create(MOVETIME, bezier)
    local act2 = cc.CallFunc:create(function()
        -- 设定英雄新位置
        self._hero:setPosition(endpos)
        -- 设定英雄站立
        self._hero:getAnimation():playWithIndex(ACTION.NONE)
    end)
    
    local action = cc.Sequence:create(act1, act2)
    self._hero:runAction(action)
    self._hero:getAnimation():playWithIndex(ACTION.ROLL)
end

-- 暂停英雄
function Hero:PauseHero()
    self._hero:getAnimation():pause()
end 

-- 恢复英雄
function Hero:ResumeHero()
    self._hero:getAnimation():resume()
end 

-- 获取翻转类型
function Hero:getRotationType()
    return self._rotation
end 

-- 获取英雄节点
function Hero:getHeroNode()
    return self._hero
end 

------------------------------------------------------------------------
-- 创建手雷
function Hero:GrenadeCreate()
    local _bomb = cc.Sprite:create("art/role/bomb/grenade_bomb1.png")
    _bomb:setPosition(cc.p(14, 52))
    self._hero:addChild(_bomb)
    self:GrenadeMove(_bomb)
end 

-- 手雷移动
function Hero:GrenadeMove(node)
    local bombposx, bombposy = node:getPosition()
    local len = 200                                         -- 长度
    local startpos = cc.p(bombposx, bombposy)               -- 起始点
    local endpos = cc.p(bombposx + 200, 50)                 -- 结束点
    local height = 50                                       -- 高度
    local angle = 60                                        -- 角度

    -- 将角度转换为弧度
    local radian = angle * math.pi/180
    -- 第一个控制点
    local point1_x = startpos.x + len/4
    local point1 = cc.p(point1_x, height + startpos.y + math.cos(radian) * point1_x)
    -- 第二个控制点
    local point2_x = startpos.x + len/2
    local point2 = cc.p(point2_x, height + startpos.y + math.cos(radian) * point2_x)

    -- 曲线配置
    local MOVETIME = 1.5                        -- 移动时间
    local bezier = {point1, point2, endpos}
    local act1 = cc.BezierTo:create(MOVETIME, bezier)
    local act2 = cc.RotateBy:create(MOVETIME, 360 * 3)
    local act3 = cc.Spawn:create(act1, act2)
    local act4 = cc.CallFunc:create(function()
        -- 播放爆炸动画
        self:GrenadeBomb(node)
    end)
    
    local action = cc.Sequence:create(act3, act4)
    node:runAction(action)
end

-- 手雷爆炸动画
function Hero:GrenadeBomb(node)
    local animation = cc.Animation:create()
    for i = 1, 6 do 
        local strName = string.format("art/role/bomb/grenade_%d.png", i)
        animation:addSpriteFrameWithFile(strName) 
    end 
    -- 设置两帧之间的播放时间
    animation:setDelayPerUnit(0.15)
    -- 设置动画播放后还原到初始状态
    animation:setRestoreOriginalFrame(true)

    local action1 = cc.Animate:create(animation)
    local action2 = cc.CallFunc:create(function()
        self:GrenadeDel(node)
    end)
    local action = cc.Sequence:create(action1, action2)

    node:runAction(action)
end 

-- 手雷销毁
function Hero:GrenadeDel(node)
    self._bombIsMove = false 

    if node ~= nil then 
        node:stopAllActions()
        node:removeFromParent()
    end     
end 

------------------------------------------------------------------------
-- 检测是否与地面接触 CheckInWall
function Hero:_checkInWall()
    return false 
end 

-- 检测是否与怪物碰撞
function Hero:_checkInMonster()
    return false 
end 

-- 检测玩家是否被攻击
function Hero:_checkBeAttack()
    return false 
end 

return Hero