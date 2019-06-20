--[[
	itemId:[number] 成就ID
	state:[string] 描述
	tasktype:[number] 任务类型
	totalprocess:[number] 完成条件
	isEmail:[bool] 是否邮箱发送
	rewardtype:[number] 奖励类型
	rewardnum:[number] 奖励数目
	iconRes:[string] 图标资源名
]]
local config = {
	[1024] = {itemId = 1024,state = "总共杀死40000个敌人",tasktype = 4,totalprocess = 40000,isEmail = true,rewardtype = 5,rewardnum = 33,iconRes = "achieve_title35.png",},
	[1025] = {itemId = 1025,state = "总共杀死50000个敌人",tasktype = 4,totalprocess = 50000,isEmail = true,rewardtype = 5,rewardnum = 34,iconRes = "achieve_title36.png",},
	[1001] = {itemId = 1001,state = "玩家升到2级",tasktype = 1,totalprocess = 2,isEmail = true,rewardtype = 5,rewardnum = 10,iconRes = "achieve_title1.png",},
	[1002] = {itemId = 1002,state = "玩家升到5级",tasktype = 1,totalprocess = 5,isEmail = true,rewardtype = 5,rewardnum = 11,iconRes = "achieve_title2.png",},
	[1003] = {itemId = 1003,state = "玩家升到10级",tasktype = 1,totalprocess = 10,isEmail = true,rewardtype = 5,rewardnum = 12,iconRes = "achieve_title3.png",},
	[1004] = {itemId = 1004,state = "玩家升到15级",tasktype = 1,totalprocess = 15,isEmail = true,rewardtype = 5,rewardnum = 13,iconRes = "achieve_title4.png",},
	[1005] = {itemId = 1005,state = "玩家升到20级",tasktype = 1,totalprocess = 20,isEmail = true,rewardtype = 5,rewardnum = 14,iconRes = "achieve_title5.png",},
	[1006] = {itemId = 1006,state = "玩家升到25级",tasktype = 1,totalprocess = 25,isEmail = true,rewardtype = 5,rewardnum = 15,iconRes = "achieve_title6.png",},
	[1007] = {itemId = 1007,state = "玩家升到30级",tasktype = 1,totalprocess = 30,isEmail = true,rewardtype = 5,rewardnum = 16,iconRes = "achieve_title7.png",},
	[1008] = {itemId = 1008,state = "玩家升到40级",tasktype = 1,totalprocess = 40,isEmail = true,rewardtype = 5,rewardnum = 17,iconRes = "achieve_title8.png",},
	[1009] = {itemId = 1009,state = "玩家升到50级",tasktype = 1,totalprocess = 50,isEmail = true,rewardtype = 5,rewardnum = 18,iconRes = "achieve_title9.png",},
	[1010] = {itemId = 1010,state = "收集金币1000个",tasktype = 2,totalprocess = 1000,isEmail = true,rewardtype = 5,rewardnum = 19,iconRes = "achieve_title21.png",},
	[1011] = {itemId = 1011,state = "收集金币2000个",tasktype = 2,totalprocess = 2000,isEmail = true,rewardtype = 5,rewardnum = 20,iconRes = "achieve_title22.png",},
	[1012] = {itemId = 1012,state = "收集金币3000个",tasktype = 2,totalprocess = 3000,isEmail = true,rewardtype = 5,rewardnum = 21,iconRes = "achieve_title23.png",},
	[1013] = {itemId = 1013,state = "收集金币4000个",tasktype = 2,totalprocess = 4000,isEmail = true,rewardtype = 5,rewardnum = 22,iconRes = "achieve_title24.png",},
	[1014] = {itemId = 1014,state = "收集金币5000个",tasktype = 2,totalprocess = 5000,isEmail = true,rewardtype = 5,rewardnum = 23,iconRes = "achieve_title25.png",},
	[1015] = {itemId = 1015,state = "通关第一章",tasktype = 3,totalprocess = 1,isEmail = true,rewardtype = 5,rewardnum = 24,iconRes = "achieve_title26.png",},
	[1016] = {itemId = 1016,state = "通关第二章",tasktype = 3,totalprocess = 2,isEmail = true,rewardtype = 5,rewardnum = 25,iconRes = "achieve_title27.png",},
	[1017] = {itemId = 1017,state = "通关第三章",tasktype = 3,totalprocess = 3,isEmail = true,rewardtype = 5,rewardnum = 26,iconRes = "achieve_title28.png",},
	[1018] = {itemId = 1018,state = "通关第四章",tasktype = 3,totalprocess = 4,isEmail = true,rewardtype = 5,rewardnum = 27,iconRes = "achieve_title29.png",},
	[1019] = {itemId = 1019,state = "通关第五章",tasktype = 3,totalprocess = 5,isEmail = true,rewardtype = 5,rewardnum = 28,iconRes = "achieve_title30.png",},
	[1020] = {itemId = 1020,state = "通关第六章",tasktype = 3,totalprocess = 6,isEmail = true,rewardtype = 5,rewardnum = 29,iconRes = "achieve_title31.png",},
	[1021] = {itemId = 1021,state = "总共杀死10000个敌人",tasktype = 4,totalprocess = 10000,isEmail = true,rewardtype = 5,rewardnum = 30,iconRes = "achieve_title32.png",},
	[1022] = {itemId = 1022,state = "总共杀死20000个敌人",tasktype = 4,totalprocess = 20000,isEmail = true,rewardtype = 5,rewardnum = 31,iconRes = "achieve_title33.png",},
	[1023] = {itemId = 1023,state = "总共杀死30000个敌人",tasktype = 4,totalprocess = 30000,isEmail = true,rewardtype = 5,rewardnum = 32,iconRes = "achieve_title34.png",},
}
return AchieveConfig