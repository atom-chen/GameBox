-- 
local UIChapterEach = class("UIChapterEach") 

function UIChapterEach:ctor(parent)
    self:_initData(parent)
    self:_initUI()
end 

function UIChapterEach:_initData(parent)
    self._parentNode = parent 
end 

function UIChapterEach:_initUI()
    --
end 

return UIChapterEach 
