--来源：https://github.com/Jiang10086/MPV-Scirpts

--Windows MPV截图复制到剪贴板

-- 在系统PATH中寻找nircmdc
local nircmdc = "nircmdc"

-- 检查是否有自定义nircmdc路径，如果有，使用指定的nircmdc
local opt = mp.get_opt("nircmdc_path")
if opt then
    nircmdc = opt
end

-- 定义一个功能：截图并复制到粘贴板
local function take_screenshot(mode)
    -- 获取视频标题；如果视频无标题，会返回视频文件名
    local title = mp.get_property('media-title')
    
    -- 替换标题中不能用于Windows文件名的字符为下划线
    local safe_title = title:gsub('[<>:"/\\|?*]', '_')
    
    -- 获取当前播放时间
    local time = mp.get_property_number('time-pos')
    
    -- 格式化时间为HH.MM.SS
    local hours = math.floor(time / 3600)
    local minutes = math.floor((time % 3600) / 60)
    local seconds = math.floor(time % 60)
    local timestamp = string.format('%02d.%02d.%02d', hours, minutes, seconds)
    
    -- 拼接文件名，以png格式截屏
    local filename = safe_title .. '@' .. timestamp .. '.png'
    
    -- 指定截图目录为系统默认截屏文件夹，一般为C:\Users\YourName\Pictures\Screenshots
    local file_dir = os.getenv('USERPROFILE') .. '\\Pictures\\Screenshots\\'
    
    -- 拼接目录和文件名以构成完整的文件路径
    local file_path = file_dir .. filename
    
	-- 如果不想保存一大堆截图文件，可以直接指定路径，这样每次截图都会覆盖上一次截图文件。具体方法为删掉local title到local file_dir这几行，上一行改为储存路径（如local file_path = os.getenv('USERPROFILE') .. '\\Pictures\\Screenshots\\mpv-screenshot.png'）
	
    -- 执行截图命令，其中mode可以是video或者subtitle，根据按键决定
    mp.commandv('screenshot-to-file', file_path, mode)
    
    -- 使用nircmdc复制到剪贴板。function用于完成后返回是否执行成功。用PowerShell命令似乎会非常慢
    mp.command_native_async({'run', nircmdc, 'clipboard', 'copyimage', file_path}, 
        function(success, _, error)
            if success then
                mp.osd_message('Screenshot copied to clipboard')
            else
                mp.osd_message('Failed to copy screenshot: ' .. (error or 'unknown error'))
            end
        end)
end

-- 按下「c」键带字幕截图
mp.add_key_binding('c', 'copy-screenshot-with-subtitle', function()
    take_screenshot('subtitles')
end)

-- 按下「C」键无字幕截图
mp.add_key_binding('C', 'copy-screenshot-without-subtitle', function()
    take_screenshot('video')
end)
