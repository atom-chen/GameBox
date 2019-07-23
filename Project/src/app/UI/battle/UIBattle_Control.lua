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

    self._shootScheduler = nil      -- 英雄射击定时器
    self._moveScheduler = nil       -- 英雄移动定时器

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

    BindTouchEvent(self._jumpBtn, handler(self, self._onClickJumpEvent))    
    BindTouchEvent(self._bombBtn, handler(self, self._onBombEvent))
    BindTouchEvent(self._skillBtn, handler(self, self._onSkillEvent))

    self._leftBtn:addTouchEventListener(handler(self, self._onClickLeftEvent))
    self._rightBtn:addTouchEventListener(handler(self, self._onClickRightEvent))
    self._shootBtn:addTouchEventListener(handler(self, self._onShootEvent))
    self._gunImg:addTouchEventListener(handler(self, self._onChangeKnifeEvent))
    self._knifeImg:addTouchEventListener(handler(self, self._onChangeGunEvent))
end

-- 向左移动事件
function UIBattle_Control:_onClickLeftEvent(sender, eventType)
    if eventType == ccui.TouchEventType.began then 
        -- 开始移动
        if self._moveScheduler == nil then 
            local function start()
                self._parent:getMapUI():moveMap(-1)
                self._parent:getHeroUI():StartMove(-1)
            end 
            self._moveScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(start, 0.1, false)
        end 
    else 
        -- 停止移动
        if self._moveScheduler ~= nil then 
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._moveScheduler)
            self._moveScheduler = nil 
        end 
        self._parent:getHeroUI():StopMove()
    end 
end

-- 向右移动事件 self._moveScheduler
function UIBattle_Control:_onClickRightEvent(sender, eventType)
    if eventType == ccui.TouchEventType.began then 
        -- 开始移动
        if self._moveScheduler == nil then 
            local function start()
                self._parent:getMapUI():moveMap(1)
                self._parent:getHeroUI():StartMove(1)
            end 
            self._moveScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(start, 0.1, false)
        end 
    else 
        -- 停止移动
        if self._moveScheduler ~= nil then 
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._moveScheduler)
            self._moveScheduler = nil 
        end 
        self._parent:getHeroUI():StopMove()
    end 
end

function UIBattle_Control:_onClickJumpEvent(sender)
    self._parent:getHeroUI():StartJump()
end

-- 射击
function UIBattle_Control:_onShootEvent(sender, eventType)
    if eventType == ccui.TouchEventType.began then 
        -- 开始射击
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
        -- 停止射击
        if self._shootScheduler ~= nil then 
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._shootScheduler)
            self._shootScheduler = nil 
        end 
    end 
end

-- 手雷事件
function UIBattle_Control:_onBombEvent(sender)
    self._parent:getHeroUI():GrenadeCreate()
end

function UIBattle_Control:_onSkillEvent(sender)
    MsgTip("您点击了技能按钮")
end

-- 切换武器事件
function UIBattle_Control:_onChangeKnifeEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    self._gunImg:setVisible(false)
    self._knifeImg:setVisible(true) 
    self._parent:getHeroUI():ChangeWeapon("KNIFE")
end 

--
function UIBattle_Control:_onChangeGunEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 

    self._gunImg:setVisible(true)
    self._knifeImg:setVisible(false) 

    -- 切换
    self._parent:getHeroUI():ChangeWeapon("GUN")
end 

function UIBattle_Control:dispose()
    if self._shootScheduler ~= nil then 
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._shootScheduler)
        self._shootScheduler = nil 
    end 
end 

return UIBattle_Control