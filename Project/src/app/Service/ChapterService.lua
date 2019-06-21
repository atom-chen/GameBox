--
local ChapterConfig = require("app.config.ChapterConfig")
local ChapterService = class("ChapterService")

local _instance = nil 
function ChapterService:getInstance()
    if _instance == nil then 
        _instance = ChapterService.new()
    end 
    return _instance
end 

function ChapterService:destroy()
    _instance = nil 
end 

function ChapterService:ctor()
    self._curChapterId = nil                                    -- 进行到第几章
    self._curEach = nil                                         -- 进行到第几节
    self._medalNun = nil                                        -- 勋章总数目
    self._chapterIdTab = {}                                     -- 章ID列表
    self._chapterNum = nil                                      -- 总章数目
end 

function ChapterService:_initService()
    self._chapterIdTab = ChapterConfig.getChapterIdList()
    self._chapterNum = #_chapterIdTab
    self._curChapterId = 101            -- 应从server获取，先使用测试数据
    self._curEach = 1                   -- 应从server获取，先使用测试数据
    self._medalNun = 30                 -- 应从server获取，先使用测试数据
end 

-- 获取章数目
function ChapterService:getChapterNum()
    return self._chapterNum
end 

-- 获取当前为第几章
function ChapterService:getCurChapterId()
    return self._curChapterId
end 

-- 根据章ID获取节数目
function ChapterService:getEachNumByChapterId(chapterId)
    local num = ChapterConfig.getChapterEachNum(chapterId)
    return num 
end 

-- 判定该章节是否开启
function ChapterService:checkChapterIsOpen(chapterId)
    -- 应该从server中获取，暂且使用测试数据吧
    local isTabs = {
        [101] = true,
        [102] = true,
        [103] = true,
        [104] = false,
        [105] = false,
        [106] = false,
    }
    return isTab[chapterId]
end 

-- 获取指定章数据
function ChapterService:getChapterData(chapterId)
    chapterId = tonumber(chapterId)
    if not chapterId then 
        print("参数错误")
        return 
    end 

    if not self:checkChapterIsOpen(chapterId) then 
        print("该章未开启")
        return 
    end 

    local chapterData = ChapterConfig.getEachChapterData(chapterId)
    if not chapterData then 
        return 
    end 

    local data = chapterData
    data.titleRes, data.bgRes = ChapterConfig.getChapterTitleRes(chapterId)

    return data 
end 




