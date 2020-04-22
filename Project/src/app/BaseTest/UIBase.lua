--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2020-04-02 17:27:10
]]

local UIBase = class("UIBase")

function UIBase:ctor()
    print("UIBase:ctor...")
    self:init()
end 

function UIBase:init()
    print("UIBase:init...")
end 

function UIBase:setName()
    print("UIBase:setName...")
end 

return UIBase

