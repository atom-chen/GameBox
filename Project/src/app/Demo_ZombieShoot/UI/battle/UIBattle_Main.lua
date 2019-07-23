-- 战斗主界面UI

local BLOOD_NUM = 3         -- 血包数目

local UIBattle_Main = class("UIBattle_Main")
function UIBattle_Main:ctor(node,parent)
    self._rootNode = node 
    self._parent = parent 
    
    self._headIcon = nil        -- 头像
    self._moneyText = nil       -- 金钱数目
    self._timeText = nil        -- 时间文本
    self._bombText = nil        -- 炸弹文本
    self._bulletText = nil      -- 子弹文本
    self._hpImg = nil           -- 血条

    self._pauseBtn = nil        -- 暂停按钮
    self._bloodpacks = {}       -- 血包

    self:_initUI()
end 

function UIBattle_Main:_initUI()
    self._headIcon = self._rootNode:getChildByName("Image_head")
    self._moneyText = ccui.Helper:seekNodeByName(self._rootNode, "AtlasLabel_moneyNum")
    self._bombText = ccui.Helper:seekNodeByName(self._rootNode, "Altas_BombNum")
    self._bulletText = ccui.Helper:seekNodeByName(self._rootNode, "Altas_ButtleNum")
    self._hpImg = self._rootNode:getChildByName("Image_hp")
    self._pauseBtn = self._rootNode:getChildByName("Button_pause")

    for i = 1, BLOOD_NUM do 
        self._bloodpacks[i] = self._rootNode:getChildByName("Button_hp" .. i)
        BindTouchEvent(self._bloodpacks[i], handler(self, self._onUseBloodPackEvent))
        self._bloodpacks[i]:setTag(i)
    end 
    
    BindTouchEvent(self._pauseBtn, handler(self, self._onPauseEvent))
end

function UIBattle_Main:_onPauseEvent(sender)
    local layer = require("app.Demo_ZombieShoot.UI.battle.UIBattle_Set"):create()
    if not layer then 
        MsgTip("打开UIBattle_Set有误！！！")
        return 
    end 
    self._parent:addChild(layer)
end


return UIBattle_Main