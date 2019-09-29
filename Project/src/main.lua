-- 设置加载图像失败时是否弹出消息框
cc.FileUtils:getInstance():setPopupNotify(false)

-- 添加搜索路径，为了避免运行时获取不到目录文件，将其置顶
local writePath = cc.FileUtils:getInstance():getWritablePath()
local resSearchPaths = {
	writePath,
	writePath .. "lua_classes/",
	writePath .. "src/",
	writePath .. "res/",
	"lua_classes/",
	"src/",
    "res/",
}
cc.FileUtils:getInstance():setSearchPaths(resSearchPaths)

-- 添加ludIde调试代码,GitHub: https://github.com/k0204/LuaIde
-- 在cocos2.x中使用LuaDebug；在cocos3.x中使用LuaDebugjit
-- breakInfoFunc: 断点及时刷新函数，需要在定时器中调用，该函数用于确保断点能够及时的发送到lua client
-- xpcallFun: 程序异常监听函数,用于当程序出现异常时调试器定位错误代码
-- 7003在lauch.json中的port端口中配置，一致即可
local breakInfoFun,xpcallFun = require("debug.LuaDebugjit")("localhost", 7003)
cc.Director:getInstance():getScheduler():scheduleScriptFunc(breakInfoFun, 0.3, false)

__G__TRACKBACK__ = function(errorMessage)
    xpcallFun()
    print("----------------------------------------")
    local msg = debug.traceback(errorMessage, 3)
    print(msg)
    print("----------------------------------------")

    -- report lua exception
    buglyReportLuaException(tostring(errorMessage), debug.traceback())
    return msg 
end

require "config"
require "cocos.init"

local function main()
    if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true)
    end
	cc.Director:getInstance():setAnimationInterval(1/60)
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end



