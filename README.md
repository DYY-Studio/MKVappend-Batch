# MKVappend-Batch
将多个视频文件合并为一个MKV文件的批量处理程序

本批处理遵循GNU通用公共许可协议第二版(GPLv2)

本批处理依赖于mkvmerge

# 本程序已停止维护

## WARNING
请勿将本程序用于已链接的视频文件（如DVD VOB、软链接MKV）！！

会导致重复合并而产生严重的后果！

## 关于ExtLIST版本和标准DEV版本的区别
ExtLIST版本是最新的开发版，尚未经过大量的实践测试，可能不够稳定。

但ExtList版本中加入了扩展名过滤器的定义功能，在遇到格式不能输入的时候，可以选择修改Extlist。

DEV8_1是原本的稳定版，虽然各方面比较麻烦，但是稳定、迅速

## 兼容性
* Windows7 及以上版本
* 任意处理器，能开机就好
* 能够正常运行mkvmerge

## 开始使用
其实很简单，你只需要把文件夹路径输进去，或者直接把文件夹拖到CMD窗口让CMD自己转换成路径，就OK了

作为一键式批处理程序，用起来很简单，但是也会经常出问题，我自己DEBUG排除不了一些特别麻烦的操作错误，所以请正确使用

## 格式支持
> 以下文本来自mkvmerge DOC

*以下格式仅为Batch内建过滤表默认可以输入的格式*
* AVC/h.264 elementary streams [264 avc h264 x264]
* HEVC/h.265 elementary streams [265 hevc h265 x265]
* AVI (Audio/Video Interleaved) [avi]
* FLV (Flash Video) [flv]
* IVF (AV1, VP8, VP9) [ivf]
* MP4 video files [mp4 m4v]
* MPEG program streams [mpg mpeg m2v mpv evo evob vob]
* MPEG transport streams [ts m2ts mts]
* MPEG video elementary streams [m1v m2v mpv]
* Matroska video files [mkv mk3d webm webmv]
* QuickTime video files [mov]
* AV1 Open Bitstream Units stream [av1 obu]
* Ogg video files [ogg ogv]
* RealMedia video files [rm rmvb rv]
* VC-1 elementary streams [vc1]
* WebM video files [webm webmv]

## 错误记录系统
    这个批处理的错误记录系统呢......其实超简单的
    (简单到ASFMKV的错误记录系统出BUG好久都没被发现，直到做AMtMKV这个超容易出错的批处理的测试除错时才发现问题)
    其实就是直接用了mkvmerge的输出重定向功能，凡是mkvmerge发出警告（非空输出返回值不为0、空输出返回值大于1时）这个批处理就会再跑一次相同的任务并重定向输出
    然后我们来讲一下日志目录
    首先是顶层目录，即"[AMtMKV]redirect-output"，其实并没有什么深层含义，就是告诉你这是重定向输出的文件夹
    次级目录的目录名是运行时的年份和日期，按照本地化顺序排列，对于东亚、东南亚地区，一般是"年月日"的顺序，比如"20190331"就是"2019年03月31日"
    最后是底层目录，该层目录的目录名是打开批处理的时间，比如"09365095"就是"09时36分50秒95毫秒"
    打开底层目录，看到"DEBUG-1.log"，这时这个"1"就是任务顺序，对于多任务时还会有"DEBUG-2"、"DEBUG-3"
    这些重定向的log文件都是"UTF-8-BOM"文本编码的，如果读不出来请注意切换文本编码（应该不会吧）
    
## 使用命令提示符进行高级输入

> 可以允许的开关

    ?h                显示帮助(最高优先)
    ?out [path]       输出目录
    ?dbm [y/n]:[y/n]  是否使用测试模式和空输出(测试模式开关:空输出开关)
    (注意：dbm开关若只输入一个y则同时开启测试模式和空输出，反之亦然)
    ?ffl [filter]     文件过滤器(正在开发)
    ?pri [0-4]        选择进程优先级
    ?uil [1-4/input]  选择MKVmerge语言
    ?exe [path]       输入MKVmerge路径

> 开关输入注意

开关必须整体用引号括起，比如
    
    "?out %APPDATA%\test ?pri 3 ?dbm n:y"
    
> 通过命令行输入

* AMtMKV "输入路径" "[开关]"
* Call "(带有某些符号的路径)\AMtMKV" "输入路径" "[开关]"

> 开关释义

* MKVmerge进程优先级(优先级)：

      [0] lowest
      [1] lower
      [2] normal
      [3] higher
      [4] highest

* MKVmerge界面语言(UI语言)：
  
      [0] English(en)
      [1] 简体中文(zh_CN)
      [2] 正體中文(zh_TW)
      [3] 日本語(ja)
      [其他] 若输入正确则使用该语言

## 依赖
[MKVmerge(LICENSE: GPLv2)](https://mkvtoolnix.download/downloads.html)

    Copyright© 2002–2018 Moritz Bunkus
    
[Replace for Batch(LICENSE: MIT)](https://github.com/DYY-Studio/Replace_for_Batch)

    Copyright© 2018-2019 yyfll(dyystudio@qq.com)
    [Replace for Batch V4]
    [Replace BackSlash (Replace for Batch V1)]
    
