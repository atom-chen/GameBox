-- 非法字符屏蔽表
local shileConfig = {}
local config = {
	"王八蛋","草","操","干","gan","滚",
}

shileConfig.CheckShield = function(strName)
	local count = table.getn(config)
	if count <= 0 then 
		print("非法字符表存在问题")
		return 
	end 

	for i = 1, count do
		if string.find(strName, config[i]) ~= nil then
			local str = string.gsub(strName, config[i], "***")
			return true,str
		end
	end
	return false, ""
end

return shileConfig