--[[
英雄类，可参考Hero.h/Hero.cpp,  
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

local Hero = class("Hero")
function Hero:ctor(parent)
    self._parent = parent 
    self._hero = nil            -- 英雄节点
    self._heroType = nil        -- 英雄类型(0~2)
    self._rotation = nil        -- 翻转类型(1-脸向右，2-脸向左)
    self._bAttack = false       -- 是否可攻击

    self._gunIndex = 1          -- 枪械选择索引
    self._knifeIndex = 1        -- 刀具选择索引
end 

-- 创建英雄
function Hero:CreateHero(_heroType)
    local _heroType = _heroType or 0
    self._heroType = _heroType
    local ArmatureMgr = ccs.ArmatureDataManager:getInstance()
    if _heroType == 0 then 
        ArmatureMgr:addSpriteFrameFromFile("zhujiao_1.plist", "zhujiao_1.png")
        ArmatureMgr:addArmatureFileInfo("zhujiao.png", "zhujiao.plist", "zhujiao.json")
        ArmatureMgr:addArmatureFileInfo("qiangqiang.png", "qiangqiang.plist", "qiangqiang.json")
        ArmatureMgr:addArmatureFileInfo("tulongdao.png", "tulongdao.plist", "tulongdao.json")
    elseif _heroType == 1 then 
        ArmatureMgr:addArmatureFileInfo("zhujiao2.png", "zhujiao2.plist", "zhujiao2.json")
        ArmatureMgr:addArmatureFileInfo("qiangqiang2.png", "qiangqiang2.plist", "qiangqiang2.json")
        ArmatureMgr:addArmatureFileInfo("tulongdao2.png", "tulongdao2.plist", "tulongdao2.json")
    elseif _heroType == 2 then 
        ArmatureMgr:addArmatureFileInfo("bot.png", "bot.plist", "bot.json")
        ArmatureMgr:addSpriteFrameFromFile("bot1.plist", "bot1.png")
    end 

    -- 创建英雄
    if _heroType == 0 then 
        self._hero = ccs.Armature:create("dongzuo1")
    else 
        self._hero = ccs.Armature:create("dongzuo")
    end 
    
    self._hero:setPosition(cc.p(100, 120))
    self._parent:getMapNode():addChild(self._hero, 4)

    -- 创建枪械，道具(机器人是没有切换武器的)
    if _heroType ~= 2 then 
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
    self:ChangeWeapon()
    --self:playHeroAction(1)
end 

-- 改变武器，刀具类型
function Hero:ChangeWeapon(changeType)
    -- 判定英雄类型
    if self._heroType == 2 then 
        return 
    end 

    -- 先使用测试数据
    changeType = changeType or "GUN" 
    math.newrandomseed()

    if changeType == "GUN" then 
        local handBone = self._hero:getBone("shou1")
        self._gunIndex = math.random(1, GUN_MAXNUM-1)
        handBone:changeDisplayWithIndex(self._gunIndex, true)
    elseif changeType == "KNIFE" then 
        local knifeBone = self._hero:getBone("dao")
        self._knifeIndex = math.random(1, KNIFE_MAXNUM-1)
        knifeBone:changeDisplayWithIndex(self._knifeIndex, true)
    end 
end 

-- 监测玩家攻击
function Hero:AttackCheck()
    --
end 

-- 播放指定类型的动作
function Hero:playHeroAction(_type, _frame)
    _frame = _frame or 10
    self._hero:getAnimation():playWithIndex(_type, 0,_frame)
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

return Hero