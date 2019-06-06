-- 登录页面

local UILoginScene = class("UILoginScene", function()
    return cc.Scene:create()
end) 

function UILoginScene:ctor()
    local function onNodeEvent(event)
        if event == "enter" then
            self:init()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function UILoginScene:init()
    self:_initData()
    self:_initUI() 
end 

function UILoginScene:_initData()
    self._root = nil            -- 根节点
    self._startBtn = nil        -- 开始按钮
end 

function UILoginScene:_initUI()    
    local tmxMap = cc.TMXTiledMap:create("Tile/0_1.tmx")
    tmxMap:setPosition(cc.p(0,0))
    self:addChild(tmxMap)
end 

function UILoginScene:_onClickStartEvent(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    
    local layer = require("app.views.login.UISelectRole"):create()
    if not layer then 
        print("Error: require UISelectRole Failed!!!")
        return 
    end 
    self:addChild(layer)
end 

return UILoginScene 
