-- UI 基类
local UIBase = class("UIBase")

-- 显示动画
local AniType = {
    SCALE = 1,       -- 缩放
    FADE_IN = 2,     -- 渐现
    
    -- 慢慢补充吧
}

function UIBase:ctor()
    self._uiName = nil 
end 

-- 初始化
function UIBase:init()
    --
end 

-- 播放csd自带的动画
function UIBase:playCsdAni(csdpath,isLoop)
    local action = cc.CSLoader:createTimeline(csdpath)
    if not action then 
        local errorMsg = string.format("UIBase:playCsdAni:%s invalid!!!", csdpath or "nil")
        printError(errorMsg)
        return 
    end 

    self:runAction(action)
    action:gotoFrameAndPlay(0, isLoop or false)
end 

-- 播放UI动画
function UIBase:playAniShow(rootname, playType)
    rootname = tostring(rootname)
    if not rootname then 
        return 
    end 

    local node = ccui.Helper:seekNodeByName(self, rootname)
    if not node then 
        local errorMsg = string.format("UIBase:playAniShow:%s invalid!!!", nodeName or "nil")
        printError(errorMsg)
        return 
    end 

    if playType == SMALL_TO_BIG then 
        -- 由小变大
        node:setScale(0.1)
        local action1 = cc.ScaleTo:create(0.06, 1.05)
        local action2 = cc.ScaleTo:create(0.08, 1)
        local action = cc.Sequence:create(action1, action2)
        node:runAction(action)
    elseif playType == FADE_IN then 
        -- 渐现
        node:SetOpacity(100)
        local action = cc.FadeIn:create(0.14)
        node:runAction(action)
    end 
end 

-- 是否显示黑色遮罩
function UIBase:isShowBlackMask()
    return false 
end 

-- 是否点击遮罩关闭窗口
function UIBase:iscloseClickMask()
    return false 
end 

-- 获取UI层级
function UIBase:getUIZOrder()
    return 10000
end 

-- 显示UI
function UIBase:onEnter()
    --
end 

-- 隐藏UI
function UIBase:onExit()
    --
end 

-- 销毁UI
function UIBase:onCleanup()
    --
end 

-- 
function UIBase:setUIName(name)
    self._uiName = name 
end 

function UIBase:getUIName()
    return self._uiName 
end 

return UIBase
