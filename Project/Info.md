## 项目目录简介
声明： 所使用的资源均用于学习，不做任何商业用途使用.

### runtime
存储了win32下相关的cocos库文件

### tool
主要使用python编写的一些工具：
```
convertExcalLua: 用于实现将excel数据表转换为 .lua 配置文件的工具，其详细说明可参考文件夹下的state.txt
```

### frameworks 
cocos 自带的文件相关

### doc
编写的末日射击的一些excel数据表，以及将来会存储一些技术文档相关

### src
功能实现的lua逻辑文件
#### Utils: 全局方法及常用的变量声明，资源文件名等申明
#### personTest: 个人根据cocos编写的一些示例代码相关，比如：
```
ClipTest: 图片剪切，显示多边形战力信息
DrawLineTest: cocos自带的绘制图形相关
KeyboardTest: cocos键盘事件相关
ProcessorTest: cocos进度条动画相关
SpineText: cocos骨骼动画相关
```
#### Demo_ZombieShoot: 末日射击动作Demo
#### Demo_Tetris: 俄罗斯方块Demo
#### Demo_lolitaParkOur: 萝莉2D跑酷，主要用于学习Tiled Map的使用相关
#### Demo_FistFight: 一款横版动作格斗Demo,学习网址来源于：https://blog.csdn.net/peter_teng/article/details/40738651

### res
功能实现的资源文件
```
art | csd : 主要用于存储cocosstudio 生成的csb文件及资源， 在以后项目拓展的基础上会创建新的cocosstudio工程，避免混淆
Default: cocosstudio 自带的默认UI资源文件
effect: 主要用于粒子特效，动作等资源文件，以后会合并到特定的资源Demo目录下
lolitaParkour: Demo_lolitaParkOur资源文件
tetris: Demo_Tetris的资源文件
Tile: Demo_ZombieShoot的资源文件，会更名
fistfight: Demo_FistFight的资源文件
```





