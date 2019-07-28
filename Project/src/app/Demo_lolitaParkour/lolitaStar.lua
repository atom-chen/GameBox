-- 星星类
local lolitaStar = class("lolitaStar", function()
    return cc.Node:create()
end)

function lolitaStar:ctor() 
    self._star  = cc.Sprite:createWithSpriteFrameName("star.png")
    local size = self._star :getContentSize()
    self._star :setScale(0.5)
    self:setContentSize(cc.size(size.width * 0.5, size.height * 0.5))
    self:addChild(self._star , 1)
end 

-- 设置星星是否显示
function lolitaStar:setIsShow(isShow)
    self:setVisible(isShow or false)
end 

-- 获取星星是否显示
function lolitaStar:isShow()
    return self:isVisble()
end

return lolitaStar