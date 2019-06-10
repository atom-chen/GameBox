-- 成就页面
local UIAchieve = class("UIAchieve", function()
    return newLayerColor(cc.size(display.width, display.height), 120)
end) 

---
local UIAchieveItem = class("UIAchieveItem")
function UIAchieveItem:ctor(root, data)
    self._root = root
    self._itemBg = nil              -- 背景
    self._iconImg = nil             -- icon
    self._stateText = nil           -- 介绍
    self._bar = nil                 -- 进度
    self._barText = nil             -- 进度文本(cur/total)
    self._rewardText = nil          -- 奖励
    self._endImg = nil              -- 已领取
    self._notendImg = nil           -- 未达成
    self._finishBtn = nil           -- 可领取
    
    self:_show(data)
end 

function UIAchieveItem:_show(data)
    self._itemBg = self._root:getChildByName("Image_bg")
    self._iconImg = self._root:getChildByName("Image_Icon")
    self._stateText = self._root:getChildByName("Text_task")
    self._bar = self._root:getChildByName("LoadingBar")
    self._barText = self._root:getChildByName("Text_process")
    self._rewardText = self._root:getChildByName("AtlasLabel_1")

    -- 状态
    self._endImg = self._root:getChildByName("Image_end")
    self._notendImg = self._root:getChildByName("Image_notend")
    self._finishBtn = self._root:getChildByName("Button_finish")
end 

-- 刷新进度
function UIAchieveItem:updateProcess(newProcess)
    --
end 

-- 刷新状态
function UIAchieveItem:updateFinishState(newState)
    --
end 

--- 
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
    self._listView = nil 
    self._tmpItem = nil 
    self._listBar = {}
    self._showAllBtn = nil      -- 显示全部按钮
    self._showBtn = nil         -- 显示可领取按钮
end 

function UIAchieve:_initUI()
    self._root = cc.CSLoader:createNode("res/csd/UIAchievement.csb")
    local size = self._root:getContentSize()
    self._root:setPosition(cc.p((display.width-size.width)/2, (display.height-size.height)/2))
    self:addChild(self._root)

    --
    self._listView = ccui.Helper:seekNodeByName(self._root, "ListView_1")
    self._listView:setScrollBarEnabled(false)

    self._tmpItem = self._listView:getChildByName("panel")
    self._tmpItem:retain()
    self._tmpItem:removeFromParent(false)

    --
    self._showAllBtn = ccui.Helper:seekNodeByName(self._root, "Button_show2")
    self._showBtn = ccui.Helper:seekNodeByName(self._root, "Button_show1")
    self._showAllBtn:setVisible(false)
    self._showBtn:setVisible(false)

    -- 返回按钮
    local backBtn = ccui.Helper:seekNodeByName(self._root, "Button_back")
    BindTouchEvent(backBtn, function(sender)
        MsgTip("您点击了返回按钮")
        self:removeFromParent()
    end)
end 

function UIAchieve:_onEnter()
    -- 播放动画
    --[[
    local action = cc.CSLoader:createTimeline("res/csd/UIAchievement.csb")
    self._root:runAction(action)
    action:gotoFrameAndPlay(0, false)
    ]]

    -- 刷新列表
    self:_updateAchieve()
end 

-- 刷新列表
function UIAchieve:_updateAchieve()
    --[[
    -- 获取成就列表数据
    local _dataList = AchieveService:getInstance():getAchieveList()
    if not _dataList then 
        return 
    end 
    local num = #_dataList
    if not num then 
        return 
    end 
    ]]

    local num = 10
    for i = 1, num do 
        local item = self._tmpItem:clone()
        self._listBar[i] = UIAchieveItem.new(item)
        self._listView:pushBackCustomItem(item)
    end  
end 

return UIAchieve 
