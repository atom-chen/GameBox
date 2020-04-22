--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2020-04-02 17:27:19
]]

local super = require("app.BaseTest.UIBase")
local UILayer = class("UILayer",super)

--[[
function UILayer:ctor()
    print("UILayer:ctor...")
    self:init()
end 

function UILayer:init()
    print("UILayer:init...")
end 
]]

function UILayer:setName()
    self.super.setName(self)
    print("UILayer:setName...")
end


return UILayer