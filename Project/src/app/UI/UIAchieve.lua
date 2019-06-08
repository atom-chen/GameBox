-- 成就页面
local UIAchieve = class("UIAchieve", function()
    return newLayerColor(cc.size(display.width, display.height), 120)
end) 

function UIAchieve:ctor()
    self:_initData()
    self:_initUI()
    local function onNodeEvent(event)
        if event == "enter" then
            self:_onEnter()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end 

function UIAchieve:_initData()
    self._root = nil 
    self._scroll = nil 
    self._showAllBtn = nil      -- 显示全部按钮
    self._showBtn = nil         -- 显示可领取按钮
end 

function UIAchieve:_initUI()
    self._root = cc.CSLoader:createNode("res/csd/UIAchievement.csb")
    local size = self._root:getContentSize()
    self._root:setPosition(cc.p((display.width-size.width)/2, (display.height-size.height)/2))
    self:addChild(self._root)

    --
    self._scroll = ccui.Helper:seekNodeByName(self._root, "ListView_1")
    self._scroll:setScrollBarEnabled(false)

    --
    self._showAllBtn = ccui.Helper:seekNodeByName(self._root, "Button_show2")
    self._showBtn = ccui.Helper:seekNodeByName(self._root, "Button_show1")
    self._showAllBtn:setVisible(false)
    self._showBtn:setVisible(false)

    -- 返回按钮
    local backBtn = ccui.Helper:seekNodeByName(self._root, "Button_back")
    BindTouchEvent(backBtn, function(sender)
        self:removeFromParent()
    end)
end 

function UIAchieve:_onEnter()
    do return end 
    -- 播放动画
    local action = cc.CSLoader:createTimeline("res/csd/UIAchievement.csb")
    self._root:runAction(action)
    action:gotoFrameAndPlay(0, false)
end 

-- 刷新列表
function UIAchieve:_updateScroll()
    local itemNum = 10

    local innerHeight = math.max(scollH, itemNum * (self.itemSize.height + 2))
    self._scroll:setInnerContainerSize(self._scroll:getContentSize())

    for i = 1, itemNum do 
        -- do something 
    end 
end 

return UIAchieve 
