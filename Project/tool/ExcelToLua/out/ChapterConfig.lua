--[[
	index:[int] 索引
	chapterId:[number] 每章ID
	chaptertitle:[string] 章标题
	eachId:[number] 每节ID
	eachmode:[number] 每节模式
	titleRes:[string] 章标题res
	bossId:[number] BossId
	medalnum:[number] 勋章数目
]]
local config = {
	[1] = {index = 1,chapterId = 101,chaptertitle = "废弃都市",eachId = 1,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[2] = {index = 2,chapterId = 101,chaptertitle = "废弃都市",eachId = 2,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[3] = {index = 3,chapterId = 101,chaptertitle = "废弃都市",eachId = 3,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[4] = {index = 4,chapterId = 101,chaptertitle = "废弃都市",eachId = 4,eachmode = 3,titleRes = "0.0",bossId = nil,medalnum = 3,},
	[5] = {index = 5,chapterId = 101,chaptertitle = "废弃都市",eachId = 5,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[6] = {index = 6,chapterId = 101,chaptertitle = "废弃都市",eachId = 6,eachmode = 3,titleRes = "1.0",bossId = 10001,medalnum = 3,},
	[7] = {index = 7,chapterId = 102,chaptertitle = "幽暗森林",eachId = 1,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[8] = {index = 8,chapterId = 102,chaptertitle = "幽暗森林",eachId = 2,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[9] = {index = 9,chapterId = 102,chaptertitle = "幽暗森林",eachId = 3,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[10] = {index = 10,chapterId = 102,chaptertitle = "幽暗森林",eachId = 4,eachmode = 3,titleRes = "0.0",bossId = nil,medalnum = 3,},
	[11] = {index = 11,chapterId = 102,chaptertitle = "幽暗森林",eachId = 5,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[12] = {index = 12,chapterId = 102,chaptertitle = "幽暗森林",eachId = 6,eachmode = 3,titleRes = "1.0",bossId = 10002,medalnum = 3,},
	[13] = {index = 13,chapterId = 103,chaptertitle = "血色沼泽",eachId = 1,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[14] = {index = 14,chapterId = 103,chaptertitle = "血色沼泽",eachId = 2,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[15] = {index = 15,chapterId = 103,chaptertitle = "血色沼泽",eachId = 3,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[16] = {index = 16,chapterId = 103,chaptertitle = "血色沼泽",eachId = 4,eachmode = 3,titleRes = "0.0",bossId = nil,medalnum = 3,},
	[17] = {index = 17,chapterId = 103,chaptertitle = "血色沼泽",eachId = 5,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[18] = {index = 18,chapterId = 103,chaptertitle = "血色沼泽",eachId = 6,eachmode = 3,titleRes = "1.0",bossId = 10003,medalnum = 3,},
	[19] = {index = 19,chapterId = 104,chaptertitle = "死亡沙漠",eachId = 1,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[20] = {index = 20,chapterId = 104,chaptertitle = "死亡沙漠",eachId = 2,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[21] = {index = 21,chapterId = 104,chaptertitle = "死亡沙漠",eachId = 3,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[22] = {index = 22,chapterId = 104,chaptertitle = "死亡沙漠",eachId = 4,eachmode = 3,titleRes = "0.0",bossId = nil,medalnum = 3,},
	[23] = {index = 23,chapterId = 104,chaptertitle = "死亡沙漠",eachId = 5,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[24] = {index = 24,chapterId = 104,chaptertitle = "死亡沙漠",eachId = 6,eachmode = 3,titleRes = "1.0",bossId = 10004,medalnum = 3,},
	[25] = {index = 25,chapterId = 105,chaptertitle = "末日火山",eachId = 1,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[26] = {index = 26,chapterId = 105,chaptertitle = "末日火山",eachId = 2,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[27] = {index = 27,chapterId = 105,chaptertitle = "末日火山",eachId = 3,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[28] = {index = 28,chapterId = 105,chaptertitle = "末日火山",eachId = 4,eachmode = 3,titleRes = "0.0",bossId = nil,medalnum = 3,},
	[29] = {index = 29,chapterId = 105,chaptertitle = "末日火山",eachId = 5,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[30] = {index = 30,chapterId = 105,chaptertitle = "末日火山",eachId = 6,eachmode = 3,titleRes = "1.0",bossId = 10005,medalnum = 3,},
	[31] = {index = 31,chapterId = 106,chaptertitle = "恶魔之王",eachId = 1,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[32] = {index = 32,chapterId = 106,chaptertitle = "恶魔之王",eachId = 2,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[33] = {index = 33,chapterId = 106,chaptertitle = "恶魔之王",eachId = 3,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[34] = {index = 34,chapterId = 106,chaptertitle = "恶魔之王",eachId = 4,eachmode = 3,titleRes = "0.0",bossId = nil,medalnum = 3,},
	[35] = {index = 35,chapterId = 106,chaptertitle = "恶魔之王",eachId = 5,eachmode = 3,titleRes = "1.0",bossId = nil,medalnum = 3,},
	[36] = {index = 36,chapterId = 106,chaptertitle = "恶魔之王",eachId = 6,eachmode = 3,titleRes = "1.0",bossId = 10006,medalnum = 3,},
}
return ChapterConfig