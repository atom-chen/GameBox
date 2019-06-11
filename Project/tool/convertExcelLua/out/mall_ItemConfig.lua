--[[
	itemId:[number] 商品ID
	itemName:[string] 商品名称
	count:[number] 道具数量
	price:[number] 商品价格
	cursale:[number] 商品当前库存
	totalsale:[number] 总库存
	isEmail:[bool] 有否邮箱发送
	updateTime:[date] 开始刷新时间
]]
local mall_ItemConfig = {
	[1024] = {itemId = 1024.0,itemName = "家用绞肉机",count = 1.0,price = 15000.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1025] = {itemId = 1025.0,itemName = "扫地机器人",count = 1.0,price = 4688.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1026] = {itemId = 1026.0,itemName = "迷你加湿器",count = 1.0,price = 4788.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1027] = {itemId = 1027.0,itemName = "蓝牙迷你音箱",count = 1.0,price = 3200.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1028] = {itemId = 1028.0,itemName = "喷雾补水仪",count = 1.0,price = 2888.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1029] = {itemId = 1029.0,itemName = "富晒不粘锅",count = 1.0,price = 1268.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1030] = {itemId = 1030.0,itemName = "手绘大花碗",count = 1.0,price = 1588.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1031] = {itemId = 1031.0,itemName = "离子导入仪",count = 1.0,price = 1200.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1032] = {itemId = 1032.0,itemName = "蘑菇杯",count = 1.0,price = 388.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1033] = {itemId = 1033.0,itemName = "小鸭三门冰箱",count = 1.0,price = 48800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1034] = {itemId = 1034.0,itemName = "TCL洗衣机",count = 1.0,price = 25800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1035] = {itemId = 1035.0,itemName = "无线路由器",count = 1.0,price = 11500.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1036] = {itemId = 1036.0,itemName = "美的微波炉",count = 1.0,price = 32900.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1037] = {itemId = 1037.0,itemName = "茶具套装",count = 1.0,price = 22800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1038] = {itemId = 1038.0,itemName = "家用料理机",count = 1.0,price = 11900.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1007] = {itemId = 1007.0,itemName = "食用油1升",count = 1.0,price = 5000.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1008] = {itemId = 1008.0,itemName = "烧烤架",count = 1.0,price = 7000.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1009] = {itemId = 1009.0,itemName = "煮蛋器",count = 1.0,price = 5000.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1010] = {itemId = 1010.0,itemName = "护眼小台灯",count = 1.0,price = 5000.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1011] = {itemId = 1011.0,itemName = "50元充值卡",count = 1.0,price = 5000.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1012] = {itemId = 1012.0,itemName = "100元充值卡",count = 1.0,price = 10000.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1013] = {itemId = 1013.0,itemName = "蓝牙音箱",count = 1.0,price = 18000.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1014] = {itemId = 1014.0,itemName = "坚果礼包",count = 1.0,price = 9800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1015] = {itemId = 1015.0,itemName = "吹风机",count = 1.0,price = 6800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1016] = {itemId = 1016.0,itemName = "车载冰箱",count = 1.0,price = 22800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1017] = {itemId = 1017.0,itemName = "43寸高清电视",count = 1.0,price = 138800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1018] = {itemId = 1018.0,itemName = "台式电脑",count = 1.0,price = 142000.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1019] = {itemId = 1019.0,itemName = "新飞冰箱",count = 1.0,price = 72800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1020] = {itemId = 1020.0,itemName = "手机投影仪",count = 1.0,price = 48800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1021] = {itemId = 1021.0,itemName = "家用饮水机",count = 1.0,price = 50000.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1022] = {itemId = 1022.0,itemName = "航拍飞行器",count = 1.0,price = 36800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
	[1023] = {itemId = 1023.0,itemName = "智能手环",count = 1.0,price = 10800.0,cursale = 10.0,totalsale = 1000.0,isEmail = true,updateTime = 2018-11-09 00:00:00,},
}
return mall_ItemConfig