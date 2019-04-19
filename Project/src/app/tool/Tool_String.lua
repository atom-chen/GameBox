-- 字符串相关处理
cc.exports.Tool = {}

-- 获取指定字符串字符产股
Tool.getUTFLen = function(str)
	--
end 

-- 验证手机号码是否合法



-- 关于对cocosstudio 加载.csb文件进行优化，避免重复设定位置什么的, 以及加载失败
--[[
原： cc.CSLoader:createNode("res/csd/UILogin.csb")
修改为
cc.exports.CreateCsbNode = function(csbName)
	if not csbName or string.len(csbName) then 
		print("CreateCsbNode param is nil")
		return 
	end 

	local node = cc.CSLoader:createNode(csbName)
	if node == nil then 
		local fullpath = cc.FileUtils:getInstance():fullPathForFilename(csbName)
		print("CreateCsbNode fullpath = ", fullpath)
		if string.len(fullpath) then 
			-- 判定文件是否存在
			local isExsit = cc.FileUtils:getInstance():isFileExist(csbName) 
			if not isExsit then 
				print("文件不存在")
			end 
		end 
	node:setPosition(cc.p(display.cx, display.cy))

	-- 设定屏幕适配相关
	-- do something 

	return node
end 
]]