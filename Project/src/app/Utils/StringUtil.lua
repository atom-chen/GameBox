local sensitiveConfig = require("app.config.SensitiveConfig")
local StringUtil = {}

---------------------- 字符串相关 ----------------------
-- 字符串保存到table
StringUtil.stringToTable = function(s)
    local tb = {}

    --[[
    UTF8的编码规则：
    1. 字符的第一个字节范围： 0x00—0x7F(0-127),或者 0xC2—0xF4(194-244);
        UTF8 是兼容 ascii 的，所以 0~127 就和 ascii 完全一致
    2. 0xC0, 0xC1,0xF5—0xFF(192, 193 和 245-255)不会出现在UTF8编码中
    3. 0x80—0xBF(128-191)只会出现在第二个及随后的编码中(针对多字节编码，如汉字)
    ]]
    for utfChar in string.gmatch(s, "[%z\1-\127\194-\244][\128-\191]*") do
        table.insert(tb, utfChar)
    end

    return tb
end

-- 获取字符串长度,英文字符为一个单位长, 中文字符为2个单位长
StringUtil.getUTFLen = function(s)
    local sTable = StringUtil.stringToTable(s)
    local len = 0
    local charLen = 0

    for i=1,#sTable do
        local utfCharLen = string.len(sTable[i])
        -- 长度大于1可认为为中文
        if utfCharLen > 1 then
            charLen = 2 
        else
            charLen = 1
        end
        -- charLen = 1
        len = len + charLen
    end

    return len
end

-- 获取字符串长度,中文，英文均为一个字符为1单位长
StringUtil.getNewUTFLen = function(s)
    local sTable = StringUtil.stringToTable(s)
    local len = 0
    local charLen = 0

    for i = 1, #sTable do
        local utfCharLen = string.len(sTable[i])
        if utfCharLen > 1 then
            charLen = 1         -- 修改为1
        else
            charLen = 1
        end

        len = len + charLen
    end
    return len
end

-------------------- 非法字符检测相关 --------------------
-- 检测字符串是否合法, 合法返回true，否则返回false
StringUtil.CheckStrIsLegal = function(str)
    str = tostring(str)
    assert(str ~= nil, "[CheckStrIsLegal] str inValid")

    for i, v in pairs(sensitiveConfig) do 
        -- 查找是否存在匹配，若存在则返回具体位置，否则返回nil
        local startIndex, endIndex = string.find(str, v)
        if startIndex then 
            return false
        end 
    end 
    return true 
end 

--[[
local StringUtil = require("app.Utils.StringUtil")
print(StringUtil.CheckStrIsLegal("阿德撒发生"))
print(StringUtil.CheckStrIsLegal("JB"))
]]
return StringUtil