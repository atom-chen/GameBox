-- 个人示例主页面
local ClipTest = require("app.Demo_Cocos.ClipTest")
local DrawGraphTest = require("app.Demo_Cocos.DrawGraphTest")
local DrawLineTest = require("app.Demo_Cocos.DrawLineTest")
local OpenGLTest = require("app.Demo_Cocos.OpenGLTest")
local ProcessorTest = require("app.Demo_Cocos.ProcessorTest")
local SpineTest = require("app.Demo_Cocos.SpineTest")
local KeyboardTest = require("app.Demo_Cocos.KeyboardTest")
local ScheduleTest = require("app.Demo_Cocos.ScheduleTest")

local tests = {
    {title = "ClipTest", layer = ClipTest, state = "裁切图形相关"},
    {title = "DrawGraphTest", layer = DrawGraphTest, state = "cocos自带的绘制图形相关"}, -- Demo代码不对
    {title = "DrawLineTest", layer = DrawLineTest, state = "cocos自带的绘制线段相关"},
    --{title = "OpenGLTest", layer = OpenGLTest, state = "shaderDemo相关"},
    --{title = "ProcessorTest", layer = ProcessorTest, state = "进度条动画相关"},       -- 缺少资源
    {title = "SpineTest", layer = SpineTest, state = "骨骼动画相关"},                 -- 读取资源失败
    {title = "KeyboardTest", layer = KeyboardTest, state = "键盘事件相关"},
    {title = "ScheduleTest", layer = ScheduleTest, state = "定时器相关"},
}
local LINE_SPACE = 40               -- 间隔
local TEST_COUNT = #tests           -- 示例数目

local MainTest = class("MainTest", function()
    return newLayerColor(cc.size(display.width, display.height), 255)
end)

function MainTest:ctor()
    local menu = cc.Menu:create()
    menu:setContentSize(cc.size(display.width, (TEST_COUNT + 1) * LINE_SPACE))
    menu:setPosition(cc.p(0,0))
    self:addChild(menu, 0)

    for i, obj in pairs(tests) do 
        local str = string.format("%s(%s)", obj.title, obj.state)
        local label = ccui.Text:create(str, "Arial", 24)
        label:setAnchorPoint(cc.p(0.5, 0.5))

        -- 文本菜单
        local menuItem = cc.MenuItemLabel:create(label)
        menuItem:setPosition(cc.p(display.width/2, display.height - i * LINE_SPACE))
        menuItem:registerScriptTapHandler(handler(self, self._menuEvent))
        menu:addChild(menuItem, i+100, i)
    end 
end 

function MainTest:_menuEvent(tag, menuItem)
    local node = tests[tag].layer:create()

    if not node then 
        return 
    end 
    self:addChild(node,1000)
end 

return MainTest
