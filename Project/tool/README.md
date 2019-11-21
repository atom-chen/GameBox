#### 说明
**PlistSplit: 将texturePacker图集文件拆分成散图文件**
```
环境： python 3
插件安装： pip3 install Pillow
命令参考：python tool.py pd_sprites 
网址参考：https://blog.csdn.net/sm9sun/article/details/77703551 
注意：问题较多
```

**ExcelToLua: 将excel表转换为lua配置文件**
```
目录结构：
|- out 输出的lua文件
|- src 存放的excel文件
|- excellua.py 执行文件

环境： python 2
命令： python excellua.py
插件安装: pip install xlrd

注意：
1. 不可在打开excel文件的情况运行脚本文件，否则会报错
2. 针对于excel命名建议为英文
3. 如果excel表有多个sheet表，命名方式格式： excel名 + sheet名 + Config.lua 
```
**QrCode 将内容或者url转换为二维码图片**
```
环境: python 2
命令： python start.py 或者直接点击start.py文件 使用
插件安装: 
    pip install qrcode
    pip install Image

注意： 
1. 若未要求输入指定内容，程序会退出
3. 保存图片，默认命名为qrcode.png, 若未保存，会直接显示
```
**CsdLua: 将csd文件转换为Lua配置文件**
```
环境： python 2,3
命令：python start.py 或者直接点击start.py文件 使用
目录结构：
|- FrameMgr.py 工具模块，将csd转换为Lua，以后拓展会添加JavaScript, C++模块等
|- ToolMgr.py UI模块
|- start.py 启动程序
|- csdFile 存放csd文件目录
|- outFile 输出lua文件目录

问题：
1. 针对于Mac，需要手动指定目录相关
2. 对于csd目录处理，暂不支持多个文件夹层级嵌套，故此设定了csdFile文件目录
```
**FileCode: 获取文件编码格式**
```
环境： python 2.6 2.7 or 3.3+
官网： https://pypi.org/project/chardet/
插件安装： pip/pip3 install chardet
命令： python start.py 
注意：
1. 注意添加目录，格式默认utf-8即可
2. 输入日志中confidence表示精确率， encoding表示编码格式
```
**Translate: 有道中英翻译**
```
环境: python 2.x 3.x
命令： python start.py 路径 (比如 python start.py C:\Project\Demo)
会将翻译的文件放置到out目录下
```
**FindSameFile: 查找同名文件**
```
环境： python 2.x
命令： python start.py 路径目录  (注意：路径目录可为空，为空时会默认搜索Project\res目录)
原理： 将搜索的文件通过setdefault放置到map中，然后通过两次循环比较map即可
```

**HZK16: 字库生成指定的中文拼图**
```
环境: python 2.x
原理: 按照汉字的点阵信息拼接，生成完整的单子图片

其它:
1. HZK16: 符合GB2312标准的16*16的点阵字库，支持汉字6763个，符号682个
```