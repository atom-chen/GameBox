--[[
	itemId:[number] 成就ID
	itemName:[string] 描述
	tasktype:[number] 任务类型
	count:[number] 完成条件
	isEmail:[bool] 是否邮箱发送
	rewardtype:[number] 奖励类型
	rewardnum:[number] 奖励数目
	iconRes:[string] icon
]]
local AchieveConfig = {
	[1024] = {itemId = 1024.0,itemName = "总共杀死40000个敌人",tasktype = 4.0,count = 40000.0,isEmail = true,rewardtype = 5.0,rewardnum = 33.0,iconRes = "",},
	[1025] = {itemId = 1025.0,itemName = "总共杀死50000个敌人",tasktype = 4.0,count = 50000.0,isEmail = true,rewardtype = 5.0,rewardnum = 34.0,iconRes = "",},
	[1001] = {itemId = 1001.0,itemName = "玩家升到2级",tasktype = 1.0,count = 2.0,isEmail = true,rewardtype = 5.0,rewardnum = 10.0,iconRes = "",},
	[1002] = {itemId = 1002.0,itemName = "玩家升到5级",tasktype = 1.0,count = 5.0,isEmail = true,rewardtype = 5.0,rewardnum = 11.0,iconRes = "",},
	[1003] = {itemId = 1003.0,itemName = "玩家升到10级",tasktype = 1.0,count = 10.0,isEmail = true,rewardtype = 5.0,rewardnum = 12.0,iconRes = "",},
	[1004] = {itemId = 1004.0,itemName = "玩家升到15级",tasktype = 1.0,count = 15.0,isEmail = true,rewardtype = 5.0,rewardnum = 13.0,iconRes = "",},
	[1005] = {itemId = 1005.0,itemName = "玩家升到20级",tasktype = 1.0,count = 20.0,isEmail = true,rewardtype = 5.0,rewardnum = 14.0,iconRes = "",},
	[1006] = {itemId = 1006.0,itemName = "玩家升到25级",tasktype = 1.0,count = 25.0,isEmail = true,rewardtype = 5.0,rewardnum = 15.0,iconRes = "",},
	[1007] = {itemId = 1007.0,itemName = "玩家升到30级",tasktype = 1.0,count = 30.0,isEmail = true,rewardtype = 5.0,rewardnum = 16.0,iconRes = "",},
	[1008] = {itemId = 1008.0,itemName = "玩家升到40级",tasktype = 1.0,count = 40.0,isEmail = true,rewardtype = 5.0,rewardnum = 17.0,iconRes = "",},
	[1009] = {itemId = 1009.0,itemName = "玩家升到50级",tasktype = 1.0,count = 50.0,isEmail = true,rewardtype = 5.0,rewardnum = 18.0,iconRes = "",},
	[1010] = {itemId = 1010.0,itemName = "收集金币1000个",tasktype = 2.0,count = 1000.0,isEmail = true,rewardtype = 5.0,rewardnum = 19.0,iconRes = "",},
	[1011] = {itemId = 1011.0,itemName = "收集金币2000个",tasktype = 2.0,count = 2000.0,isEmail = true,rewardtype = 5.0,rewardnum = 20.0,iconRes = "",},
	[1012] = {itemId = 1012.0,itemName = "收集金币3000个",tasktype = 2.0,count = 3000.0,isEmail = true,rewardtype = 5.0,rewardnum = 21.0,iconRes = "",},
	[1013] = {itemId = 1013.0,itemName = "收集金币4000个",tasktype = 2.0,count = 4000.0,isEmail = true,rewardtype = 5.0,rewardnum = 22.0,iconRes = "",},
	[1014] = {itemId = 1014.0,itemName = "收集金币5000个",tasktype = 2.0,count = 5000.0,isEmail = true,rewardtype = 5.0,rewardnum = 23.0,iconRes = "",},
	[1015] = {itemId = 1015.0,itemName = "通关第一章",tasktype = 3.0,count = 1.0,isEmail = true,rewardtype = 5.0,rewardnum = 24.0,iconRes = "",},
	[1016] = {itemId = 1016.0,itemName = "通关第二章",tasktype = 3.0,count = 2.0,isEmail = true,rewardtype = 5.0,rewardnum = 25.0,iconRes = "",},
	[1017] = {itemId = 1017.0,itemName = "通关第三章",tasktype = 3.0,count = 3.0,isEmail = true,rewardtype = 5.0,rewardnum = 26.0,iconRes = "",},
	[1018] = {itemId = 1018.0,itemName = "通关第四章",tasktype = 3.0,count = 4.0,isEmail = true,rewardtype = 5.0,rewardnum = 27.0,iconRes = "",},
	[1019] = {itemId = 1019.0,itemName = "通关第五章",tasktype = 3.0,count = 5.0,isEmail = true,rewardtype = 5.0,rewardnum = 28.0,iconRes = "",},
	[1020] = {itemId = 1020.0,itemName = "通关第六章",tasktype = 3.0,count = 6.0,isEmail = true,rewardtype = 5.0,rewardnum = 29.0,iconRes = "",},
	[1021] = {itemId = 1021.0,itemName = "总共杀死10000个敌人",tasktype = 4.0,count = 10000.0,isEmail = true,rewardtype = 5.0,rewardnum = 30.0,iconRes = "",},
	[1022] = {itemId = 1022.0,itemName = "总共杀死20000个敌人",tasktype = 4.0,count = 20000.0,isEmail = true,rewardtype = 5.0,rewardnum = 31.0,iconRes = "",},
	[1023] = {itemId = 1023.0,itemName = "总共杀死30000个敌人",tasktype = 4.0,count = 30000.0,isEmail = true,rewardtype = 5.0,rewardnum = 32.0,iconRes = "",},
}
return AchieveConfig