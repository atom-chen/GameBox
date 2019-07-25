--[[
图形配置表
    每个图形的二维图数据为 4 * 4,若为1，表示存在格子，若为0，则不存在
]]

local gridConfig = {}

-- 图形数据
local typeTab = {
    -- 横条
    [1] = {
        gridTab = {             -- 二维数组格子数据
            {1,1,1,1},
            {0,0,0,0},
            {0,0,0,0},
            {0,0,0,0},
        },
        maxGridLine = 1,        -- 最大有效行
        maxGridCol = 4,         -- 最大有效列
        startCol = 4,           -- 地图的起始列位置
        type = 1,
        img = "tetris/1.png",   -- 对应的图片
    },
    -- 竖条
    [2] = {
        gridTab = { 
            {1,0,0,0},
            {1,0,0,0},
            {1,0,0,0},
            {1,0,0,0},
        },
        maxGridLine = 4, 
        maxGridCol = 1,
        startCol = 5,
        type = 2,
        img = "tetris/2.png",
    },
    -- 方块
    [3] = {
        gridTab = {
            {1,1,0,0},
            {1,1,0,0},
            {0,0,0,0},
            {0,0,0,0},
        },
        maxGridLine = 2,
        maxGridCol = 2,
        startCol = 5, 
        type = 3,
        img = "tetris/19.png", 
    },
    -- 七相关
    [4] = {
        gridTab = { 
            {1,1,0,0},
            {0,1,0,0},
            {0,1,0,0},
            {0,0,0,0},
        },
        maxGridLine = 3,
        maxGridCol = 2,
        startCol = 5, 
        type = 4,
        img = "tetris/10.png", 
    },
    [5] = {
        gridTab = {             
            {1,1,0,0},
            {0,1,1,0},
            {0,0,0,0},
            {0,0,0,0},
        },
        maxGridLine = 2,
        maxGridCol = 3,
        startCol = 4,
        type = 5,
        img = "tetris/13.png",
    },
    -- 正土
    [6] = {
        gridTab = {
            {0,1,0,0},
            {1,1,1,0},
            {0,0,0,0},
            {0,0,0,0},
        },
        maxGridLine = 2,
        maxGridCol = 3,
        startCol = 4,
        type = 6,
        img = "tetris/15.png", 
    },
}

-- 图形数目
local GRID_NUM = #typeTab

-- 随机获取方块类型
function gridConfig.getNewGridData()
    math.newrandomseed()
    local index = math.floor(math.random(1,GRID_NUM))
    return typeTab[index]
end 

-- 获取指定类型数据
function gridConfig.getGridDataByType(_type)
    if _type < 0 or _type > GRID_NUM then 
        return 
    end 
    return typeTab[_type]
end 

return gridConfig