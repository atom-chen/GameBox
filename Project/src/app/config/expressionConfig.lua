-- 表情配置表
local ExpressionConfig = {}

local configs = {
    [1] = {Id = 1, Path = "图片路径", AniPath = "动画路径"},
    [2] = {Id = 1, Path = "图片路径", AniPath = "动画路径"},
    [3] = {Id = 1, Path = "图片路径", AniPath = "动画路径"},
    [4] = {Id = 1, Path = "图片路径", AniPath = "动画路径"},
    [5] = {Id = 1, Path = "图片路径", AniPath = "动画路径"},
}

-- 获取所有数据
function ExpressionConfig.getAllDatas()
    return configs 
end 

-- 获取指定Id数据
function ExpressionConfig.getExpressionById(Id)
    local config = config[Id]
    if not config then 
        return 
    end 

    return config[Id]
end 

return ExpressionConfig