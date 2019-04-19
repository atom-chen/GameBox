-- 绘制多边形
local size  = cc.Director:getInstance():getWinSize()

local DrawGraphTest = class("DrawGraphTest",function()
    return cc.Layer:create()
end)

function DrawGraphTest:ctor()
    local function onNodeEvent(event)
        if event == "enter" then
            self:init()
            local scheduleHandler = cc.Director:getInstance():getScheduler()
	        self.scheduleHandler = scheduleHandler:scheduleScriptFunc(handler(self, self.update), 0.5, false)
        elseif event == "exit" then 
            if self.scheduleHandler ~= nil then
                local scheduler = cc.Director:getInstance():getScheduler()		
                scheduler:unscheduleScriptEntry(self.scheduleHandler)
                self.scheduleHandler = nil 
            end
        end
    end
    self:registerScriptHandler(onNodeEvent)
end

function DrawGraphTest:init()
    local item = ccui.Text:create()
    item:setFontSize(24)
    item:setString("多边形")
    item:setPosition(cc.p(size.width/2, size.height/2))
    --self:addChild(item)
    
    --cocos2d-x绘图节点
    --下面的绘图，直接调用DrawNode节点的相关方法：drawDot
    self.draw = cc.DrawNode:create()
    self:addChild(self.draw, 10)
    self.index = 0

    --画十个同心圆点
    --[[
    for i=1, 10 do
        --参数：位置，半径，颜色和透明度 -
        draw:drawDot(cc.p(size.width/2, size.height/2 + i*10), 10*(10-i), cc.c4f(math.random(0,1), math.random(0,1), math.random(0,1), 1))
    end
    --画线段：起点，终点，线宽，颜色
    --draw:drawSegment(cc.p(20,size.height), cc.p(20,size.height/2), 10, cc.c4f(0, 1, 1, 0.5))
    --draw:drawSegment(cc.p(10,size.height/2), cc.p(size.width, size.height/2), 40, cc.c4f(1, 0, 0, 0.5))

    --Draw polygons多边形：顶点列表，顶点数，填充颜色，边的颜色
    local points = { cc.p(size.height/4, 0), cc.p(size.width, size.height / 5), cc.p(size.width / 3 * 2, size.height) }
    draw:drawPolygon(points, table.getn(points), cc.c4f(1,0,0,0.5), 4, cc.c4f(0,0,1,1))
    ]] 
end

function DrawGraphTest:getRandPos()
    -- x=cos(a * t) + sin(b * t)，y=sin(a * t) + cos(b * t)
    -- 其中，t为0到2*pi的自变量，a和b是可变的正整数。其图形如下
    local a = math.floor(math.random(1,100))
    local b = math.floor(math.random(1,100))
    local t = 5.2 + math.random()
    local posx = math.cos(a * t) + math.sin(b * t)
    posx = posx * 100 + size.width/2
    posy = posy * 100 + size.height/2

    return cc.p(posx,posy)
end 

function DrawGraphTest:update(delta)
    local startPos = self:getRandPos()
    local endPos = self:getRandPos()
    --画线段：起点，终点，线宽，颜色
    self.draw:drawSegment(startPos, endPos, 1, cc.c4f(0, 1, 1, 0.5))
end 

return DrawGraphTest
