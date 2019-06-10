if nil == cc.SimpleAudioEngine then
    return
end
--Encapsulate SimpleAudioEngine to AudioEngine,Play music and sound effects.
local M = {}

function M.stopAllEffects()
    cc.SimpleAudioEngine:getInstance():stopAllEffects()
end

-- 获得背景音乐音量
function M.getMusicVolume()
    return cc.SimpleAudioEngine:getInstance():getMusicVolume()
end

-- 判断背景音乐是否播放
function M.isMusicPlaying()
    return cc.SimpleAudioEngine:getInstance():isMusicPlaying()
end

-- 获得音效音量
function M.getEffectsVolume()
    return cc.SimpleAudioEngine:getInstance():getEffectsVolume()
end

-- 设置背景音乐音量
function M.setMusicVolume(volume)
    cc.SimpleAudioEngine:getInstance():setMusicVolume(volume)
end

-- 停止播放某一音效
function M.stopEffect(handle)
    cc.SimpleAudioEngine:getInstance():stopEffect(handle)
end

-- 停止播放背景音乐(是否释放数据)
function M.stopMusic(isReleaseData)
    local releaseDataValue = false
    if nil ~= isReleaseData then
        releaseDataValue = isReleaseData
    end
    cc.SimpleAudioEngine:getInstance():stopMusic(releaseDataValue)
end

-- 播放背景音乐(isLoop 是否循环播放)
function M.playMusic(filename, isLoop)
    local loopValue = false
    if nil ~= isLoop then
        loopValue = isLoop
    end
    cc.SimpleAudioEngine:getInstance():playMusic(filename, loopValue)
end

-- 暂停所有音效的播放
function M.pauseAllEffects()
    cc.SimpleAudioEngine:getInstance():pauseAllEffects()
end

-- 预加载背景音乐
function M.preloadMusic(filename)
    cc.SimpleAudioEngine:getInstance():preloadMusic(filename)
end

-- 恢复播放背景音乐
function M.resumeMusic()
    cc.SimpleAudioEngine:getInstance():resumeMusic()
end

-- 播放音效
function M.playEffect(filename, isLoop)
    local loopValue = false
    if nil ~= isLoop then
        loopValue = isLoop
    end
    return cc.SimpleAudioEngine:getInstance():playEffect(filename, loopValue)
end

-- 将背景音乐倒回起始点播放
function M.rewindMusic()
    cc.SimpleAudioEngine:getInstance():rewindMusic()
end

function M.willPlayMusic()
    return cc.SimpleAudioEngine:getInstance():willPlayMusic()
end

-- 卸载预加载的音效文件
function M.unloadEffect(filename)
    cc.SimpleAudioEngine:getInstance():unloadEffect(filename)
end

-- 预加载音效
function M.preloadEffect(filename)
    cc.SimpleAudioEngine:getInstance():preloadEffect(filename)
end

-- 设置音效音量
function M.setEffectsVolume(volume)
    cc.SimpleAudioEngine:getInstance():setEffectsVolume(volume)
end

-- 暂停播放音效
function M.pauseEffect(handle)
    cc.SimpleAudioEngine:getInstance():pauseEffect(handle)
end

-- 继续播放所有音效
function M.resumeAllEffects()
    cc.SimpleAudioEngine:getInstance():resumeAllEffects()
end

-- 暂停播放背景音乐
function M.pauseMusic()
    cc.SimpleAudioEngine:getInstance():pauseMusic()
end

-- 恢复指定音效
function M.resumeEffect(handle)
    cc.SimpleAudioEngine:getInstance():resumeEffect(handle)
end

function M.getInstance()
    return cc.SimpleAudioEngine:getInstance()
end

function M.destroyInstance()
    return cc.SimpleAudioEngine:destroyInstance()
end

AudioEngine = M
