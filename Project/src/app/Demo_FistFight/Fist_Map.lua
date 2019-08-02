-- 地图背景类
local UIRole = require("app.Demo_FistFight.Fist_Role")
local Fist_Map = class("Fist_Map", function()
    return newLayerColor(cc.size(display.width, display.height), 255)
end)

function Fist_Map:ctor()
    self._map = nil                     -- 地图节点
    self._mapSize = nil                 -- 地图尺寸(瓦片)
    self._tileSize = nil                -- 瓦片尺寸(像素)
    
    self._roleNode = nil                -- 英雄节点

    self:_init()
end 

function Fist_Map:_init()
    -- 初始化地图
    self._map = ccexp.TMXTiledMap:create("fistfight/pd_tilemap.tmx")
    self._mapSize = self._map:getMapSize()
    self._tileSize = self._map:getTileSize()
    self:addChild(self._map, 0)

    -- 初始化英雄
    self._roleNode = UIRole.new()
    self._roleNode:setPosition(100,50)
    self:addChild(self._roleNode, 1)
    --self._roleNode:idle()
end 

return Fist_Map