-- 选角色页面
local shileConfig = require("app.config.shieldConfig")

local UISelectRole = class("UISelectRole", function()
    return cc.CSLoader:createNode("res/csd/UISelectRole.csb")
end) 

function UISelectRole:ctor()
    local function onNodeEvent(event)
        if event == "enter" then
            self:init()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function UISelectRole:init()
    self:_initData()
    self:_initUI() 
end 

function UISelectRole:_initData()
    self._root = nil            -- 根节点
    self._rolePanels = {}       -- 角色相关
    self._inputNameField = nil  -- 输入昵称
    self._noticeText = nil      -- 警告文本
    self._sureBtn = nil         -- 确认按钮
    self._backBtn = nil         -- 返回按钮
end 

function UISelectRole:_initUI()
    for i = 1, 3 do 
        self._rolePanels[i] = ccui.Helper:seekNodeByName(self, "Panel_" .. i)
        self._rolePanels[i]:addTouchEventListener(handler(self, self._onSelectRoleEvt))
        self._rolePanels[i]:setTag(i)

        -- 
        local tagImg = self._rolePanels[i]:getChildByName("Image_select")
        local isShow = i == 1 and true or false 
        tagImg:setVisible(isShow)
    end 

    self._sureBtn = ccui.Helper:seekNodeByName(self, "Button_Sure")

    self._backBtn = ccui.Helper:seekNodeByName(self, "Button_Back")
    print(tolua.type(self._backBtn))
    
    self._noticeText = ccui.Helper:seekNodeByName(self, "Text_Notice")
    print(tolua.type(self._noticeText))
    self._inputNameField = ccui.Helper:seekNodeByName(self, "TextField_Name")
    print(tolua.type(self._inputNameField))
    

    self._inputNameField:addEventListener(handler(self, self._onTextFieldChanged))
    self._sureBtn:addTouchEventListener(handler(self, self._onSureEvt))
    self._backBtn:addTouchEventListener(handler(self, self._onBackEvt))
end 

function UISelectRole:_onSelectRoleEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 

    local tag = sender:getTag()
    print("你选择的角色为:", tag)
    for i = 1, 3 do 
        local tagImg = self._rolePanels[i]:getChildByName("Image_select")
        local isShow = i == tag and true or false 
        tagImg:setVisible(isShow)
    end 
end 

function UISelectRole:_onTextFieldChanged(sender, eventType)
    if eventType == ccui.TextFiledEventType.attach_with_ime then
		-- do something
	elseif eventType == ccui.TextFiledEventType.detach_with_ime then
		-- do something 
	end
end 

function UISelectRole:_onSureEvt(sender, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 

    local strName = string.trim(self._inputNameField:getString())
    if string.len(strName) <= 0 then 
        print("请输入昵称")
        return 
    elseif string.len(strName) > 10 then 
        print("您输入的昵称过长")
        return 
    elseif shileConfig.CheckShield(strName) then 
        print("您输入了非法字符，请重新输入")
        self._inputNameField:setString("")
        return 
    end 

    self:_destory()
    --
    local UIMainScene = require("app.views.main.UIMainScene"):create()
    if UIMainScene then 
        cc.Director:getInstance():replaceScene(UIMainScene)
    end 
end 

function UISelectRole:_onBackEvt(sernder, eventType)
    if eventType ~= ccui.TouchEventType.ended then 
        return 
    end 
    print("您点击了返回按钮")
    self:_destory()
end 

function UISelectRole:_destory()
    self:removeFromParent()
end 

return UISelectRole 
