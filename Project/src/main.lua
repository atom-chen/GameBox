-- 设置加载图像失败时是否弹出消息框
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

local function main()
    require("app.MyApp"):create():run()
end


-- 断点不能使用
-- 参考：https://github.com/k0204/LuaIde/wiki
local breakInfoFun,xpcallFun = require("LuaDebug")("localhost", 7003)
-- 1.断点定时器添加
cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakInfoFun, 0.3, false)
-- 2.程序异常监听
__G__TRACKBACK__ = function(errorMessage)
    xpcallFun()
    print("----------------------------------------")
    local msg = debug.traceback(errorMessage, 3)
    print(msg)
    print("----------------------------------------")
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end

