-- 进度条动画
require "cocos.spine.SpineConstants"
local winSize = cc.Director:getInstance():getWinSize()

local ProcessorTest = class("ProcessorTest",function()
    return newLayerColor(cc.size(display.width, display.height), 255)
end)

function ProcessorTest:ctor()
    local function onNodeEvent(event)
        if event == "enter" then
            self:init()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end

function ProcessorTest:init()
    local item = ccui.Text:create()
    item:setFontSize(24)
    item:setString("进度条动画")
    item:setPosition(cc.p(winSize.width/2, winSize.height-20))
    self:addChild(item)

    self:playProcessBarDemo()
    self:playLoadBarDemo()
end

-- "res/pu_hart.png
-- res/bar1.png
-- res/bar2.png
function ProcessorTest:playProcessBarDemo()
    -- 标题
    local title = ccui.Text:create()
    title:setPosition(cc.p(winSize.width/2 - 150, winSize.height*5/6))
    title:setString("ProcessTo/ProcessFromTo:")
    title:setAnchorPoint(cc.p(1, 0.5))
    title:setFontSize(24)
    self:addChild(title)

    local barBgSpr = cc.Sprite:create("res/bar1.png")
    barBgSpr:setPosition(cc.p(winSize.width/2, winSize.height*5/6))
    self:addChild(barBgSpr,1)

    local barSpr = cc.Sprite:create("res/bar2.png")
    local processTimer = cc.ProgressTimer:create(barSpr)
    processTimer:setPosition(cc.p(winSize.width/2, winSize.height*5/6))
    processTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    processTimer:setBarChangeRate(cc.p(1, 0))
    processTimer:setMidpoint(cc.p(0, 0))
    processTimer:setPercentage(0) 
    self:addChild(processTimer,2)

    --local action1 = cc.ProgressTo:create(5,100)
    local action1 = cc.ProgressFromTo:create(5,0,100)
    local action = cc.RepeatForever:create(action1)
    processTimer:runAction(action)
end 

function ProcessorTest:playLoadBarDemo()
    -- 标题
    local title = ccui.Text:create()
    title:setPosition(cc.p(winSize.width/4 - 100, winSize.height*5/6 - 100))
    title:setString("LadingBar:")
    title:setAnchorPoint(cc.p(1, 0.5))
    title:setFontSize(24)
    self:addChild(title)

    --加按钮相关
    local addBtn = ccui.Button:create()
    addBtn:loadTextures("res/button.png", "res/button.png", "")
    addBtn:setTitleText("加")
    addBtn:setPosition(cc.p(winSize.width*3/4, winSize.height*5/6 - 100))
    addBtn:addTouchEventListener(handler(self, self._addReduceEvt))
    self:addChild(addBtn)
    
    -- 减按钮相关
    local reduceBtn = ccui.Button:create()
    reduceBtn:loadTextures("res/button.png", "res/button.png", "")
    reduceBtn:setTitleText("减")
    reduceBtn:setPosition(cc.p(winSize.width*3/4 + 100, winSize.height*5/6 - 100))
    reduceBtn:addTouchEventListener(handler(self, self._addReduceEvt))
    self:addChild(reduceBtn)

    -- 进度条
     
    local loadingBar = ccui.LoadingBar:create()
    loadingBar:loadTexture("res/sliderProgress.png")
    loadingBar:setPosition(cc.p(winSize.width/4 + 170, winSize.height*5/6 - 105))
    loadingBar:setDirection(ccui.LoadingBarDirection.LEFT)
    loadingBar:setPercent(0)
    self:addChild(loadingBar)
    self._loadingBar = loadingBar
end 

function ProcessorTest:_AddReduceEvt(sender,eventType)
    local scheduler = cc.Director:getInstance():getScheduler()

    if eventType == ccui.TouchEventType.began then
        -- 定时器相关
        if self._timeScheduler ~= nil then 
            scheduler:unscheduleScriptEntry(self._timeScheduler)
            self._timeScheduler = nil
        end
        self._timeScheduler = scheduler:scheduleScriptFunc(handler(self, self._updateLoadBar), 0.1, false)
    elseif eventType == ccui.TouchEventType.moved then
        --
    elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
        if self._timeScheduler ~= nil then 
            scheduler:unscheduleScriptEntry(self._timeScheduler)
            self._timeScheduler = nil
        end 
    end
end 

-- 更新进度条
function ProcessorTest:_updateLoadBar(delta)
    local curpercent = self._loadingBar:getPercent()
    if curpercent < 100 then 
        curpercent = curpercent + 10
        self._loadingBar:setPercent(curpercent)
    else 
        if self._timeScheduler ~= nil then 
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timeScheduler)
            self._timeScheduler = nil
        end 
    end 
end 

return ProcessorTest
