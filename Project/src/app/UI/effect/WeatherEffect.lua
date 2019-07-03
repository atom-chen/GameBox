--[[
天气效果
1. 若天气类型为 NONE， 等级类型不为 NONE, 表示阴天
2. 若天气类型为雷雨， 等级类型默认为 MID
3. 若天气类型为雷暴，等级类型默认为 BIG 
]]

local weatherType = {
    NONE = 0,               -- 无
    RAIN = 1,               -- 雨
    SNOW = 2,               -- 雪
    SLEET = 3,              -- 雨夹雪
    THUNDER = 4,            -- 雷
    THUNDER_RAIN = 5,       -- 雷雨
    THUNDER_STORM = 6,      -- 雷暴

    STAR = 7,               -- 繁星
    METEOR = 8,             -- 流星
}

local levelType = {
    NONE = 0,       -- 无
    SMALL = 1,      -- 小
    MID = 2,        -- 中
    BIG = 3,        -- 大
}

local WeatherEffect = class("WeatherEffect", function()
    return newLayerColor(cc.size(display.width, display.height), 0)
end)

function WeatherEffect:ctor()
    self._snow = nil                -- 雪
    self._rain = nil                -- 雨
end 

-- 初始化下雨
function WeatherEffect:_initRain()
    local texture = cc.Director:getInstance():getTextureCache():addImage("effect/snow.png")

	local emitter = cc.ParticleRain:create()
    emitter:setPosition(cc.p(display.width/2, display.height - 100))
    emitter:setTexture(texture)
    emitter:setSpeed(160)
    emitter:setSpeedVar(30)
    emitter:setLife(4)
    self:addChild(emitter, 10)
end 

-- 初始化繁星
function WeatherEffect:_initStar()
    local texture = cc.Director:getInstance():getTextureCache():addImage("effect/fire.png")

    --local emitter = cc.ParticleGalaxy:create()   -- 星系效果
    local emitter = cc.ParticleMeteor:create()     -- 流星效果
    local emitter = cc.ParticleSmoke:create()     -- 烟雾效果
    local emitter = cc.ParticleSun:create()       -- 太阳效果
    emitter:setTexture(texture)
    self:addChild(emitter, 10)
end 

-- 初始化雪
function WeatherEffect:_initSnow()
    local texture = cc.Director:getInstance():getTextureCache():addImage("effect/snow.png")

    local emitter = cc.ParticleSnow:create()
    emitter:setPosition(cc.p(display.width/2, display.height - 100))
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
    local pos1 = cc.p(100, display.height/2)
    local pos2 = cc.p(display.width - 100, display.height/2)

    self._drawNode = cc.DrawNode:create()
    self:_drawThunder(pos1.x, pos1.y, pos2.x, pos2.y, 200)
    self:addChild(self._drawNode, 10)
end

function WeatherEffect:_drawThunder(x1, y1, x2, y2, displace)
    if displace < self.curDetail then 
        self._drawNode:drawLine(cc.p(x1,y1), cc.p(x2, y2), cc.c4f(1,1,0,1))
    else 
        local mid_x = (x1 + x2)/2
        local mid_y = (y1 + y2)/2
        mid_x = mid_x + (math.random() - 0.5) * displace
        mid_y = mid_y + (math.random() - 0.5) * displace
        self:_drawThunder(x1, y1, mid_x, mid_y, displace/2)
        self:_drawThunder(x2, y2, mid_x, mid_y, displace/2)
    end 
end 

--[[
@function: 显示指定类型的天气
@pram: 天气类型， 参考 weatherType
@pram: 天气程度，参考 levelType
@pram: 是否播放气象效果
]]
function WeatherEffect:Show(weather,level, isPlay)
    --self:_initSnow()
    self:_initThunder()
end 

return WeatherEffect
