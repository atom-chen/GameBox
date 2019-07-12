-- 战斗控制UI

local UIBattle_Control = class("UIBattle_Control")
function UIBattle_Control:ctor(node, parent)
    self._parent = parent 
    self._rootNode = node 

    self._leftBtn = nil 
    self._rightBtn = nil 
    self._jumpBtn = nil 
    self._shootBtn = nil 
    self._bombBtn = nil 
    self._skillBtn = nil 

    self._gunImg = nil 
    self._knifeImg = nil 
    self._rotation = 0          -- 旋转角度

    self._shootScheduler = nil      -- 射击定时器

    self:_initUI()
end 

function UIBattle_Control:_initUI()
    -- 默认显示枪
    self._knifeImg = self._rootNode:getChildByName("Image_knife")
    self._knifeImg:setTouchEnabled(true)
    self._knifeImg:setVisible(false)

    self._gunImg = self._rootNode:getChildByName("Image_gun")
    self._gunImg:setTouchEnabled(true)
    self._gunImg:setVisible(true)
    
    self._leftBtn = self._rootNode:getChildByName("Button_left")
    self._rightBtn = self._rootNode:getChildByName("Button_right")
    self._jumpBtn = self._rootNode:getChildByName("Button_jump")
    self._shootBtn = self._rootNode:getChildByName("Button_attack")
    self._bombBtn = self._rootNode:getChildByName("Button_bomb")
    self._skillBtn = self._rootNode:getChildByName("Button_skill")

    BindTouchEvent(self._leftBtn, handler(self, self._onClickLeftEvent))
    BindTouchEvent(self._rightBtn, handler(self, self._onClickRightEvent))
    BindTouchEvent(self._jumpBtn, handler(self, self._onClickJumpEvent))
    
    BindTouchEvent(self._bombBtn, handler(self, self._onBombEvent))
    BindTouchEvent(self._skillBtn, handler(self, self._onSkillEvent))

    self._shootBtn:addTouchEventListener(handler(self, self._onShootEvent))
    self._gunImg:addTouchEventListener(handler(self, self._onChangeKnifeEvent))
    self._knifeImg:addTouchEventListener(handler(self, self._onChangeGunEvent))
end

function UIBattle_Control:_onClickLeftEvent(sender)
    MsgTip("您点击了左按钮")
    -- 地图移动
    self._parent:getMapUI():moveMap(-1)
end

function UIBattle_Control:_onClickRightEvent(sender)
    MsgTip("您点击了右按钮")
    self._parent:getMapUI():moveMap(1)
end

function UIBattle_Control:_onClickJumpEvent(sender)
    MsgTip("您点击了跳跃按钮")
end

-- 射击
function UIBattle_Control:_onShootEvent(sender, eventType)
    if eventType == ccui.TouchEventType.began then 
        if self._shootScheduler == nil then 
            local function start()
                self._parent:getHeroUI():StartShoot()
            end 
            -- param: 刷新方法
            -- param: 刷新时间间隔
            -- param: 是否只执行一次
            self._shootScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(start, 0.1, false)
        end 
    else 
        if self._shootScheduler ~= nil then 
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._shootScheduler)
            self._shootScheduler = nil 
        end 
    end 
end

function UIBattle_Control:_onBombEvent(sender)
    self._parent:getHeroUI():GrenadeCreate()
end

function UIBattle_Control:_onSkillEvent(sender)
    MsgTip("您点击了技能按钮")
end

-- 
function UIBattle_Control:_onChangeKnifeEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    self._gunImg:setVisible(false)
    self._knifeImg:setVisible(true) 

    -- 切换
    local heroNode = self._parent:getHeroNode()
    heroNode:ChangeWeapon("KNIFE")
end 

--
function UIBattle_Control:_onChangeGunEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 

    self._gunImg:setVisible(true)
    self._knifeImg:setVisible(false) 

    -- 切换
    local heroNode = self._parent:getHeroNode()
    heroNode:ChangeWeapon("GUN")
end 

function UIBattle_Control:dispose()
    if self._shootScheduler ~= nil then 
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._shootScheduler)
        self._shootScheduler = nil 
    end 
end 

return UIBattle_Control