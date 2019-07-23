-- 选角页面
local RoleScene = class("RoleScene", function()
    return newLayerColor(cc.size(display.width, display.height), 255)
end) 

function RoleScene:ctor()
    self:init()
    local function onNodeEvent(event)
        if event == "enter" then
            self:onEnter()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function RoleScene:init()
    self:_initData()
    self:_initUI() 
end 

function RoleScene:_initData()
    self._root = nil            -- 根节点
    self._panels = {}           -- 角色panel，依次为左，中，右
end 

function RoleScene:_initUI()
    self._root = cc.CSLoader:createNode("res/csd/RoleScene.csb")
    self:addChild(self._root)
    
    --     
    local namelist = {"Panel_left", "Panel_mid", "Panel_right"}
    for i = 1, 3 do 
        -- 角色panel用于查看人物信息
        self._panels[i] = ccui.Helper:seekNodeByName(self._root, namelist[i])
        self._panels[i]:addTouchEventListener(handler(self, self._onRoleMsgEvent))
        self._panels[i]:setTag(i)

        -- 选择按钮用于选择角色
        local selectBtn = self._panels[i]:getChildByName("Button_Select")
        BindTouchEvent(selectBtn, handler(self, self._onRoleSelectEvent))
        selectBtn:setTag(i)
    end 

    -- 返回按钮
    local backBtn = ccui.Helper:seekNodeByName(self._root, "Button_back")
    BindTouchEvent(backBtn, handler(self, self._onBackEvent))
end 

function RoleScene:onEnter()
    -- 同时播放左panel，从左到指定位置， 右panel从右到指定位置， 中间从左到指定位置的移动动画

    -- 动画播放完成后，才进行序列帧动画播放，循环
    local action = cc.CSLoader:createTimeline("res/csd/RoleScene.csb")
    self._root:runAction(action)
    action:gotoFrameAndPlay(0, true)
end 

-- 角色详情事件
function RoleScene:_onRoleMsgEvent(sender, event)
    if event ~= ccui.TouchEventType.ended then 
        return 
    end 

    local tag = sender:getTag()
    print("你选择的角色详情为:", tag)
end 

-- 角色选择事件
function RoleScene:_onRoleSelectEvent(sender)
    local tag = sender:getTag()
    
    local scene = require("app.Demo_ZombieShoot.UI.chapter.ChapterScene"):create()
    cc.Director:getInstance():replaceScene(scene)
end 

-- 返回主场景事件
function RoleScene:_onBackEvent(sender)
    local mainScene = require("app.Demo_ZombieShoot.UI.MainScene"):create()
    cc.Director:getInstance():replaceScene(mainScene)
end 

return RoleScene 
