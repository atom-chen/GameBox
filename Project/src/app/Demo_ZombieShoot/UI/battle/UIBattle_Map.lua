-- 战斗地图UI

-- 移动
local BACK_OFFSETX = 1.0
local MID_OFFSETX = 2
local FRONT_OFFSETX = 3

local UIBattle_Map = class("UIBattle_Map")
function UIBattle_Map:ctor(parent, eachId) 
    self._parent = parent
    self._eachId = eachId

    self._backSpr = {}
    self._midMap = nil 
    self._frontMap = nil 

    self:_initMap()
end 

-- 初始化地图
function UIBattle_Map:_initMap()
    -- 后
    self._backSpr[1] = cc.Sprite:create("Tile/beijing4.png")
    self._backSprSize = self._backSpr[1]:getContentSize()
    self._backSpr[1]:setAnchorPoint(cc.p(0.5, 0.5))
    self._backSpr[1]:setPosition(cc.p(display.width/2, display.height/2))
    self._parent:addChild(self._backSpr[1], -4)

    self._backSpr[2] = cc.Sprite:create("Tile/beijing4.png")
    self._backSpr[2]:setAnchorPoint(cc.p(0.5, 0.5))
    self._backSpr[2]:setPosition(cc.p(display.width/2 + self._backSprSize.width, display.height/2))
    self._parent:addChild(self._backSpr[2], -4)

    -- 中
    self._midMap = cc.TMXTiledMap:create("Tile/yindaojg.tmx")
    self._midMap:setPosition(cc.p(0,0))
    self._parent:addChild(self._midMap, -3)

    -- 前
    self._frontMap = cc.TMXTiledMap:create("Tile/yindao.tmx")
    self._frontMap:setPosition(cc.p(0,0))
    self._parent:addChild(self._frontMap, -1)
end 

-- 背景移动(参数；-1或者1，正为右 负为左)
function UIBattle_Map:moveMap(rotation)
    -- 后
    if self._backSpr[1]:getPositionX() > -display.width/2 then 
        self._backSpr[1]:setPositionX(self._backSpr[1]:getPositionX() - BACK_OFFSETX * rotation)
        self._backSpr[2]:setPositionX(self._backSpr[2]:getPositionX() - BACK_OFFSETX * rotation)
    else 
        self._backSpr[1]:setPositionX(display.width/2)
    end 

    if self._backSpr[2]:getPositionX() <= display.width/2 then 
        self._backSpr[2]:setPositionX(display.width/2)
    end 

    -- 中
    -- 前
end 

function UIBattle_Map:getMidMap()
    return self._midMap
end 

function UIBattle_Map:getFrontMap()
    return self._frontMap
end 

return UIBattle_Map
