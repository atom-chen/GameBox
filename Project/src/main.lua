
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

--添加调试代码
local breakInfoFun,xpcallFun = require("LuaDebug")("localhost", 7003)
-- 添加断点定时器
cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakInfoFun, 0.5, false)

local function main()
    require("app.MyApp"):create():run()
end

--2.程序异常监听            
__G__TRACKBACK__ = function(msg)
    debugXpCall()
    local msg = debug.traceback(msg, 3)       
    print(msg)                     
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
