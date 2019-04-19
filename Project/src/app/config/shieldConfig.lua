-- 非法字符屏蔽表
local shileConfig = {
	"王八蛋","草","操","干","gan","滚",
}

cc.exports.CheckShield = function(strName)
	local count = table.getn(shileConfig)
	if count <= 0 then 
		print("非法字符表存在问题")
		return 
	end 

	for i = 1, count do
		if string.find(strName, shileConfig[i]) ~= nil then
			local str = string.gsub(strName, shileConfig[i], "***")
			return true,str
		end
	end
	return false, ""
end