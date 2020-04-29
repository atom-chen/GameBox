-- 监听管理器
cc.exports.EventNoticeManager = class("EventNoticeManager")

local _instance = nil 
function EventNoticeManager:getInstance()
    if nil == _instance then 
        _instance = EventNoticeManager.new()
    end 
end 

function EventNoticeManager:ctor()
    --
end 

function EventNoticeManager:onDestroy()
    _instance = nil 
end 