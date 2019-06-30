-- 战斗场景
local UIBattle_Map = require("app.UI.battle.UIBattle_Map")
local UIBattle_Main = require("app.UI.battle.UIBattle_Main")
local UIBattle_Control = require("app.UI.battle.UIBattle_Control")

local BattleScene = class("BattleScene", function()
    return cc.Scene:create()
end)

function BattleScene:ctor()
    self._root = nil 
    self._mainUI = nil              -- 主界面UI
    self._controlUI = nil           -- 控制UI
    self._mapUI = nil               -- 地图UI

    self:_initUI() 
    
end 

function BattleScene:_initUI()
    self._root = cc.CSLoader:createNode("csd/UIBattle.csb")
    local size = self._root:getContentSize()
    self._root:setPosition(cc.p((display.width-size.width)/2, (display.height-size.height)/2))
    self:addChild(self._root)

    self._mainUI = UIBattle_Main.new(self._root)
    self._controlUI = UIBattle_Control.new(self._root)
    self._mapUI = UIBattle_Map.new(self)
end 

function BattleScene:onEnter()
    --
end 

return BattleScene