/****************************************************************************
 Copyright (c) 2011-2012 cocos2d-x.org
 Copyright (c) 2013-2016 Chukong Technologies Inc.

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/
#include "scripting/lua-bindings/manual/Cocos2dxLuaLoader.h"
#include <string>
#include <algorithm>

#include "scripting/lua-bindings/manual/CCLuaStack.h"
#include "scripting/lua-bindings/manual/CCLuaEngine.h"
#include "platform/CCFileUtils.h"

using namespace cocos2d;

extern "C"
{
    int cocos2dx_lua_loader(lua_State *L)
    {
		// 后缀为luac和lua
        static const std::string BYTECODE_FILE_EXT    = ".luac";
        static const std::string NOT_BYTECODE_FILE_EXT = ".lua";
		// require传入的要加载的文件名，比如：require "cocos.init" 中的"cocos.init"
        std::string filename(luaL_checkstring(L, 1));
		// 去掉后缀名luac或lua
        size_t pos = filename.rfind(BYTECODE_FILE_EXT);
        if (pos != std::string::npos)
        {
            filename = filename.substr(0, pos);
        }
        else
        {
            pos = filename.rfind(NOT_BYTECODE_FILE_EXT);
            if (pos == filename.length() - NOT_BYTECODE_FILE_EXT.length())
            {
                filename = filename.substr(0, pos);
            }
        }
		// 将"."替换为"/"，注意不包含文件名的后缀
        pos = filename.find_first_of(".");
        while (pos != std::string::npos)
        {
            filename.replace(pos, 1, "/");
            pos = filename.find_first_of(".");
        }

        // 在package.path中搜索脚本文件
        Data chunk;
        std::string chunkName;
        FileUtils* utils = FileUtils::getInstance();
		// 获取package.path的变量
        lua_getglobal(L, "package");
        lua_getfield(L, -1, "path");
        std::string searchpath(lua_tostring(L, -1));
        lua_pop(L, 1);
        size_t begin = 0;
        size_t next = searchpath.find_first_of(";", 0);
		/*
		遍历package.path中的所有路径，获取到文件后
		通过getDataFromFile方法根据搜索到路径进行读取文件，只要读取到文件就退出循环
		*/
        do
        {
            if (next == std::string::npos)
                next = searchpath.length();
            std::string prefix = searchpath.substr(begin, next);
            if (prefix[0] == '.' && prefix[1] == '/')
            {
                prefix = prefix.substr(2);
            }

            pos = prefix.find("?.lua");
            chunkName = prefix.substr(0, pos) + filename + BYTECODE_FILE_EXT;
            if (utils->isFileExist(chunkName))
            {
                chunk = utils->getDataFromFile(chunkName);
                break;
            }
            else
            {
                chunkName = prefix.substr(0, pos) + filename + NOT_BYTECODE_FILE_EXT;
                if (utils->isFileExist(chunkName))
                {
                    chunk = utils->getDataFromFile(chunkName);
                    break;
                }
            }

            begin = next + 1;
            next = searchpath.find_first_of(";", begin);
        } while (begin < (int)searchpath.length());

		// 如果获取数据成功，就会调用luaLoadBuffer()加载到Lua中
		// 倘若设置了加密，会在luaLoadBuffer()中进行解密，并调用luaL_loadBuffer()将代码编译后作为
		// 一个函数放入栈中返回
        if (chunk.getSize() > 0)
        {
            LuaStack* stack = LuaEngine::getInstance()->getLuaStack();
            stack->luaLoadBuffer(L, reinterpret_cast<const char*>(chunk.getBytes()),
                                 static_cast<int>(chunk.getSize()), chunkName.c_str());
        }
        else
        {
            CCLOG("can not get file data of %s", chunkName.c_str());
            return 0;
        }

        return 1;
    }
}
