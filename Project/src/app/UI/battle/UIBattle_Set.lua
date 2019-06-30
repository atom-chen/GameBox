-- 战斗设置页面相关
local UIBattle_Set = class("UIBattle_Set", function()
    return newLayerColor(cc.size(display.width, display.height), 120)
end)

function UIBattle_Set:ctor() 
    self._root = nil 
    self._oneKeyBtn = nil       -- 补给按钮
    self._continueBtn = nil     -- 继续按钮
    self._resetBtn = nil        -- 重玩按钮
    self._checkSound = nil      -- 声音开关
    self._exitBtn = nil         -- 退出按钮

    self:_initUI()
end 

function UIBattle_Set:_initUI()
    self._root = cc.CSLoader:createNode("csd/UIPause.csb")
    local size = self._root:getContentSize()
    self._root:setPosition(cc.p((display.width-size.width)/2, (display.height-size.height)/2))
    self:addChild(self._root)

    self._oneKeyBtn = ccui.Helper:seekNodeByName(self._root, "Button_onekey")
    self._continueBtn = ccui.Helper:seekNodeByName(self._root, "Button_continue")
    self._resetBtn = ccui.Helper:seekNodeByName(self._root, "Button_reset")
    self._checkSound = ccui.Helper:seekNodeByName(self._root, "CheckBox_sound")
    self._exitBtn = ccui.Helper:seekNodeByName(self._root, "Button_exit")

    BindTouchEvent(self._oneKeyBtn, handler(self, self._onOneKeyEvent))
    BindTouchEvent(self._continueBtn, handler(self, self._onContinueEvent))
    BindTouchEvent(self._resetBtn, handler(self, self._onResetEvent))
    BindTouchEvent(self._exitBtn, handler(self, self._onExitEvent))
    self._checkSound:onEvent(handler(self, self._onSoundEvent))
end 

-- 一键不给事件
function UIBattle_Set:_onOneKeyEvent(sender)
    --
end

-- 继续事件
function UIBattle_Set:_onContinueEvent(sender)
    --
end

-- 重玩事件
function UIBattle_Set:_onResetEvent(sender)
    --
end

-- 退出游戏事件
function UIBattle_Set:_onExitEvent(sender)
    local mainScene = require("app.UI.MainScene"):create()
    cc.Director:getInstance():replaceScene(mainScene)
end

-- 声音事件
function UIBattle_Set:_onSoundEvent(sender, event)
    if event == ccui.CheckBoxEventType.selected then 
        self._checkSound:setSelected(true)
    elseif event == ccui.CheckBoxEventType.unselected then 
        self._checkSound:setSelected(false)
    end 
end 

return UIBattle_Set