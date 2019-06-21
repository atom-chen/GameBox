-- 
local UIChapter = class("UIChapter") 

function UIChapter:ctor(parent)
    self:_initData(parent)
    self:_initUI()
end 

function UIChapter:_initData(parent)
    self._parentNode = parent 
end 

function UIChapter:_initUI()
    --
end 

return UIChapter 
