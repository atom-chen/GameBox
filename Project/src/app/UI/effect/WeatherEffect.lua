--[[
天气效果
1. 若天气类型为 NONE， 等级类型不为 NONE, 表示阴天
2. 若天气类型为雷雨， 等级类型默认为 MID
3. 若天气类型为雷暴，等级类型默认为 BIG 
]]

local TYPE = {
    NONE = 0,               -- 无
    RAIN = 1,               -- 雨
    SNOW = 2,               -- 雪
    THUNDER = 4,            -- 雷
}

local LEVEL = {
    NONE = 0,       -- 无
    SMALL = 1,      -- 小
    MID = 2,        -- 中
    BIG = 3,        -- 大
}

local WeatherEffect = class("WeatherEffect", function()
    return cc.LayerColor:create(cc.c4b(0,0,0,0),display.width,display.height)
end)

function WeatherEffect:ctor()
    self:_initData()
    local function onNodeEvent(event)
        if event == "enter" then
            --self:onEnter()
        elseif event == "exit" then 
            self:onExit()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function WeatherEffect:_initData()
    self._snow = nil                -- 雪
    self._rain = nil                -- 雨

    self._thunderScheduler = nil    
end 

-- 播放气象效果
function WeatherEffect:_playWeatherColorAni(level)
    do return end 
    level = level or LEVEL.NONE
    -- 设置透明度
    local opacityTab = {0,100,120,200}
    self:setOpacity(opacityTab[level + 1])
end 

-- 初始化下雨
function WeatherEffect:_initRain(level)
    local texture = cc.Director:getInstance():getTextureCache():addImage("effect/snow.png")
    local emitter = cc.ParticleRain:create()
    emitter:setPosition(cc.p(display.width/2, display.height - 100))
    emitter:setTexture(texture)

    local _totalNum = 100           -- 最大粒子数目
    local _speed = 100              -- 速度
    local _speedVar = 0             -- 
    local _life = 4                 -- 
    local _rate = 250               -- 发射粒子间隔
    if level == LEVEL.SMALL then 
        _totalNum = 100
        _speed = 100
        _speedVar = 10
        _rate = 50
    elseif level == LEVEL.MID then 
        _totalNum = 500
        _speed = 130
        _speedVar = 20
        _rate = 150
    elseif level == LEVEL.BIG then 
        _totalNum = emitter:getTotalParticles()
        _speed = emitter:getSpeed()
        _speedVar = emitter:getSpeedVar()
        _rate = 250
    end 
    emitter:setEmissionRate(_rate)
    emitter:setTotalParticles(_totalNum)
    emitter:setSpeed(_speed)
    emitter:setSpeedVar(_speedVar)
    emitter:setLife(_life)

    self:addChild(emitter, 10)
end 

-- 初始化雪
function WeatherEffect:_initSnow()
    local texture = cc.Director:getInstance():getTextureCache():addImage("effect/snow.png")

    local emitter = cc.ParticleSnow:create()
    emitter:setPosition(cc.p(display.width/2, display.height))
    emitter:setTexture(texture)
    self:addChild(emitter, 10)
    
    emitter:setLife(3)
    emitter:setLifeVar(1)

    -- gravity
    emitter:setGravity(cc.p(0, -10))

    -- speed of particles
    emitter:setSpeed(130)
    emitter:setSpeedVar(30)

    local startColor = emitter:getStartColor()
    startColor.r, startColor.g, startColor.b = 0.9, 0.9, 0.9
    emitter:setStartColor(startColor)

    local startColorVar = emitter:getStartColorVar()
    startColorVar.b = 0.1
    emitter:setStartColorVar(startColorVar)

    emitter:setEmissionRate(emitter:getTotalParticles() / emitter:getLife())
end 

-- 初始化雷电
function WeatherEffect:_initThunder()
    self.curDetail = 5
    self._count = 0
    local pos1 = cc.p(100, display.height/2)
    local pos2 = cc.p(display.width - 100, display.height/2)

    self._drawNode = cc.DrawNode:create()
    self:addChild(self._drawNode, 10)

    --[[
    local Scheduler = cc.Director:getInstance():getScheduler()
    local delayTime = 0.1
    local function update()
        self:_drawThunder(pos1.x, pos1.y, pos2.x, pos2.y, 200)
    end 
    self._thunderScheduler = Scheduler:scheduleScriptFunc(update, 0.05, false)
    ]]
    self:_drawThunder(pos1.x, pos1.y, pos2.x, pos2.y, 200)
end 

function WeatherEffect:_drawThunder(x1, y1, x2, y2, displace)
    if displace < self.curDetail then 
        self._drawNode:drawSegment(cc.p(x1,y1), cc.p(x2, y2), 1, cc.c4f(1,1,0,1))
    else 
        local mid_x = (x1 + x2)/2
        local mid_y = (y1 + y2)/2
        mid_x = mid_x + (math.random() - 0.5) * displace
        mid_y = mid_y + (math.random() - 0.5) * displace
        self:_drawThunder(x1, y1, mid_x, mid_y, displace/2)
        self:_drawThunder(x2, y2, mid_x, mid_y, displace/2)
    end 
end 

-- 初始化雷电动画
function WeatherEffect:_initThunderAni(level)
    -- 添加图片播放闪烁动画，然后消失即可
end 

-- 初始化繁星
function WeatherEffect:_initSun()
    local texture = cc.Director:getInstance():getTextureCache():addImage("effect/fire.png")
    local emitter = cc.ParticleSun:create()       -- 太阳效果
    emitter:setTexture(texture)
    self:addChild(emitter, 10)
end 

-- 初始化繁星
function WeatherEffect:_initStar(level)
    local texture = cc.Director:getInstance():getTextureCache():addImage("effect/fire.png")
    local emitter = cc.ParticleGalaxy:create()
    emitter:setTexture(texture)
    self:addChild(emitter, 10)
end 

-- 初始化流星
function WeatherEffect:_initMeteor(level)
    local texture = cc.Director:getInstance():getTextureCache():addImage("effect/fire.png")
    local emitter = cc.ParticleMeteor:create()
    emitter:setTexture(texture)
    self:addChild(emitter, 10)
end 

-- 初始化云
function WeatherEffect:_initCloud(level)
    local texture = cc.Director:getInstance():getTextureCache():addImage("effect/fire.png")
    local emitter = cc.ParticleSmoke:create()
    emitter:setTexture(texture)
    self:addChild(emitter, 10)
end 

--[[
@function: 显示指定类型的天气
@pram: 天气类型， 参考 weatherType
@pram: 天气程度，参考 levelType, 默认为SMALL
@pram: 是否播放气象效果, 默认为false
]]
function WeatherEffect:onEnter(_type,level,isPlay)
    if _type == TYPE.RAIN then 
        -- 雨
        self:_initRain(level)
    elseif _type == TYPE.SNOW then 
        -- 雪
        self:_initSnow(level)
    elseif _type == TYPE.THUNDER then 
        -- 雷
        self:_initThunderAni()
    end 

    -- 播放气象效果, 天气类型不可为NULL
    if _type ~= TYPE.NONE and isPlay then 
        self:_playWeatherColorAni(level)
    end 
end 

function WeatherEffect:onExit()
    if self._thunderScheduler ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._thunderScheduler)
        self._thunderScheduler = nil
    end
end 

return WeatherEffect

--[[
local layer = require("app.UI.effect.WeatherEffect"):create()
    self:addChild(layer,1)

    layer:onEnter(2,3)
]]
