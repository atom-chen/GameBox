-- 战斗控制UI

local UIBattle_Control = class("UIBattle_Control")
function UIBattle_Control:ctor(parent)
    self._parentNode = parent 
    self._rootNode = nil 
    self._leftBtn = nil 
    self._rightBtn = nil 
    self._jumpBtn = nil 
    self._shootBtn = nil 
    self._bombBtn = nil 
    self._skillBtn = nil 

    self._gunImg = nil 
    self._knifeImg = nil 

    self:_initUI()
end 

function UIBattle_Control:_initUI()
    self._rootNode = ccui.Helper:seekNodeByName(self._parentNode, "Node_Control")

    self._gunImg = self._rootNode:getChildByName("Image_gun")
    self._knifeImg = self._rootNode:getChildByName("Image_knife")

    self._leftBtn = self._rootNode:getChildByName("Button_left")
    self._rightBtn = self._rootNode:getChildByName("Button_right")
    self._jumpBtn = self._rootNode:getChildByName("Button_jump")
    self._shootBtn = self._rootNode:getChildByName("Button_attack")
    self._bombBtn = self._rootNode:getChildByName("Button_bomb")
    self._skillBtn = self._rootNode:getChildByName("Button_skill")

    BindTouchEvent(self._leftBtn, handler(self, self._onClickLeftEvent))
    BindTouchEvent(self._rightBtn, handler(self, self._onClickRightEvent))
    BindTouchEvent(self._jumpBtn, handler(self, self._onClickJumpEvent))
    BindTouchEvent(self._shootBtn, handler(self, self._onShootEvent))
    BindTouchEvent(self._bombBtn, handler(self, self._onBombEvent))
    BindTouchEvent(self._skillBtn, handler(self, self._onSkillEvent))
end

function UIBattle_Control:_onClickLeftEvent(sender)
    MsgTip("您点击了左按钮")
end

function UIBattle_Control:_onClickRightEvent(sender)
    MsgTip("您点击了右按钮")
end

function UIBattle_Control:_onClickJumpEvent(sender)
    MsgTip("您点击了左按钮")
end

function UIBattle_Control:_onShootEvent(sender)
    MsgTip("您点击了射击按钮")
end

function UIBattle_Control:_onBombEvent(sender)
    MsgTip("您点击了炸弹按钮")
end

function UIBattle_Control:_onSkillEvent(sender)
    MsgTip("您点击了技能按钮")
end

return UIBattle_Control