#### GameBox
版本： **cocos2d Lua 3.10**

语言： **c++, lua, java, ojbect-C**

编译环境： **visual Studio 2013, Visual Studio Code**

声明： **感谢Cocos引擎团队，此Demo仅用于学习成长，不做任何商业使用**

#### 目录结构
```
-- cocosLua代码项目
Project:
|- runtime 用于Win32，Mac开发存储的动态库文件 暂不赘述
|- frameworks cocos C/C++库文件相关 暂不赘述
|- src 脚本目录相关
|- tool 工具相关，详情可参考tool/README.md文件
|- res 资源相关
|- document 文档相关
|- - excel 僵尸射击游戏的配置表
|- - sdk 接入SDK的文件及流程文档
|- .settings/config.json/.cocos-project.json/.project 项目配置相关，不要删除，否则cocos打包会报错
|- LuaProject.config/luaproj visual Studio BadeLua相关配置文件

-- cocosStudio资源项目
ProjectStudio
|- cocosStudio 资源文件，csd文件相关目录
|- sound 声音资源资源
|- ProjectStudio.css/cfg/udf 项目目录配置文件相关

-- C++调用Python的示例项目，详情参考目录内的README.md文件
TestProject
```

#### Windows Android环境配置相关
配置JDK
```
新建环境变量： JAVA_HOME
变量值：C:\Program Files\Java\jdk1.8.0_131(所在目录)
添加变量名：classpath
变量值： .; %JAVA_HOME%\lib; %JAVA_HOME%\lib\tools.jar (记住前面有”.”，不能掉)
在Path变量名添加变量值 %JAVA_HOME%\bin;%JAVA_HOME%\jre\bin
cmd测试：java -version
```

配置SDK
```
新建环境变量：ANDROID_SDK_ROOT
变量值： E:\Cocos\tools\sdk\windows_sdk(所在目录)
在path中添加两个变量值：
%ANDROID_SDK_ROOT%\platform-tools;%ANDROID_SDK_ROOT%\sdk\tools
cmd测试：adb
```

配置NDK
```
新建环境变量：  NDK_ROOT
变量值：E:\Cocos\tools\android-ndk-r10e(所在目录)
在path中添加变量值： %NDK_ROOT%
cmd测试：ndk-build
```

配置ANT
```
新建环境变量： ANT_ROOT
变量值：E:\Cocos\tools\ant\bin(所在目录)
在path中添加变量值： %ANT_ROOT%
cmd测试： ant -version

注意：
如果在输入 ant -version 的时候，出现类似提示：
Unable to locate tools.jar. Expected find it in  C:\Program Files\Java\jre6\lib

解决方式：把Java\jdk6目录下的tools.jar 复制到 Java\jre6\lib目录下即可
在cmd中，输入ant，如果提示：
Buildfile: build.xml does not exist!
Build failed
说明安装正确，为保证稳定，可使用ant -version 再尝试下
```

如上配置成功后，可进入cocos2d 引擎工程目录下，比如cocos2d-x-3.10，在cmd中输入命令：
```
setup.py 
```
可以验证下相关的环境是否配置正确.

#### 命令相关
Cocos 新建工程命令
```
-- cocos new 项目名 -l 开发语言(lua,C++,javaScript)等 -d 项目存在路径，更多命令参考：cocos new
cocos new Project -l lua -d 指定的路径
```
Cocos Android打包
```
cocos compile -p android
```