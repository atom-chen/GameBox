#### 说明
**atlasSplit:**
```
说明： 将texturePacker图集文件拆分成散图文件
环境： python 3
插件安装： pip3 install Pillow
命令参考：python tool.py pd_sprites 
网址参考：https://blog.csdn.net/sm9sun/article/details/77703551 

问题较多，学习使用吧
```

**convertExcelLua**
```
目录结构：
|- out 输出的lua文件
|- src 存放的excel文件
|- excellua.py 执行文件

说明： 将excel表转换为lua配置文件
环境： python 2
命令： python excellua.py

注意：
1. 不可在打开excel文件的情况运行脚本文件，否则会报错
2. 针对于excel命名建议为英文
3. 如果excel表有多个sheet表，命名方式格式： excel名 + sheet名 + Config.lua 
```