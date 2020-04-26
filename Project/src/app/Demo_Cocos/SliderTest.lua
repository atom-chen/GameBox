-- 拖曳条相关
local super = require("app.Demo_Cocos.BaseTest")
local SliderTest = class("SliderTest",super)

function SliderTest:initUI()
    print("SliderTest:initUI...")
    -- 拖曳条
    local slider = ccui.Slider:create()
    slider:setTouchEnabled(true)
    -- 加载滑块背景
    slider:loadBarTexture("res/Default/sliderTrack.png")
    -- 加载滑块按钮图片
    slider:loadSlidBallTextures("res/Default/sliderThumb.png", "res/Default/sliderThumb.png", "")
    -- 加载滑块的进度图片
    slider:loadProgressBarTexture("res/Default/sliderProgress.png")
    slider:setPosition(cc.p(display.width/2, display.height/2))
    -- 设置滑动进度(1~100)
    slider:setPercent(100)
    slider:setMaxPercent(100)
    slider:addEventListener(handler(self, self._percentChangedEvent))
    self:addChild(slider)

    -- 文本
    self._label = ccui.Text:create("进度：100", "Arial", 18)
    self._label:setPosition(cc.p(display.width/2, display.height*2/3))
    self:addChild(self._label)

    local txtLabel = ccui.Text:create("音乐：", "Arial", 20)
    txtLabel:setPosition(cc.p(display.width*1/5, display.height*1/4))
    self:addChild(txtLabel)

    local checkBox = ccui.CheckBox:create()
    checkBox:setTouchEnabled(true)
    checkBox:setSelectedState(true)
    checkBox:loadTextures("res/Default/check_box_normal.png",
        "res/Default/check_box_normal_press.png",
        "res/Default/check_box_active.png",
        "res/Default/check_box_normal_disable.png",
        "res/Default/check_box_active_disable.png")
    checkBox:setPosition(cc.p(display.width*1/4, display.height*1/4))
    checkBox:addEventListener(handler(self, self._onCheckEvent))
    self:addChild(checkBox)

    -- 播放音乐 
    AudioEngine.playMusic("sound/background.mp3", true)
end 

function SliderTest:_percentChangedEvent(sender,eventType)
    if eventType == ccui.SliderEventType.percentChanged then
        local curPercent = sender:getPercent()
        local maxPercent = sender:getMaxPercent()
        self._label:setString(string.format("进度：%d", curPercent))
        AudioEngine.setMusicVolume(curPercent/maxPercent)
    elseif eventType == ccui.SliderEventType.slideBallUp then
        -- 滑块松开
    elseif eventType == ccui.SliderEventType.slideBallDown then
        -- 滑块按下
    elseif eventType == ccui.SliderEventType.slideBallCancel then
        print("Slide Ball Cancel")
    end
end 

function SliderTest:_onCheckEvent(sender,eventType)
    if eventType == ccui.CheckBoxEventType.selected then
        AudioEngine.resumeMusic()
    elseif eventType == ccui.CheckBoxEventType.unselected then
        AudioEngine.pauseMusic()
    end
end 

return SliderTest
