LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# bugly相关
include $(CLEAR_VARS)
LOCAL_MODULE := bugly_native_prebuilt

LOCAL_SRC_FILES := prebuilt/libBugly.so
include $(PREBUILT_SHARED_LIBRARY)
# -- 

LOCAL_MODULE := cocos2dlua_shared

LOCAL_MODULE_FILENAME := libcocos2dlua

LOCAL_SRC_FILES := \
../../Classes/AppDelegate.cpp \
hellolua/main.cpp

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../Classes

# _COCOS_HEADER_ANDROID_BEGIN
# _COCOS_HEADER_ANDROID_END

LOCAL_STATIC_LIBRARIES := cocos2d_lua_static
# 引入bugly/Android.mk定义的Module
LOCAL_STATIC_LIBRARIES += bugly_crashreport_cocos_static
# 引入bugly/lua/Android.mk定义的Module 
LOCAL_STATIC_LIBRARIES += bugly_agent_cocos_static_lua

# _COCOS_LIB_ANDROID_BEGIN
# _COCOS_LIB_ANDROID_END

include $(BUILD_SHARED_LIBRARY)

$(call import-module,scripting/lua-bindings/proj.android)
$(call import-module,external/bugly)
$(call import-module,external/bugly/lua)

# _COCOS_LIB_IMPORT_ANDROID_BEGIN
# _COCOS_LIB_IMPORT_ANDROID_END
