--[[
	itemId:[number] 成就ID
	state:[string] 描述
	tasktype:[number] 任务类型（1 等级 2 金币 3 章节 4 击杀敌人数目）
	totalprocess:[number] 完成条件
	isEmail:[bool] 是否邮箱发送
	rewardtype:[number] 奖励类型(1金币 2体力 3弹药 4钻石 5勋章)
	rewardnum:[number] 奖励数目
	iconRes:[string] 图标资源名
]]

local AchieveConfig = {
	-- 完成状态
	NO_FINISH = 1,			-- 未完成
	FINISH_GET = 2,			-- 完成未领取
	FINISHED = 3,			-- 已领取
	OUT_DATE = 4,			-- 已过期
}

-- 任务类型
local _TASKTYPE = {
	NONE = 0,
	LEVEL = 1,				-- 等级
	MONEY = 2,				-- 金币
	CHAPTER = 3,			-- 章
	KILL_ALL = 4,			-- 击杀敌人数目
	KILL_GUN = 5,			-- 枪械击杀敌人数目
	KILL_KNIFE = 6,			-- 刀具击杀敌人数目

	COUNT = 7,
}
AchieveConfig.TASKTYPE = _TASKTYPE

-- 奖励类型

local _REWARD = {
	NONE = 0,
	MONEY = 1,				-- 金币
	POWER = 2,				-- 体力
	BULLET = 3,				-- 弹药
	DIAMOND = 4,			-- 钻石
	MEDAL = 5,				-- 勋章
}
AchieveConfig.REWARDTYPE = _REWARD

local config = {
	[1001] = {itemId = 1001.0,state = "玩家升到2级",tasktype = 1.0,totalprocess = 2.0,isEmail = true,rewardtype = 5.0,rewardnum = 10.0,iconRes = "achieve_title1.png",},
	[1002] = {itemId = 1002.0,state = "玩家升到5级",tasktype = 1.0,totalprocess = 5.0,isEmail = true,rewardtype = 5.0,rewardnum = 11.0,iconRes = "achieve_title2.png",},
	[1003] = {itemId = 1003.0,state = "玩家升到10级",tasktype = 1.0,totalprocess = 10.0,isEmail = true,rewardtype = 5.0,rewardnum = 12.0,iconRes = "achieve_title3.png",},
	[1004] = {itemId = 1004.0,state = "玩家升到15级",tasktype = 1.0,totalprocess = 15.0,isEmail = true,rewardtype = 5.0,rewardnum = 13.0,iconRes = "achieve_title4.png",},
	[1005] = {itemId = 1005.0,state = "玩家升到20级",tasktype = 1.0,totalprocess = 20.0,isEmail = true,rewardtype = 5.0,rewardnum = 14.0,iconRes = "achieve_title5.png",},
	[1006] = {itemId = 1006.0,state = "玩家升到25级",tasktype = 1.0,totalprocess = 25.0,isEmail = true,rewardtype = 5.0,rewardnum = 15.0,iconRes = "achieve_title6.png",},
	[1007] = {itemId = 1007.0,state = "玩家升到30级",tasktype = 1.0,totalprocess = 30.0,isEmail = true,rewardtype = 5.0,rewardnum = 16.0,iconRes = "achieve_title7.png",},
	[1008] = {itemId = 1008.0,state = "玩家升到40级",tasktype = 1.0,totalprocess = 40.0,isEmail = true,rewardtype = 5.0,rewardnum = 17.0,iconRes = "achieve_title8.png",},
	[1009] = {itemId = 1009.0,state = "玩家升到50级",tasktype = 1.0,totalprocess = 50.0,isEmail = true,rewardtype = 5.0,rewardnum = 18.0,iconRes = "achieve_title9.png",},
	[1010] = {itemId = 1010.0,state = "收集金币1000个",tasktype = 2.0,totalprocess = 1000.0,isEmail = true,rewardtype = 5.0,rewardnum = 19.0,iconRes = "achieve_title21.png",},
	[1011] = {itemId = 1011.0,state = "收集金币2000个",tasktype = 2.0,totalprocess = 2000.0,isEmail = true,rewardtype = 5.0,rewardnum = 20.0,iconRes = "achieve_title22.png",},
	[1012] = {itemId = 1012.0,state = "收集金币3000个",tasktype = 2.0,totalprocess = 3000.0,isEmail = true,rewardtype = 5.0,rewardnum = 21.0,iconRes = "achieve_title23.png",},
	[1013] = {itemId = 1013.0,state = "收集金币4000个",tasktype = 2.0,totalprocess = 4000.0,isEmail = true,rewardtype = 5.0,rewardnum = 22.0,iconRes = "achieve_title24.png",},
	[1014] = {itemId = 1014.0,state = "收集金币5000个",tasktype = 2.0,totalprocess = 5000.0,isEmail = true,rewardtype = 5.0,rewardnum = 23.0,iconRes = "achieve_title25.png",},
	[1015] = {itemId = 1015.0,state = "通关第一章",tasktype = 3.0,totalprocess = 1.0,isEmail = true,rewardtype = 5.0,rewardnum = 24.0,iconRes = "achieve_title26.png",},
	[1016] = {itemId = 1016.0,state = "通关第二章",tasktype = 3.0,totalprocess = 2.0,isEmail = true,rewardtype = 5.0,rewardnum = 25.0,iconRes = "achieve_title27.png",},
	[1017] = {itemId = 1017.0,state = "通关第三章",tasktype = 3.0,totalprocess = 3.0,isEmail = true,rewardtype = 5.0,rewardnum = 26.0,iconRes = "achieve_title28.png",},
	[1018] = {itemId = 1018.0,state = "通关第四章",tasktype = 3.0,totalprocess = 4.0,isEmail = true,rewardtype = 5.0,rewardnum = 27.0,iconRes = "achieve_title29.png",},
	[1019] = {itemId = 1019.0,state = "通关第五章",tasktype = 3.0,totalprocess = 5.0,isEmail = true,rewardtype = 5.0,rewardnum = 28.0,iconRes = "achieve_title30.png",},
	[1020] = {itemId = 1020.0,state = "通关第六章",tasktype = 3.0,totalprocess = 6.0,isEmail = true,rewardtype = 5.0,rewardnum = 29.0,iconRes = "achieve_title31.png",},
	[1021] = {itemId = 1021.0,state = "总共杀死10000个敌人",tasktype = 4.0,totalprocess = 10000.0,isEmail = true,rewardtype = 5.0,rewardnum = 30.0,iconRes = "achieve_title32.png",},
	[1022] = {itemId = 1022.0,state = "总共杀死20000个敌人",tasktype = 4.0,totalprocess = 20000.0,isEmail = true,rewardtype = 5.0,rewardnum = 31.0,iconRes = "achieve_title33.png",},
	[1023] = {itemId = 1023.0,state = "总共杀死30000个敌人",tasktype = 4.0,totalprocess = 30000.0,isEmail = true,rewardtype = 5.0,rewardnum = 32.0,iconRes = "achieve_title34.png",},
	[1024] = {itemId = 1024.0,state = "总共杀死40000个敌人",tasktype = 4.0,totalprocess = 40000.0,isEmail = true,rewardtype = 5.0,rewardnum = 33.0,iconRes = "achieve_title35.png",},
	[1025] = {itemId = 1025.0,state = "总共杀死50000个敌人",tasktype = 4.0,totalprocess = 50000.0,isEmail = true,rewardtype = 5.0,rewardnum = 34.0,iconRes = "achieve_title36.png",},
}

-- 获取成就列表
function AchieveConfig.getAchieveList()
	return config 
end 

-- 根据成就ID获取数据
function AchieveConfig.getAchieveDataById(itemId)
	return config[itemId]
end 

-- 根据成就ID获取任务类型
function AchieveConfig.getAchieveTypeById(itemId)
	local data = AchieveConfig.getAchieveDataById(itemId)
	return data.tasktype
end 

-- 根据成就ID获取奖励类型
function AchieveConfig.getAchieveTypeById(itemId)
	local data = AchieveConfig.getAchieveDataById(itemId)
	return data.rewardtype
end 

-- 根据任务类型获取指定的表数据
function AchieveConfig.getTaskDataBytype(tasktype)
	if not tonumber(tasktype) then 
		print("param illegal !!!")
		return 
	end 

	if tasktype <= _TASKTYPE.NONE or tasktype >= _TASKTYPE.COUNT then 
		print("param beyond the boundary !!!")
		return 
	end 

	local _tab = {}
	for i, data in pairs(config) do 
		if data.tasktype == tasktype then 
			table.insert(_tab, data)
		end 
	end  
	return _tab 
end 

return AchieveConfig