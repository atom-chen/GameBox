--[[
	id:[number] 怪物ID
	name:[string] 怪物名称
	state:[string] 怪物介绍
	type:[number] 怪物类型
	skillId:[string] 技能
	damage:[number] 攻击力
	defence:[number] 防御力
	HP:[number] 生命力
	speed:[float] 移动速度
	soundRes:[string] 音效资源
]]
local config = {
	[10001] = {id = 10001,name = "生化魔人",state = "这是第1章boss:生化魔人",type = 3,skillId = "2001|2002",damage = 100,defence = 80,HP = 1000,speed = 1.0,soundRes = "",},
	[10002] = {id = 10002,name = "远古巨兽",state = "这是第2章boss:远古巨兽",type = 3,skillId = "2003|2004",damage = 100,defence = 80,HP = 1000,speed = 0.8,soundRes = "",},
	[10003] = {id = 10003,name = "蜘蛛女皇",state = "这是第3章boss:蜘蛛女皇",type = 3,skillId = "2005|2006",damage = 100,defence = 80,HP = 1000,speed = 0.0,soundRes = "",},
	[10004] = {id = 10004,name = "机械公敌",state = "这是第4章boss:机械公敌",type = 3,skillId = "2007|2008",damage = 100,defence = 80,HP = 1000,speed = 1.0,soundRes = "",},
	[10005] = {id = 10005,name = "恐怖鬼面",state = "这是第5章boss:恐怖鬼面",type = 3,skillId = "2009|2010",damage = 100,defence = 80,HP = 1000,speed = 0.9,soundRes = "",},
	[10006] = {id = 10006,name = "恶魔之王",state = "这是第6章boss:恶魔之王",type = 3,skillId = "2011|2012",damage = 100,defence = 80,HP = 1000,speed = 10.0,soundRes = "",},
}
return MonsterConfig