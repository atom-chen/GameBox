-- 
local ClipTest = require("app.personTest.ClipTest")
local DrawGraphTest = require("app.personTest.DrawGraphTest")
local DrawLineTest = require("app.personTest.DrawLineTest")
local OpenGLTest = require("app.personTest.OpenGLTest")
local ProcessorTest = require("app.personTest.ProcessorTest")
local SpineTest = require("app.personTest.SpineTest")
local KeyboardTest = require("app.personTest.KeyboardTest")
local ZombieShootTest = require("app.Demo_ZombieShoot.UI.MainScene") 
local TetrisTest = require("app.Demo_Tetris.UITetrisMain")
local LolitaTest = require("app.Demo_lolitaParkour.lolitaLoginScene")
local FistFightTest = require("app.Demo_FistFight.Fist_Scene")

local config = {
    --{title = "ClipTest", layer = ClipTest, state = "裁切图形相关"},
    --{title = "DrawLineTest", layer = DrawLineTest, state = "cocos自带的绘制线段相关"},
    --{title = "KeyboardTest", layer = KeyboardTest, state = "键盘事件相关"},
    --{title = "KeyboardTest", layer = KeyboardTest, state = "键盘事件相关"},
    --{title = "KeyboardTest", layer = KeyboardTest, state = "键盘事件相关"},
    {title = "ZombieShootTest", layer = ZombieShootTest, state = "末日射击", type = "scene"},
    {title = "TetrisTest", layer = TetrisTest, state = "俄罗斯方块", type = "layer"},
    {title = "LolitaTest", layer = LolitaTest, state = "萝莉跑酷", type = "scene"},
    {title = "FistFightTest", layer = FistFightTest, state = "简单的格斗", type = "scene"},
    --{title = "OpenGLTest", layer = OpenGLTest, state = "shaderDemo相关"},
    --{title = "ProcessorTest", layer = ProcessorTest, state = "进度条动画相关"},       -- 缺少资源
    --{title = "SpineTest", layer = SpineTest, state = "骨骼动画相关"},                 -- 读取资源失败
    --{title = "DrawGraphTest", layer = DrawGraphTest, state = "cocos自带的绘制图形相关"}, Demo代码不对
}

local TestScene = class("TestScene", function()
    return cc.Scene:create()
end) 

function TestScene:ctor()
    self._root = cc.CSLoader:createNode("res/csd/UITest.csb")
    self:addChild(self._root)

    -- listView相关
    self._listView = ccui.Helper:seekNodeByName(self._root, "ListView_1")
    self._listView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)             -- 设置方向
    self._listView:setScrollBarEnabled(true)                                  -- 设置滚动条是否显示
    self._listView:setBounceEnabled(true)                                     -- 设置滑动惯性
    self._listView:setItemsMargin(0.1)                                        -- 设置Item间隔
    self._item = self._listView:getChildByName("Image_listTitle")
    self._item:removeFromParent(false)
    for i = 1, #config do 
        local item = self._item:clone()
        item:getChildByName("Text_title"):setString(config[i].title)
        item:getChildByName("Text_State"):setString(config[i].state)
        item:addTouchEventListener(handler(self, self._onLayerEvt))
        item:setTouchEnabled(true)
        item:setTag(i)
        item:setVisible(true)
        self._listView:pushBackCustomItem(item)
    end 

    -- 返回按钮相关
    local backBtn = self._root:getChildByName("Button_Back")
    local btnSize = backBtn:getContentSize()
    backBtn:setPosition(cc.p(display.width - btnSize.width, btnSize.height))
    backBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            cc.Director:getInstance():endToLua()
        end 
    end)
end 

function TestScene:_onLayerEvt(sender,eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    local index = sender:getTag()
    local node = config[index].layer:create()
    if tolua.isnull(node) then 
        return 
    end 

    if config[index].type and config[index].type == "scene" then 
        display.runScene(node)
    else 
        self:addChild(node)
    end 
end 

return TestScene 
