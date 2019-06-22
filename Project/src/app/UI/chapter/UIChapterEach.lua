-- 
local ChapterService = require("app.Service.ChapterService")
local UIChapterEach = class("UIChapterEach") 

---
local eachItem = class("eachItem")
function eachItem:ctor(root)
    self._eachroot = nil 
    self._iconhead = nil        -- 头像
    self._eachname = nil        -- 关卡名

    self:_init()
end 

function eachItem:_init()
    self._eachroot = nil 
end 

function eachItem:setData()
    --
end 

function eachItem:_clickEachEvent(sender)
    --
end 


--- 
function UIChapterEach:ctor(parent)
    self:_initData(parent)
    self:_initUI()
end 

function UIChapterEach:_initData(parent)
    self._parentNode = parent 
    self._root = nil 
end 

function UIChapterEach:_initUI()
    self._root = ccui.Helper:seekNodeByName(self._parentNode, "Node_Each")

    local eachNum = 6
    for i = 1, eachNum do 
        --
    end 
end 

return UIChapterEach 
