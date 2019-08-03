-- 格斗主场景

local UIGame = require("app.Demo_FistFight.Fist_Game")
local UIControl = require("app.Demo_FistFight.Fist_UI")


local Fist_Scene = class("Fist_Scene", function()
    return cc.Scene:create()
end)

function Fist_Scene:ctor()
    self._game = nil                -- 游戏相关
    self._control = nil             -- 控制相关

    self:_init()
end 

function Fist_Scene:_init()
    self._game = UIGame.new()
    self:addChild(self._game, 0)

    self._control = UIControl.new(self)
    self:addChild(self._control, 1)
end 

-- 获取英雄节点
function Fist_Scene:getHeroNode()
    return self._game:getHeroNode()
end 

return Fist_Scene