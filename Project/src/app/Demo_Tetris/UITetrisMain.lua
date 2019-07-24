-- 
local LINE = 20                     -- 行数
local COLUME = 10                   -- 列数
local BOX_W, BOX_H = 20, 20         -- 格子大小
local SPACE = 2                     -- 每行/列间隔
-- 左上方格子起始点位置
local STARTPOS = cc.p(display.width/2 - BOX_W * COLUME/2, display.height - BOX_H)  
-- 格子颜色
SHOW_COLOR = cc.c3b(52, 228, 249)
HIDE_COLOR = cc.c3b(255, 255, 255)

local UITetrisMain = class("UITetrisMain", function()
    return newLayerColor(cc.size(display.width, display.height), 255)
end)

-- 初始化
function UITetrisMain:ctor()
    self._startBtn = nil            -- 开始按钮
    self._resetBtn = nil            -- 重玩按钮
    self._exitBtn = nil             -- 退出按钮
    self._scoreLabel = nil          -- 分数
    self._squares = {}              -- 格子精灵集合
    self._timeScheduler = nil       -- 时间定时器

    self._squareType = nil          -- 当前方块类型
    self._curLine = nil             -- 方块当前所处的行数
    self._curColume = nil           -- 方块当前所处的列数

    self:_init()
end 

function UITetrisMain:_init()
    self._startBtn = ccui.Button:create(Res.BTN_N, Res.BTN_P, Res.BTN_D)
    self._startBtn:addTouchEventListener(handler(self, self._startEvent))
    self._startBtn:setTitleColor(cc.c3b(0,0,0))
    self._startBtn:setPosition(100, display.height/2)
    self._startBtn:setTitleFontSize(18)
    self._startBtn:setTitleText("开 始")
    self:addChild(self._startBtn)

    self._resetBtn = ccui.Button:create(Res.BTN_N, Res.BTN_P, Res.BTN_D)
    self._resetBtn:addTouchEventListener(handler(self, self._resetEvent))
    self._resetBtn:setTitleColor(cc.c3b(0,0,0))
    self._resetBtn:setPosition(100, display.height/2)
    self._resetBtn:setTitleFontSize(18)
    self._resetBtn:setTitleText("重 玩")
    self._resetBtn:setVisible(false)
    self:addChild(self._resetBtn)

    self._exitBtn = ccui.Button:create(Res.CLOSE_IMG, Res.CLOSE_IMG, Res.CLOSE_IMG)
    self._exitBtn:addTouchEventListener(handler(self, self._exitEvent))
    self._exitBtn:setPosition(cc.p(display.width - 30, 30))
    self:addChild(self._exitBtn)

    self._scoreLabel = ccui.Text:create()
    self._scoreLabel:setPosition(cc.p(display.width - 20, display.height - 20))
    self._scoreLabel:setAnchorPoint(cc.p(1, 0.5))
    self._scoreLabel:setString("分数： 0")
    self._scoreLabel:setFontSize(30)
    self:addChild(self._scoreLabel)

    -- 初始化格子
    for i = 1, LINE do 
        self._squares[i] = {}
        for j = 1, COLUME do 
            self._squares[i][j] = cc.Sprite:create("tetris/square.png")
            local posx = STARTPOS.x + (j-1)*(BOX_W + SPACE) + BOX_W/2
            local posy = STARTPOS.y - (i-1)*(BOX_H + SPACE) - BOX_H/2
            self._squares[i][j]:setPosition(cc.p(posx, posy))
            self._squares[i][j]:setColor(cc.c3b(255, 255, 255))
            self._squares[i][j]:setTag(0)
            self:addChild(self._squares[i][j])
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
        self._timeScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(_handler, 1.0, false)
    end 
    -- 设置方块类型
    self:_newSquareType()
    
    -- 隐藏按钮
    self._startBtn:setVisible(false)
    self._resetBtn:setVisible(true)
end 

-- 重玩按钮事件
function UITetrisMain:_resetEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 

    for i = 1, LINE do 
        for j = 1, COLUME do 
            self._squares[i][j]:setColor(cc.c3b(255, 255, 255))
            self._squares[i][j]:setTag(0)
        end 
    end 
    self:_newSquareType()
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
end 
 
-- 
function UITetrisMain:_onKeyReleased(keyCode, event)
    if keyCode == cc.KeyCode.KEY_UP_ARROW or keyCode == cc.KeyCode.KEY_W then 
        -- 上
    elseif keyCode == cc.KeyCode.KEY_DOWN_ARROW or keyCode == cc.KeyCode.KEY_S then 
        self:_updateDown()          -- 下
    elseif keyCode == cc.KeyCode.KEY_LEFT_ARROW or keyCode == cc.KeyCode.KEY_A then 
        self:_updateLeft()          -- 左
    elseif keyCode == cc.KeyCode.KEY_RIGHT_ARROW or keyCode == cc.KeyCode.KEY_D then 
        self:_updateRight()         -- 右
    end 
end 

-- 新的方块类型
function UITetrisMain:_newSquareType()
    math.newrandomseed()
    self._squareType = math.floor(math.random(1, 19))
    if not self._squareType then 
        return 
    end 
    self._squareType = 1

    print("方块类型为:" .. self._squareType)
    local typeTab1 = {1,3,4,9,10,11,12,15,16}
    local typeTab2 = {2,5,6,7,8,13,14,17,18,19} 
    if table.indexof(typeTab1, self._squareType) then 
        self._curLine = 1
        self._curColume = 3
    elseif table.indexof(typeTab2, self._squareType) then 
        self._curLine = 1
        self._curColume = 4
    end 
end 

-- 方块下降
function UITetrisMain:_updateDown(dt)
    if self._squareType == 1 then 
        -- 判定是否允许继续下降
        if self._curLine >= LINE then 
            self:_clearLine(LINE, LINE)
            self:_newSquareType()
            return 
        end 
        -- 检测下方一行是否有方块
        for i = 1, 4 do 
            local tag = self._squares[self._curLine+1][self._curColume+i]:getTag()
            if tag == 1 then 
                self:_clearLine(self._curLine, self._curLine)
                self:_newSquareType()
                return 
            end 
        end 

        -- 下降一格
        for i = 1, 4 do 
            -- 消除原色
            if self._curLine < LINE and self._curLine - 1 > 0 then 
                self._squares[self._curLine][self._curColume + i]:setColor(HIDE_COLOR)
                self._squares[self._curLine][self._curColume + i]:setTag(0)
            end 
            -- 显示新色
            if self._curLine < LINE then 
                self._squares[self._curLine+1][self._curColume + i]:setColor(SHOW_COLOR)
                self._squares[self._curLine+1][self._curColume + i]:setTag(1)
            end 
        end 
        self._curLine = self._curLine + 1
    elseif self._squareType == 2 then 
        -- 判定是否允许继续下降
        if self._curLine > LINE then 
            self:_clearLine(LINE, LINE)
            self:_newSquareType()
            return 
        end 
        -- 检测下方一行是否有方块
        local tag = self._squares[self._curLine][self._curColume]
        if tag == 1 then 
            self:_clearLine(self._curLine - 4, self._curLine - 1)
            self:_newSquareType()
            return 
        end 

        -- 下降一格
        if self._curLine < LINE and self._curLine - 4 > 0 then 
            self._squares[self._curLine - 4][self._curColume]:setColor(HIDE_COLOR)
            self._squares[self._curLine - 4][self._curColume]:setTag(0)
        end 
        if self._curLine < LINE then 
            self._squares[self._curLine][self._curColume]:setColor(SHOW_COLOR)
            self._squares[self._curLine][self._curColume]:setTag(1)
        end 
        self._curLine = self._curLine + 1
    end 
end 

-- 方块左移
function UITetrisMain:_updateLeft()
    if self._squareType == 1 then 
        -- 检测是否允许左移动
        if self._curColume <= 1 then
            return 
        end  
        if self._squares[self._curLine][self._curColume]:getTag() == 1 then 
            return 
        end 

        -- 左移动一格
        for i = self._curColume, self._curColume + 3 do 
            self._squares[self._curLine][i]:setColor(SHOW_COLOR)
            self._squares[self._curLine][i]:setTag(1)
            if i == self._curColume + 3 then 
                self._squares[self._curLine][i+1]:setColor(HIDE_COLOR)
                self._squares[self._curLine][i+1]:setTag(0)
            end 
        end 
    elseif self._squareType == 2 then 
        -- 检测是否允许左移动
        if self._curColume <= 0 then 
            return 
        end 
        for i = 1, 4 do 
            if self._curLine - 4 + i <= 1 then 
                return 
            end 
            if self._squares[self._curLine - 4 + i][self._curColume-1]:getTag() == 1 then
                return 
            end  
        end 

        -- 左移动一格
        for i = 1, 4 do 
            self._squares[self._curLine-4+i][self._curColume - 1]:setColor(SHOW_COLOR)
            self._squares[self._curLine-4+i][self._curColume - 1]:setTag(1)
            self._squares[self._curLine-4+i][self._curColume]:setColor(HIDE_COLOR)
            self._squares[self._curLine-4+i][self._curColume]:setTag(0)
        end 
    end 
    self._curColume = self._curColume - 1
end 

-- 方块右移
function UITetrisMain:_updateRight()
    if self._squareType == 1 then 
        -- 检测是否允许向右移动
        if self._curLine - 1 <= 0 or self._curColume + 4 >= COLUME then 
            return 
        end 
        if self._squares[self._curLine][self._curColume + 4 + 1]:getTag() == 1 then 
            return 
        end 
        
        -- 右移动一格
        for i = self._curColume + 4, self._curColume, -1 do 
            self._squares[self._curLine][i+1]:setColor(SHOW_COLOR)
            self._squares[self._curLine][i+1]:setTag(1)
            if i == self._curColume then 
                self._squares[self._curLine][i+1]:setColor(HIDE_COLOR)
                self._squares[self._curLine][i+1]:setTag(0)
            end 
        end 
        self._curColume = self._curColume + 1
    end 
end

-- 消除整行
function UITetrisMain:_clearLine(startLine, endLine)
    -- 检测是否结束
    --self:_checkIsEnd()

    -- 
    for i = startLine, endLine do 
        for j = 1, COLUME do 
            local tag = self._squares[i][j]:getTag()
            if i > -1 and tag == 0 then 
                break 
            end 

            -- 清除一行
            if j == COLUME then 
                for line = i, 1 -1 do 
                    self:_copyLine(line)
                end 
                for x = 1, COLUME do 
                    self._squares[1][x]:setColor(cc.c3b(255, 255, 255))
                    self._squares[1][x]:setTag(0)
                end 
            end 
        end 
    end 
end 

-- 向下拷贝一行
function UITetrisMain:_copyLine(lineNum)
    for i = 1, COLUME do 
        local color = self._squares[lineNum][i]:getColor()
        local tag = self._squares[lineNum][i]:getTag()
        self._squares[lineNum + 1][i]:setColor(color)
        self._squares[lineNum + 1][i]:setTag(tag)
    end 
end 

-- 检测是否结束
function UITetrisMain:_checkIsEnd()
    if self._squareType == 1 then 
        if self._curLine - 1 < 0 then 
            self:_gameOver()
        end 
    elseif self._squareType == 2 then
        if self._curLine - 4 < 0 then 
            self:_gameOver()
        end 
    elseif self._squareType == 3 or self._squareType == 5 or self._squareType == 7 or 
    self._squareType == 9 or self._squareType == 11 or self._squareType == 13 or 
    self._squareType == 15 or self._squareType == 17 or self._squareType == 19 then 
        if self._curLine - 2 < 0 then 
            self:_gameOver()
        end 
    elseif self._squareType == 4 or self._squareType == 6 or self._squareType == 8 or 
    self._squareType == 10 or self._squareType == 12 or self._squareType == 14 or 
    self._squareType == 16 or self._squareType == 18 then 
        if self._curLine - 3 < 0 then 
            self:_gameOver()
        end 
    end 
end 

-- 游戏结束
function UITetrisMain:_gameOver()
    MsgTip("游戏结束")
end 

return UITetrisMain