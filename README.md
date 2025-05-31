Windows MPV截图复制到剪贴板|Windows MPV copy screenshot to clipboard

按下c键复制截图（带字幕），C键复制无字幕截图，每张截图都会以视频标题（如果有）或者视频文件名为文件名储存在截屏文件夹
## 使用方法：
1. 下载[NirCmd](http://www.nirsoft.net/utils/nircmd.HTML)，解压后最好将nircmdc.exe加入系统PATH（也可以直接将其复制到C:\Windows）；
2. 将此脚本复制到MPV Scripts文件夹⸺%appdata%/mpv/scripts/或/portable_config/scripts/文件夹（portable_config文件夹位于mpv.exe所在目录)

可以传参来指定nircmdc路径，这样就可以不将其加入PATH。比如mpv PathToTheVideo.mkv --script-opts=nircmdc_path="C:\Users\YourNane\Applications\nircmdc.exe"

感谢这两个脚本带给我的思路：[clipshot.lua](https://github.com/ObserverOfTime/mpv-scripts/blob/master/clipshot.lua)、[screenshot-to-clipboard.js](https://github.com/zc62/mpv-scripts/blob/master/screenshot-to-clipboard.js)
