/****************************************************************************
 Copyright (c) 2014 Chukong Technologies Inc.
 
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

#ifndef __cocos2d_libs__CCEventAssetsManagerEx__
#define __cocos2d_libs__CCEventAssetsManagerEx__

#include "base/CCEvent.h"
#include "base/CCEventCustom.h"
#include "extensions/ExtensionMacros.h" 
#include "extensions/ExtensionExport.h"

NS_CC_EXT_BEGIN

class AssetsManagerEx;

class CC_EX_DLL EventAssetsManagerEx : public cocos2d::EventCustom
{
public:
    
    friend class AssetsManagerEx;
    
    //! Update events code
    enum class EventCode
    {
        ERROR_NO_LOCAL_MANIFEST,        // 本地manifest错误
        ERROR_DOWNLOAD_MANIFEST,        // 下载manifest失败
        ERROR_PARSE_MANIFEST,           // 解析manifest失败
        NEW_VERSION_FOUND,              // 检测到新版本
        ALREADY_UP_TO_DATE,             // 已经是最新版本
        UPDATE_PROGRESSION,             // 更新进度
        ASSET_UPDATED,                  // 资源下载成功
        ERROR_UPDATING,                 // 下载文件失败
        UPDATE_FINISHED,                // 更新完成
        UPDATE_FAILED,                  // 更新失败
        ERROR_DECOMPRESS                // 解压文件失败
    };
    
    EventCode getEventCode() const { return _code; }
    
    int getCURLECode() const { return _curle_code; }
    
    int getCURLMCode() const { return _curlm_code; }
    
    std::string getMessage() const { return _message; }
    
    std::string getAssetId() const { return _assetId; }
    
    cocos2d::extension::AssetsManagerEx *getAssetsManagerEx() const { return _manager; }
    
    float getPercent() const { return _percent; }
    
    float getPercentByFile() const { return _percentByFile; }
    
CC_CONSTRUCTOR_ACCESS:
    /** Constructor */
    EventAssetsManagerEx(const std::string& eventName, cocos2d::extension::AssetsManagerEx *manager, const EventCode &code, float percent = 0, float percentByFile = 0, const std::string& assetId = "", const std::string& message = "", int curle_code = 0, int curlm_code = 0);
    
private:
    EventCode _code;
    
    cocos2d::extension::AssetsManagerEx *_manager;
    
    std::string _message;
    
    std::string _assetId;
    
    int _curle_code;
    
    int _curlm_code;
    
    float _percent;
    
    float _percentByFile;
};

NS_CC_EXT_END

#endif /* defined(__cocos2d_libs__CCEventAssetsManagerEx__) */
