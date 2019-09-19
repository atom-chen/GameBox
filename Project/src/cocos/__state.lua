--[[
Cocos2d目录下的文件：
	Cocos2d.lua: 常用结构体的操作接口
	functions.lua: 常用方法,以及对lua标准库的扩展等
	json.lua: JSON编码和解码接口
	luaj.lua: lua调用Java的接口
	luaoc.lua: lua调用Object-c的接口
	Opengl.lua: lua操作OpenGL的接口
	bitExtend.lua: lua二进制接口

framework目录下的文件：
	components/event.lua: 类似于EventDispatcher的消息机制
	extends目录： 对cocos2d-x节点的扩展
	audio.lua: 简单封装了cocos2d-x的声音库
	device.lua: 定义了一些与设备有关的变量和方法，如语言，平台等
	display.lua: 定义了一些与显示相关的常用变量和方法，如屏幕尺寸，分辨率，常用颜色值等
]]