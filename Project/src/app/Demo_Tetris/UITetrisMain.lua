-- 
local LINE = 20                     -- 行数
local COLUME = 10                   -- 列数
local BOX_W, BOX_H = 20, 20         -- 格子大小
local SPACE = 2                     -- 每行/列间隔
-- 左上方格子起始点位置
local STARTPOS = cc.p(display.width/2 - BOX_W * COLUME/2, display.height - BOX_H)  
-- 格子颜色
SHOW_COLOR = cc.c3b(255, 0, 0)
HIDE_COLOR = cc.c3b(255, 255, 255)
-- 地图大小


local config = require("app.Demo_Tetris.GridConfig")
local UITetrisMain = class("UITetrisMain", function()
    return newLayerColor(cc.size(display.width, display.height), 255)
end)

-- 初始化
function UITetrisMain:ctor()
    self._startBtn = nil            -- 开始按钮
    self._resetBtn = nil            -- 重玩按钮
    self._exitBtn = nil             -- 退出按钮
    self._scoreLabel = nil          -- 分数
    self._map = {}                  -- 格子精灵集合
    self._gridImg = nil             -- 当前图形
    self._timeScheduler = nil       -- 时间定时器

    self._gridType = nil            -- 当前方块类型
    self._curLine = nil             -- 方块当前所处的行数
    self._curColume = nil           -- 方块当前所处的列数
    self._curScore = 0              -- 当前分数

    self:_init()
end 

function UITetrisMain:_init()
    -- 开始按钮
    self._startBtn = ccui.Button:create(Res.BTN_N, Res.BTN_P, Res.BTN_D)
    self._startBtn:addTouchEventListener(handler(self, self._startEvent))
    self._startBtn:setTitleColor(cc.c3b(0,0,0))
    self._startBtn:setPosition(100, display.height/2)
    self._startBtn:setTitleFontSize(18)
    self._startBtn:setTitleText("开 始")
    self:addChild(self._startBtn)
    -- 重玩按钮
    self._resetBtn = ccui.Button:create(Res.BTN_N, Res.BTN_P, Res.BTN_D)
    self._resetBtn:addTouchEventListener(handler(self, self._resetEvent))
    self._resetBtn:setTitleColor(cc.c3b(0,0,0))
    self._resetBtn:setPosition(100, display.height/2)
    self._resetBtn:setTitleFontSize(18)
    self._resetBtn:setTitleText("重 玩")
    self._resetBtn:setVisible(false)
    self:addChild(self._resetBtn)
    -- 退出按钮
    self._exitBtn = ccui.Button:create(Res.CLOSE_IMG, Res.CLOSE_IMG, Res.CLOSE_IMG)
    self._exitBtn:addTouchEventListener(handler(self, self._exitEvent))
    self._exitBtn:setPosition(cc.p(display.width - 30, 30))
    self:addChild(self._exitBtn)
    -- 分数
    self._scoreLabel = ccui.Text:create()
    self._scoreLabel:setPosition(cc.p(display.width - 20, display.height - 20))
    self._scoreLabel:setAnchorPoint(cc.p(1, 0.5))
    self._scoreLabel:setString("分数： 0")
    self._scoreLabel:setFontSize(30)
    self:addChild(self._scoreLabel)

    --[[
    初始化背景
    以左上角为起始位置，X轴为列，向右加，范围为[1, COLUME]; Y轴为行，向下加，范围为[1, LINE]
    每个行列位置默认标记为 0，表示没有格子，颜色显示为HIDE_COLOR
    若有格子，TAG 标记为 1， 颜色显示为SHOW_COLOR 
    ]]
    for i = 1, LINE do 
        self._map[i] = {}
        for j = 1, COLUME do 
            self._map[i][j] = cc.Sprite:create("tetris/square.png")
            local posx = STARTPOS.x + (j-1)*(BOX_W + SPACE) + BOX_W/2
            local posy = STARTPOS.y - (i-1)*(BOX_H + SPACE) - BOX_H/2
            self._map[i][j]:setPosition(cc.p(posx, posy))
            self._map[i][j]:setColor(HIDE_COLOR)
            self._map[i][j]:setTag(0)
            self:addChild(self._map[i][j])
        end 
    end 

    -- 键盘监听
    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(handler(self, self._onKeyReleased), cc.Handler.EVENT_KEYBOARD_RELEASED)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
end 

-- 开始按钮事件
function UITetrisMain:_startEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 

    if self._timeScheduler == nil then 
        local _handler = handler(self, self._updateDown)
        self._timeScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(_handler, 0.5, false)
    end 
    self._startBtn:setVisible(false)
    self._resetBtn:setVisible(true)
    -- 设置新方块
    self:_newGrid()
end 

-- 重玩按钮事件
function UITetrisMain:_resetEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 

    -- 关闭定时器
    if self._timeScheduler ~= nil then 
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timeScheduler)
        self._timeScheduler = nil 
    end 

    for i = 1, LINE do 
        for j = 1, COLUME do 
            self._map[i][j]:setColor(HIDE_COLOR)
            self._map[i][j]:setTag(0)
        end 
    end 
    self._gridImg:removeFromParent()
    self:_newGrid()
end 

-- 结束按钮事件
function UITetrisMain:_exitEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 

    -- 关闭定时器
    if self._timeScheduler ~= nil then 
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timeScheduler)
        self._timeScheduler = nil 
    end 
    self:removeFromParent()
end 
 
-- 
function UITetrisMain:_onKeyReleased(keyCode, event)
    if keyCode == cc.KeyCode.KEY_UP_ARROW or keyCode == cc.KeyCode.KEY_W then 
        self:_changeGrid()
    elseif keyCode == cc.KeyCode.KEY_DOWN_ARROW or keyCode == cc.KeyCode.KEY_S then 
        self:_updateDown()          -- 下
    elseif keyCode == cc.KeyCode.KEY_LEFT_ARROW or keyCode == cc.KeyCode.KEY_A then 
        self:_updateLeft()          -- 左
    elseif keyCode == cc.KeyCode.KEY_RIGHT_ARROW or keyCode == cc.KeyCode.KEY_D then 
        self:_updateRight()         -- 右
    end 
end 

-- 新的方块
function UITetrisMain:_newGrid()
    -- 若图形已存在，将图形所在区域颜色设置为SHOW_COLOR 
    if self._gridImg ~= nil then 
        self._gridImg:removeFromParent()
        print("当前行列数:", self._curLine, self._curColume)
        for gridline = 4, 1, -1 do 
            for gridcol = 1, 4 do 
                if self._gridTab[gridline][gridcol] == 1 then 
                    -- 将图形格子行列坐标转换为地图行列坐标
                    local mapLine, mapCol = nil, nil 
                    if gridline == self._gridMaxLine then 
                        mapLine = self._curLine 
                    else 
                        mapLine = self._curLine - (self._gridMaxLine - gridline)
                    end 
                    mapCol = self._curColume + gridcol - 1
                    
                    local str = string.format("地图新行列(%d:%d); 格子行列(%d：%d)", mapLine, mapCol, gridline, gridcol)
                    print(str)
                    if self._map[mapLine][mapCol] then 
                        self._map[mapLine][mapCol]:setColor(SHOW_COLOR)
                        self._map[mapLine][mapCol]:setTag(1)
                    end 
                end 
            end 
        end 
    end 

    -- 获取新类型
    local data = config.getNewGridData()
    if not data then 
        MsgTip("配置数据出错")
        return 
    end 
    self._gridType = data.type 
    self._curLine = 1
    self._curColume = data.startCol
    self._gridMaxLine = data.maxGridLine
    self._gridMaxCol = data.maxGridCol
    self._gridTab = data.gridTab

    -- 创建图片
    self._gridImg = cc.Sprite:create(data.img)
    self._gridImg:setAnchorPoint(cc.p(0,0))
    local gridSize = self._gridImg:getContentSize()
    local posx = STARTPOS.x + (self._curColume - 1) * (BOX_W + SPACE)
    local posy = STARTPOS.y + SPACE
    
    self._gridImg:setPosition(cc.p(posx, posy))
    self:addChild(self._gridImg, 100)
end 

-- 变换方块
function UITetrisMain:_changeGrid()
    --
end 

-- 方块下降
function UITetrisMain:_updateDown(dt) 
    -- 判定是否允许继续下降
    if self._curLine >= LINE then 
        -- 检测是否可清除一行
        self:_clearLine(LINE - self._gridMaxLine + 1, LINE)
        -- 生成新的方块
        self:_newGrid()
        return 
    end 

    -- 检测下方一行是否可放置图形格
    for gridline = 4, 1, -1 do 
        for gridcol = 1, 4 do 
            if self._gridTab[gridline][gridcol] == 1 then 
                -- 将图形格子行列坐标转换为地图行列坐标
                local mapLine, mapCol = nil, nil 
                if gridline == self._gridMaxLine then 
                    mapLine = self._curLine 
                else 
                    mapLine = self._curLine - (self._gridMaxLine - gridline)
                end 
                mapCol = self._curColume + gridcol - 1
                if mapLine >= 1 and mapCol >= 1 and self._map[mapLine + 1][mapCol] then 
                    local maptag = self._map[mapLine + 1][mapCol]:getTag()
                    if maptag == 1 then 
                        -- 检测是否可清除一行
                        self:_clearLine(self._curLine - self._gridMaxLine + 1, self._curLine)
                        -- 生成新的方块
                        self:_newGrid()
                        return 
                    end 
                end 
            end 
        end 
    end 

    -- 下降一格
    local posy = self._gridImg:getPositionY()
    self._gridImg:setPositionY(posy - BOX_H - SPACE)
    self._curLine = self._curLine + 1
end 

-- 方块左移
function UITetrisMain:_updateLeft()
    -- 检测是否允许左移
    if self._curColume <= 1 then 
        return 
    end 
    -- 检测左移一格是否存在格子
    if self._map[self._curLine][self._curColume -1]:getTag() == 1 then 
        return 
    end 

    -- 左移一格
    local posx = self._gridImg:getPositionX()
    self._gridImg:setPositionX(posx - BOX_W - SPACE)
    -- 当前列数递减
    self._curColume = self._curColume - 1
end 

-- 方块右移
function UITetrisMain:_updateRight()
    -- 检测是否允许右移
    if self._curColume - 1 + self._gridMaxCol >= COLUME then 
        return 
    end 
    -- 检测右移一格是否存在格子
    if self._map[self._curLine][self._curColume + self._gridMaxCol]:getTag() == 1 then 
        return 
    end 
    -- 右移一格
    local posx = self._gridImg:getPositionX()
    self._gridImg:setPositionX(posx + BOX_W + SPACE)
    -- 当前列数递加
    self._curColume = self._curColume + 1
end

-- 消除整行
function UITetrisMain:_clearLine(startLine, endLine)
    print("检测消除的行数为:", startLine, endLine)
    -- 检测是否结束
    self:_checkIsEnd()

    -- 消除行数
    local clearLineNum = 0              
    for i = startLine, endLine do 
        for j = 1, COLUME do 
            if i >= 1 then 
                local tag = self._map[i][j]:getTag()
                if tag == 0 then 
                    break 
                end 

                -- 清除一行
                if j == COLUME then 
                    for line = i, 1 -1 do 
                        self:_copyLine(line)
                    end 
                    for x = 1, COLUME do 
                        self._map[1][x]:setColor(HIDE_COLOR)
                        self._map[1][x]:setTag(0)
                    end 
                    clearLineNum = clearLineNum + 1
                end 
            end 
        end 
    end 

    -- 更新分数
    self:_updateScore(clearLineNum)
end 

-- 向下拷贝一行
function UITetrisMain:_copyLine(lineNum)
    for i = 1, COLUME do 
        local color = self._map[lineNum][i]:getColor()
        local tag = self._map[lineNum][i]:getTag()
        self._map[lineNum + 1][i]:setColor(color)
        self._map[lineNum + 1][i]:setTag(tag)
    end 
end 

-- 更新分数
function UITetrisMain:_updateScore(clearLineNum)
    clearLineNum = tonumber(clearLineNum) or 0
    if clearLineNum <= 0 then 
        return 
    end 

    -- 倍率
    local multis = {1, 1, 1.5, 2}
    self._curScore = self._curScore + multis[clearLineNum] * 100
    self._scoreLabel:setString("分数：" .. self._curScore)
end 

-- 检测是否结束
function UITetrisMain:_checkIsEnd()
    local isEnd = false 
    if self._curLine + self._gridMaxLine - 1 <= 0 then 
        MsgTip("游戏结束")
        isEnd = true 
    end 

    if not isEnd then 
        return 
    end 

    -- 关闭定时器
    if self._timeScheduler ~= nil then 
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._timeScheduler)
        self._timeScheduler = nil 
    end 

    -- 显示开始按钮
    self._startBtn:setVisible(true)
    self._resetBtn:setVisible(false)
end 

-- 游戏结束
function UITetrisMain:_gameOver()
   
end 

return UITetrisMain