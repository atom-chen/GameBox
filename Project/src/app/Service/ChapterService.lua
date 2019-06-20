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

function ChapterService:ctor()
    self._curChapter = nil                                      -- 进行到第几章
    self._curEach = nil                                         -- 进行到第几节
    self._medalNun = nil                                        -- 勋章总数目
    self._totalChapter = ChapterConfig.getChapterNum()          -- 总章节数目
end 

-- 请求章节数据
function ChapterService:requestChapterData()
    -- do something
end 

-- 回复章节数据
function ChapterService:responseChapterData(data)
    self._curChapter = 101
    self._curEach = 1
    self._medalNun = 30
end 

-- 获取指定章数据
function ChapterService:getChpaterData(chapterId)
    chapterId = tonumber(chapterId)
    if not chapterId then 
        print("参数错误")
        return 
    end 

    if chapterId < self._curChapter then 
        print("该章未开启")
        return 
    end 


    local chapterData = ChapterConfig.getEachChapterData(chapterId)
    if not chapterData then 
        return 
    end 

    local data = chapterData
    data.titleRes = ChapterConfig.getChapterTitleRes(chapterId)
end 

-- 获取指定章节数据
function ChapterService:getEachChapterData(chapterId)
    -- do something
end 





