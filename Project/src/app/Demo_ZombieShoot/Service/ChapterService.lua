--
local ChapterConfig = require("app.Demo_ZombieShoot.config.ChapterConfig")
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

    self:_initService()
end 

function ChapterService:_initService()
    self._chapterIdTab = ChapterConfig.getChapterIdList()
    self._chapterNum = #self._chapterIdTab 
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
    return isTabs[chapterId]
end 

-- 根据选择索引获取指定章ID
function ChapterService:getChapterIdByIndex(index)
    return index + 100
end 

-- 获取指定章数据
function ChapterService:getChapterData(chapterId)
    chapterId = tonumber(chapterId)
    if not chapterId then 
        print("参数错误")
        return 
    end 

    local data = {}
    data.chapterId = chapterId
    data.isopen = self:checkChapterIsOpen(chapterId)
    data.chaptercurMedal = 0
    data.chaptertotalMedal = chapterId  

    return data
end 

-- 获取章节数据
function ChapterService:getChapterEachDatas(chapterId)
    local tabs = ChapterConfig.getEachChapterData(chapterId) 

    local eachTabs = {}
    for i , data in ipairs(tabs) do 
        local newdata = {}
        local newIndex = 1
        if data.index%6 ~= 0 then 
            newIndex = data.index%6
        else 
            newIndex = 6
        end 
        newdata.index = data.index                                          -- 索引
        newdata.eachId = data.eachId                                        -- 节ID
        newdata.eachOpen = true                                             -- 是否开启该节，从server获取
        newdata.eachmode = data.eachmode                                    -- 模式
        newdata.starnum = 0                                                 -- 当前星星，从server获取
        newdata.totalstar = 3                                               -- 总星星
        newdata.titleRes = ChapterConfig.getEachTitleRes(newIndex)          -- 标题资源
        if newIndex == 6 then 
            newdata.headRes = ChapterConfig.getEachBossRes(chapterId)       -- 头像资源
            newdata.bossId = data.bossId or -1                              -- bossId
        end 
        table.insert(eachTabs, newdata)
    end 

    return eachTabs
end 

-- 获取指定章资源
function ChapterService:getChapterRes(chapterId)
    local titleRes, bgRes, chapterRes, closeRes = ChapterConfig.getChapterRes(chapterId)

    return titleRes, bgRes, chapterRes, closeRes
end 

return ChapterService




