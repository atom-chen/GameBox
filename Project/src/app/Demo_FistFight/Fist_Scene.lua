-- 格斗主场景

local UIMap = require("app.Demo_FistFight.Fist_Map")


local Fist_Scene = class("Fist_Scene", function()
    return cc.Scene:create()
end)

function Fist_Scene:ctor()
    self._mapNode = nil             -- 地图节点

    self:_init()
end 

function Fist_Scene:_init()
    self._mapNode = UIMap.new()
    self:addChild(self._mapNode, 0)
end 

return Fist_Scene