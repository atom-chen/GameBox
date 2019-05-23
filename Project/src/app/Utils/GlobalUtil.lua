local winSize = cc.Director:getInstance():getWinSize()

-- @func:创建触摸屏蔽层
-- @param: _size 大小
-- @param: _opacity 层级
cc.exports.newLayerColor = function(_size,_opacity)
	local width = _size.width or winSize.width
	local height = _size.height or winSize.height
	local opactiy = _opacity or 255

	local layer = cc.LayerColor:create(cc.c4b(0,0,0,opactiy),width,height)

	local function onTouchBegan(touch, event)
		return true
	end
	local function onTouchEnded(touch, event)
		--
	end 
	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	-- 设置触摸吞噬
	listener:setSwallowTouches(true)

	local eventDispatcher = layer:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

	return layer
end

-- @func:按钮注册事件
-- @param: node 注册节点
-- @param: callback 回调接口
-- @param: eventType 事件类型
-- @param: scale 缩放
cc.exports.ButtonTouchListener = function(node,callback,eventType,scale)
	if tolua.isnull(node) then 
		print("buttonTouchListener failed, the cboj is nill")
		return 
	end 

	-- 设置点击音效
	local soundRes = ""
	if soundRes ~= nil and string.len(soundRes) > 0 then 
		-- do something 
	end 

	-- 设置按钮缩放
	if scale then
		node:setPressedActionEnabled(true)
		node:setZoomScale(scale)
	end

	-- 设置回调
	eventType = eventType or ccui.TouchEventType.ended
	local touchEvent = function(sender, event)
		if event == eventType then 
			callback(sender)
		end 
	end 
	node:addTouchEventListener(touchEvent)
end