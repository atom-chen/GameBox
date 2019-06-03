-- 
local ClipTest = require("app.personTest.ClipTest")
local DrawGraphTest = require("app.personTest.DrawGraphTest")
local DrawLineTest = require("app.personTest.DrawLineTest")
local OpenGLTest = require("app.personTest.OpenGLTest")
local ProcessorTest = require("app.personTest.ProcessorTest")
local SpineTest = require("app.personTest.SpineTest")
local KeyboardTest = require("app.personTest.KeyboardTest")

local LOADNUM = 10      -- 进度条预加载数目

local config = {
    {title = "ClipTest", layer = ClipTest, state = "裁切图形相关"},
    {title = "DrawLineTest", layer = DrawLineTest, state = "cocos自带的绘制线段相关"},
    {title = "KeyboardTest", layer = KeyboardTest, state = "键盘事件相关"},
    --{title = "OpenGLTest", layer = OpenGLTest, state = "shaderDemo相关"},
    --{title = "ProcessorTest", layer = ProcessorTest, state = "进度条动画相关"},       -- 缺少资源
    --{title = "SpineTest", layer = SpineTest, state = "骨骼动画相关"},                 -- 读取资源失败
    --{title = "DrawGraphTest", layer = DrawGraphTest, state = "cocos自带的绘制图形相关"}, Demo代码不对
}

local TestScene = class("TestScene", function()
    return cc.Scene:create()
end) 

function TestScene:ctor()
    self:_initUI()
    self:_updateItems()
end 

function TestScene:_initUI()
    -- 根节点相关
    self._root = cc.CSLoader:createNode("res/csd/test/UITest.csb")
    self:addChild(self._root)

    -- listView相关
    self._listView = ccui.Helper:seekNodeByName(self._root, "ListView_1")
    self._listView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)             -- 设置方向
    self._listView:setScrollBarEnabled(true)                                  -- 设置滚动条是否显示
    self._listView:setBounceEnabled(true)                                     -- 设置滑动惯性
    self._listView:setItemsMargin(0.1)                                        -- 设置Item间隔
    self._item = self._listView:getChildByName("Image_listTitle")
    self._item:removeFromParent(false)
    -- 预建
    for i = 1, LOADNUM do 
        local item = self._item:clone()
        item:setVisible(false)

        self._listView:pushBackCustomItem(item)
    end 

    -- 返回按钮相关
    local backBtn = self._root:getChildByName("Button_Back")
    backBtn:addTouchEventListener(function(sender, eventType)
        if eventType ~= ccui.TouchEventType.ended then 
            return 
        end 
    
        local scene = require("app.views.main.UIMainScene"):create()
        cc.Director:getInstance():replaceScene(scene)
    end)
end 

function TestScene:_updateItems()
    local itemNum = #config
    if itemNum <= 0 then return end 

    for i = 1, itemNum do 
        local item = nil 
        -- 如果数目大于预创建数目，则新建
        if i <= LOADNUM then 
            item = self._listView:getItem(i)
        else 
            item = self._item:clone()
            self._listView:pushBackCustomItem(item)
        end 
        if item ~= nil then 
            item:getChildByName("Text_title"):setString(config[i].title)
            item:getChildByName("Text_State"):setString(config[i].state)
            item:addTouchEventListener(handler(self, self._onLayerEvt))
            item:setTouchEnabled(true)
            item:setTag(i)
            item:setVisible(true)
        end 
    end 
end 

function TestScene:_onLayerEvt(sender,eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    local index = sender:getTag()
    print("您选择的Demo的索引为：", config[index].title)

    local layer = config[index].layer.create()
    if layer ~= nil then 
        self:addChild(layer)
    end 
end 

return TestScene 
