-- 更多
local UIMore = class("UIMore", function()
    return newLayerColor(cc.size(display.width, display.height), 120)
end) 

function UIMore:ctor()
    self:_initData()
    self:_init()
    local function onNodeEvent(event)
        if event == "enter" then
            self:_onEnter()
        end
    end
    self:registerScriptHandler(onNodeEvent)
end 

function UIMore:_initData()
    self._root = nil            -- 根节点
    self._btnTabs = {}          -- 标签按钮，帮助|设置|关于
    self._nodeTabs = {}         -- 节点相关
    self._backBtn = nil         -- 返回按钮
    self._inputName = nil       -- 名字
    self._chkSound = nil        -- 声音开关
    self._stateLabel = nil      -- 介绍文本
end 

function UIMore:_init()
    self._root = cc.CSLoader:createNode("res/csd/UIMore.csb")
    local size = self._root:getContentSize()
    self._root:setPosition(cc.p((display.width-size.width)/2, (display.height-size.height)/2))
    self:addChild(self._root)

    local _tabs = {"_help", "_set", "_about"}
    for i = 1, 3 do 
        -- 按钮相关
        self._btnTabs[i] = ccui.Helper:seekNodeByName(self._root, "Button" .. _tabs[i])
        BindTouchEvent(self._btnTabs[i], handler(self, self._onTabEvent))
        self._btnTabs[i]:setTag(i)

        -- 节点相关
        self._nodeTabs[i] = ccui.Helper:seekNodeByName(self._root, "Node" .. _tabs[i])

        -- 默认显示帮助
        self._nodeTabs[i]:setVisible(i == 1)
        self._btnTabs[i]:setTouchEnabled(i ~= 1)
        self._btnTabs[i]:setBright(i ~= 1)
    end 
    self._inputName = self._nodeTabs[2]:getChildByName("TextField_name")
    self._inputName:onEvent(handler(self, self._onInputEvent))

    self._chkSound = self._nodeTabs[2]:getChildByName("CheckBox_4")
    self._chkSound:onEvent(handler(self, self._onSoundEvent))

    self._stateLabel = self._nodeTabs[3]:getChildByName("Text_2")
    self._stateLabel:setString("内容从NoticeConfig中获取")

    -- 取消按钮
    self._backBtn = ccui.Helper:seekNodeByName(self._root, "Button_back")
    BindTouchEvent(self._backBtn, function(sender)
        self:removeFromParent()
    end)
end 

function UIMore:_onEnter()
    -- 播放动画
    local action = cc.CSLoader:createTimeline("res/csd/UIMore.csb")
    self._root:runAction(action)
    action:gotoFrameAndPlay(0, false)
end 

-- 标签按钮事件
function UIMore:_onTabEvent(sender)
    local curTag = sender:getTag()
    print("当前的标签为:", curTag)
    for i = 1, 3 do 
        self._nodeTabs[i]:setVisible(i == curTag)
        self._btnTabs[i]:setTouchEnabled(i ~= curTag)
        self._btnTabs[i]:setBright(i ~= curTag)
    end 
end 

-- 输入昵称事件
function UIMore:_onInputEvent(sender, event)
    if event == TEXTFIELD_EVENT_ATTACH_WITH_IME then 
        --
    elseif event == TEXTFIELD_EVENT_DETACH_WITH_IME then 
        --
    else
        -- 
    end 
end 

-- 声音事件
function UIMore:_onSoundEvent(sender, event)
    if event == ccui.CheckBoxEventType.selected then 
        self._chkSound:setSelected(true)
    elseif event == ccui.CheckBoxEventType.unselected then 
        self._chkSound:setSelected(false)
    end 

    -- 存储数据
    -- do something
end 

return UIMore 
