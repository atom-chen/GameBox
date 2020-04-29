#### 修改文件：
```
frameworks/cocos2d-x/cocos/audio/win32/SimpleAudioEngine.h
frameworks/cocos2d-x/cocos/audio/win32/SimpleAudioEngine.cpp
frameworks/cocos2d-x/cocos/audio/win32/MciPlayer.h
frameworks/cocos2d-x/cocos/audio/win32/MciPlayer.cpp
```

##### SimpleAudioEngine.h
```
// 类中添加成员变量：
private:
    float m_effectVolume;
```

##### SimpleAudioEngine.cpp
```
// 初始化音效变量
SimpleAudioEngine::SimpleAudioEngine() : m_effectVolume(1.0f)
{
}

// 播放音效中，添加音效大小控制
unsigned int SimpleAudioEngine::playEffect(const char* pszFilePath, bool bLoop,
                                           float pitch, float pan, float gain)
{
    unsigned int nRet = _Hash(pszFilePath);

    preloadEffect(pszFilePath);

    EffectList::iterator p = sharedList().find(nRet);
    if (p != sharedList().end())
    {
        p->second->Play((bLoop) ? -1 : 1);
		p->second->SetVolume((UINT)(m_effectVolume * 1000.0));  // add
    }

    return nRet;
}


// 获取背景音量大小
float SimpleAudioEngine::getBackgroundMusicVolume()
{
	return sharedMusic().GetVolume() / 1000.0f;
}

// 设置背景音量大小
void SimpleAudioEngine::setBackgroundMusicVolume(float volume)
{
	sharedMusic().SetVolume((UINT)(volume * 1000.0));
}

// 获取音效大小
float SimpleAudioEngine::getEffectsVolume()
{
	return m_effectVolume;
}

// 设置音效大小
void SimpleAudioEngine::setEffectsVolume(float volume)
{
	m_effectVolume = volume;
	EffectList::iterator iter;
	for (iter = sharedList().begin(); iter != sharedList().end(); iter++)
	{
		iter->second->SetVolume((UINT)(volume * 1000.0));
	}

}
```

##### MciPlayer.h
```
// 在类声明的public中添加方法：
/*
@brief volume value ranges from 0 ~ 1000
*/
void SetVolume(UINT volume);

/*
@ return volume value ranges from 0 ~ 1000
*/
UINT GetVolume() const;
```

##### MciPlayer.cpp
```
#include <digitalv.h>           // 添加库引用

void MciPlayer::SetVolume(UINT volume)
{
	if (!_dev)
		return;
	MCI_DGV_SETAUDIO_PARMS mciParams = { 0 };
	mciParams.dwItem = MCI_DGV_SETAUDIO_VOLUME;
	mciParams.dwValue = volume;
	mciSendCommand(_dev, MCI_SETAUDIO, MCI_DGV_SETAUDIO_ITEM | MCI_DGV_SETAUDIO_VALUE, (DWORD)&mciParams);
}

UINT MciPlayer::GetVolume() const
{
	if (!_dev)
		return 0;
	MCI_STATUS_PARMS mciParams = { 0 };
	mciParams.dwItem = MCI_DGV_STATUS_VOLUME;
	mciSendCommand(_dev, MCI_STATUS, MCI_STATUS_ITEM, (DWORD)&mciParams);
	return mciParams.dwReturn;
}
```