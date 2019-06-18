#### 简介
Visual Studio 2013 通过C++调用Python脚本的Demo

使用python环境为2.7

#### 配置方式：
1. 新创建空的win32项目
2. 在vs配置环境中添加：C/C++ -> 常规(General) -> 附加包含目录(Additional Include Directories)，可输入：C:\Python27\include
3. 在vs配置环境中添加：Linker -> 常规(General) -> 附加目录项(Additional Library Directories)， 可输入：C:\Python27\libs
```
建议，将Python27目录下的include,libs目录放置对应的项目中,其中原因在于：在编译pyconfig.h文件中，第338行处，
Debug模式下加载的lib文件为python27_d.lib
release模式下加载的lib文件为python27.lib
```
4. 在代码编译成功后，将相关的py文件放置到对应的Debug目录中； 
5. 将C:\Windows\System32\python27.dll放置到与exe同级的目录中