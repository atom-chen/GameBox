-- 战斗地图UI

local UIBattle_Map = class("UIBattle_Map")
function UIBattle_Map:ctor(parent, eachId) 
    self._parent = parent
    self._eachId = eachId

    self._bgSpr = nil 
    self._backMap = nil 
    self._frontMap = nil 

    self:_initMap()
end 

-- 初始化地图
function UIBattle_Map:_initMap()
    -- 背景图片
    self._bgSpr = cc.Sprite:create("Tile/beijing4.png")
    self._bgSpr:setAnchorPoint(cc.p(0.5, 0.5))
    self._bgSpr:setPosition(cc.p(display.width/2, display.height/2))
    self._parent:addChild(self._bgSpr, -4)

    -- 后
    self._backMap = cc.TMXTiledMap:create("Tile/yindaojg.tmx")
    self._backMap:setPosition(cc.p(0,0))
    self._parent:addChild(self._backMap, -3)

    -- 前
    self._frontMap = cc.TMXTiledMap:create("Tile/yindao.tmx")
    self._frontMap:setPosition(cc.p(0,0))
    self._parent:addChild(self._frontMap, -1)
end 

function UIBattle_Map:getBackMap()
    return self._backMap
end 

function UIBattle_Map:getFrontMap()
    return self._frontMap
end 

return UIBattle_Map
