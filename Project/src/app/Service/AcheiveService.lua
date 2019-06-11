--
local AchieveConfig = require("app.config.AchieveConfig")

local AcheiveService = class("AcheiveService")

local _instance = nil 
function AcheiveService:getInstance()
    print("AcheiveService:getInstance ......1")
    if _instance == nil then 
        print("AcheiveService:getInstance ......2")
        _instance = AcheiveService.new()
    end 
    return _instance
end 

function AcheiveService:ctor()
    self._achievelist = {}
end 

function AcheiveService:init()
    print("AcheiveService:init ......3")
    self._achievelist = AchieveConfig.getAchieveList()
end 

-- 获取指定成就的完成状态
function AcheiveService:getAchieveRewardState(id)
    -- 其成就的状态如何，本应该通过服务器获取，目前先使用测试数据
    return AchieveConfig.NO_FINISH
end 

-- 获取指定成就的进度
function AcheiveService:getAchieveCurProcess(id)
    -- 其进度从服务器中获取，先添加测试数据
    return 0
end 

-- 获取新成就数据表，仅显示未完成的，且按照每个任务类型来显示
function AcheiveService:getAchieveList()
    local datalist = {}
    for i,data in pairs(self._achievelist) do 
        local id = data.itemId
        local rewardState = self:getAchieveRewardState(id)
        print("................................0")
        print(rewardState or "nil")
        print(AchieveConfig.FINISHED or "nil")
        if rewardState ~= AchieveConfig.FINISHED then
            data.totalprocess = data.count  
            data.curprocess = self:getAchieveCurProcess(id)
            data.rewardstate = self:getAchieveRewardState(id)
            table.insert(datalist, data)
            print("................................1")
        end 
    end 

    table.sort(datalist, function(a,b)
        -- 先判定任务类型
        if a.tasktype ~= b.tasktype then 
            return a.tasktype < b.tasktype
        end 
        -- 任务类型相同，判定总进度
        return a.totalprocess < b.totalprocess
    end)
    return datalist
end 

function AcheiveService:destroy()
    --
end 

return AcheiveService