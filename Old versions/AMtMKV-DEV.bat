@rem !This file wrote in GB2312-80(zh-Hans) code page, do not open with other code pages. But you can even open this file with UTF-8 or UTF-16, these code pages can also show the texts!
@rem 关闭命令回显
@echo off
rem 变换标题
title [初始化] 请稍等...
rem ------------------------------------------
rem OutPath自定义变量
rem [空] 无赋值时，程序会将封装完成的文件输出到源文件夹
rem [有效路径] 有正确赋值时，程序会将封装完成的文件输出到目标文件夹
rem 		(路径可以为不存在的路径，程序会自动创建)
rem 语法：set "outpath=值(路径不需要前后引号)"
rem 
rem 第三方用法：[有效路径] 同上
rem 			[无效路径] 输出到源文件夹，作无赋值处理
set "outpath="
rem ------------------------------------------
rem SearchFilter自定义变量
rem [空] 无赋值时，程序会使用默认值(*.*)
rem [任意] 任意赋值时，若输入文件夹，程序将只封装符合匹配的文件
rem 	过滤器语法：可使用通配符(*)，如"*.mp4"将匹配所有后缀名为MP4的文件
rem 				也可在文件名中使用通配符，如"*DMG*.*"将匹配所有名称中含有DMG的文件
rem 语法：set "searchfilter=值"
rem 
rem 第三方用法：[缺省] 同"空"
rem 			[任意] 同"任意"
set "searchfilter="
rem ------------------------------------------
rem MKVmerge进程优先级/界面语言
rem 如果您不懂这方面的知识，请不要随意修改
rem 界面语言(默认"zh_CN"(简体中文))
set "ui_language=zh_CN"
rem 优先级(默认"normal"(标准))
set "priority=normal"
rem ------------------------------------------
rem DEBUG_MODE
rem 测试模式下将会关闭所有CLS并开启ECHO
rem 注意!开启此项将强制开启NUL_OUTPUT!
rem [0] 启用
rem [非0] 停用
set "debug_mode=1"
rem ------------------------------------------
rem NUL_OUTPUT
rem 该变量仅用于测试！请不要随意开启！
rem NUL_OUTPUT开启时将会让MKVmerge把结果输出到NUL(不输出)
rem 以加快测试速度并减少磁盘使用
rem [0] 启用
rem [非0] 停用
set "nul_output=1"
rem ------------------------------------------
rem EXEin
rem 该变量决定运行时所用的MKVmerge的路径
rem
set "exein=mkvmerge"
rem ------------------------------------------
rem DIR_ORDER
rem 该变量决定DIR对视频文件的排序，也决定了拼合后视频的先后顺序
rem
rem 排列顺序     N  按名称(字母顺序)     S  按大小(从小到大)
rem              E  按扩展名(字母顺序)   D  按日期/时间(从先到后)
rem              G  组目录优先           -  反转顺序的前缀
rem
set "dir_order=N"
rem ------------------------------------------
rem append_mode
rem 该变量决定mkvmerge对文件合并时的时间戳处理方式
rem (以下文本来自mkvmerge Document)
rem 
rem 当 mkvmerge 将来自另一文件 (本段中假设为 '文件2') 的一条轨道 (假设为 '轨道2_1' ) rem 追加合并到首个文件 (假设为 '文件1')的一条轨道 (假设为 '轨道1_1') 时，它将为'轨道2_1' 的所有时间戳设定一定量的延时。
rem 对于 'file（文件）' 模式此延时量是 '文件1' 中遇到的最大时间戳，即使此时间戳不属于轨道 '轨道1_1'。
rem 而在 track （轨道模式）下此延时为 '轨道1_1' 的最大时间戳。
rem 
rem 不幸的是 mkvmerge 无法侦测使用哪种模式更为可靠。
rem 'file（文件）' 模式对单独创建的文件的处理通常更好；例如在追加 AVI 或 MP4 文件时。
rem 'track（轨道）' 模式对一个大文件的完整分块的处理更好，例如对于 VOB 与 EVO 文件。 
rem
set "append_mode=file"
rem ------------------------------------------
rem DEBUG模块，在程序意外终止时会挂起程序
:Module_DEBUG
if not defined debug (
	set debug=0
	cmd /c call "%~0" "%~1" "%~2%~3%~4%~5%~6%~7%~8%~9"
	if "%~1"=="" (
		echo [Module_DEBUG] 请按任意键退出... 
		pause>nul
		exit
	) else (
		if defined title (
			title %title%
		) else title Command Shell
		set "debug="
		goto :EOF
	)
) else set "debug="
rem 清屏
:get_input
rem EasyUse命令输入分析
if /i "%~1"=="-h" goto Show_Help
if /i "%~1"=="-help" goto Show_Help
if /i "%~1"=="/help" goto Show_Help
if /i "%~1"=="/h" goto Show_Help
if /i "%~1"=="/?" goto Show_Help
if /i "%~1"=="?h" goto Show_Help
if not "%debug_mode%"=="0" cls
if "%debug_mode%"=="0" echo on
if "%~2"=="" goto not_check_input
set "split_count=0"
setlocal enabledelayedexpansion
:split_input
if defined input[%split_count%] (
	for /f "tokens=1* delims==" %%a in ('set input[%split_count%]') do (
		set "last_split=%%~b"
	)
)
set /a split_count=split_count+1
for /f "tokens=%split_count% delims=?" %%a in ("%~2") do (
	set "test_input=%%~a"
)
if not "%test_input%"=="" (
	if "%last_split%"=="%test_input%" (
		set /a split_count=split_count-1
		set "last_split="
		set "test_input="
		set "space_cache="
		goto split_out
	)
)
:del_space
set "space_cache=%test_input:~-1%"
if "%space_cache%"==" " (
	set "test_input=!test_input:~0,-1!"
) else (
	set "input[%split_count%]=%test_input%"
	goto out_space_del
)
goto del_space
:out_space_del
goto split_input
:split_out
setlocal disabledelayedexpansion
for /l %%a in (1,1,%split_count%) do (
	for /f "tokens=1* delims==" %%b in ('set input[%%a]') do (
		for /f "tokens=1* delims= " %%d in ("%%c") do (

			if /i "%%~d"=="h" (
				goto Show_Help
			)
			
			if /i "%%~d"=="out" (
				if exist "%%~e" (
					set "outpath=%%~e"
				) else if not "%%~e"=="" (
					mkdir "%%~e">nul 
					if exist "%%~e" (
						set "outpath=%%~e"
					) else (
						echo [EasyUse Error] 输出路径无效
						pause
						exit
					)
				)
			)
			
			if /i "%%~d"=="exe" (
				if exist "%%~e" (
					set "exein=%%~e"
				) else set "exein=mkvmerge"
			)
			
			if /i "%%~d"=="app" (
				if /i "%%~e"=="1" (
					set "append_mode=track"
				) else set "notdel=file"
			)
			
			if /i "%%~d"=="dbm" (
				for /f "tokens=1,2 delims=:" %%f in ("%%~e") do (
					if /i "%%~f"=="y" (
						set "debug_mode=0"
					) else set "debug_mode=1"
					
					if /i "%%~g"=="y" (
						set "nul_output=0"
					) else set "nul_output=1"
				)
			)
			
			if /i "%%~d"=="ffl" (
				if not "%%~e"=="" (
					set "searchfilter=%%~e"
				) else set "searchfilter="
			)
			
			if /i "%%~d"=="pri" (
				if "%%~e"=="0" (
					set "priority=lowest"
				) else if "%%~e"=="1" (
					set "priority=lower"
				) else if "%%~e"=="2" (
					set "priority=normal"
				) else if "%%~e"=="3" (
					set "priority=higher"
				) else if "%%~e"=="4" (
					set "priority=highest"
				)
			)
			
			if /i "%%~d"=="uil" (
				if "%%~e"=="1" (
					set "ui_language=en"
				) else if "%%~e"=="2" (
					set "ui_language=zh_CN"
				) else if "%%~e"=="3" (
					set "ui_language=zh_TW"
				) else if "%%~e"=="4" (
					set "ui_language=ja"
				) else if not "%%~e"=="" (
					set "ui_language=%%~e"
				)
			)
			
			if /i "%%~d"=="ord" (
				if /i "%%~e"=="N" (
					set "dir_order=N"
				) else if /i "%%~e"=="E" (
					set "dir_order=E"
				) else if /i "%%~e"=="S" (
					set "dir_order=S"
				) else if /i "%%~e"=="D" (
					set "dir_order=D"
				) else if /i "%%~e"=="G" (
					set "dir_order=G"
				) else if /i "%%~e"=="-N" (
					set "dir_order=-N"
				) else if /i "%%~e"=="-E" (
					set "dir_order=-E"
				) else if /i "%%~e"=="-S" (
					set "dir_order=-S"
				) else if /i "%%~e"=="-D" (
					set "dir_order=-D"
				) else if /i "%%~e"=="-G" (
					set "dir_order=-G"
				)
			)
		)
	)
)
:check_input
if exist "%~1" (
	set "ifolder=%~1"
) else (
	echo [ERROR] 输入路径有误
	goto Show_Help	
)
:not_check_input
rem 获取基本信息
set "rf=%~dp0"
rem 定位到程序所在目录，防止以管理员模式启动导致尴尬局面
cd /d "%rf%"
rem 变更标题
if not "%debug_mode%"=="0" cls
title [LOAD] 正在测试mkvmerge可用性...
echo [LOAD] 正在测试mkvmerge是否可用...
:check_mkvmerge
rem 测试MKVmerge是否可用
for /f "tokens=*" %%a in ("%exein%") do (
	if exist "%%~a" (
		for /f "tokens=1 delims=-" %%b in ("%%~aa") do (
			if "%%~b"=="d" (
				for /r "%exein%" %%c in ("*mkvmerge*.exe") do (
					if exist "%%~c" set "exein=%%~c"
				)
			)
		)
	)
)

call "%exein%" -V>nul 2>nul

if not "%errorlevel%"=="0" (
	echo [ERROR] EXEIN所设置的路径无效
	set "errorlevel=0"
) else goto no_check_again

call "mkvmerge" -V>nul 2>nul

if "%errorlevel%"=="0" (
	set "exein=mkvmerge"
	echo [CORRECT] EXEIN=mkvmerge
) else (
	echo [ERROR] 无法使用MKVmerge
	title [ERROR] AMtMKV can't use MKVmerge
	exit
)
:no_check_again
echo [LOAD] 正在测试语言"%ui_language%"是否可用...
for /f "skip=1 tokens=1 delims= " %%a in ('call "%exein%" --ui-language list') do (
	if "%ui_language%"=="%%~a" goto uil_check_ok
)
echo [ERROR] 语言"%ui_language%"不可用
echo [CORRECT] 已更改为默认语言"en"
set "ui_language=en"
:uil_check_ok
set "ver=1.00-Alpha"
:time_format
for /f "tokens=*" %%a in ('time /T') do (
	for /f "delims=: tokens=1,2*" %%b in ("%%a:%time:~6,2%%time:~9,2%") do (
		set "work_time=%%b%%c%%d"
	)
)
:date_format
for /f "delims=/ tokens=1,2,3" %%a in ('date /T') do (
	set "work_date_1=%%~a"
	set "work_date_2=%%~b"
	set "work_date_3=%%~c"
	for /f "tokens=1,2 delims= " %%d in ("%%~a") do if not "%%~d"=="%%~e" (
		if "%%~d" GTR "%%~e" (
			if not "%%~e"=="" set "work_date_1=%%e"
		) else if not "%%~d"=="" set "work_date_1=%%d"
	)
	for /f "tokens=1,2 delims= " %%d in ("%%~b") do if not "%%~d"=="%%~e" (
		if "%%~d" GTR "%%~e" (
			if not "%%~e"=="" set "work_date_2=%%e"
		) else if not "%%~d"=="" set "work_date_2=%%d"
	)
	for /f "tokens=1,2 delims= " %%d in ("%%~c") do if not "%%~d"=="%%~e" (
		if "%%~d" GTR "%%~e" (
			if not "%%~e"=="" set "work_date_3=%%e"
		) else if not "%%~d"=="" set "work_date_3=%%d"
	)
)
set "work_date=%work_date_1%%work_date_2%%work_date_3%"
set "r_out_dir=%rf%[ASFMKV]redirect-output"
set "date_logdir=%rf%[ASFMKV]redirect-output\%work_date%"
set "logdir=%rf%[ASFMKV]redirect-output\%work_date%\%work_time%"
if not "%debug_mode%"=="0" cls
rem 获取MKVmerge的版本信息并更改标题
echo [INF] AMtMKV V%ver% ^| Copyright(c) 2018-2019 yyfll
for /f "tokens=1-2* delims= " %%a in ('call "%exein%" -V') do (
	if "%debug_mode%"=="0" (
		title AppendMedia-to-MKV [USE:%%a %%b][GB2312][VER. %ver%^(DEBUG_MODE^)]
	) else title AppendMedia-to-MKV [USE:%%a %%b][GB2312][VER. %ver%]
	echo [USE] %%a %%b ^| Copyright^(c^) 2002-2019 Moritz Bunkus
)
rem 如果已有输入就直接执行
echo.
@if "%debug_mode%"=="0" echo off
call :show_custom_settings
@if "%debug_mode%"=="0" echo on
if defined ifolder goto check_path
:need_folder
rem 向用户获取路径
echo.
set "ifolder="
echo [DEV] 在Alpha版本中仅支持双层目录类型输入
echo [DEV] 你的文件必须放在"输入目录\任意目录"下才能被识别
echo.
set /p ifolder=文件(或目录)路径(不带引号)：
rem 如果用户没有输入，则再次向用户获取；如果存在，则尝试去除引号
if not defined ifolder (
	if not "%debug_mode%"=="0" cls
	echo [ERROR] 您没有输入任何路径！
	goto need_folder
)
if exist "%ifolder:~1,-1%" (
	set "ifolder=%ifolder:~1,-1%"
) else set "ifolder=%ifolder%"
rem pause
:check_path
rem 如果路径不存在，则再次向用户获取
if not exist "%ifolder%" (
	if not "%debug_mode%"=="0" cls
	echo [ERROR] 路径无效！
	goto need_folder
)
echo.
:start_encode
if not "%debug_mode%"=="0" cls
rem 初始化变量
set working=0
set error=0
set count=0
rem 确认是目录还是文件
set "dirin="
for %%a in ("%ifolder%") do (
	set "attribute=%%~aa"
)
if /i not %attribute:~0,1%==d (
	echo [ERROR] 输入不能为单文件
	goto :EOF
) else goto get_file_list
if defined attribute (
	echo [ERROR] 输入不能为单文件
	goto :EOF
)
:get_file_list
if not "%ifolder:~-1%"=="\" set "ifolder=%ifolder%\"
rem 如果是目录则执行以下流程
rem 删除先前用于记录文件列表的LOG，防止重复写入
if exist "%APPDATA%\dirlist.log" del /q "%APPDATA%\dirlist.log"
title [yyfll的批量混流程序] 正在生成文件列表...请不要关闭本程序...
echo [input.get_file_list] 正在生成运行所需的文件列表...
rem 将符合搜索条件的文件的完整路径全部写入到filelist文件
for /f "tokens=*" %%a in ('dir /A:D /B "%ifolder%"') do (
	set /a count=count+1
	echo "%ifolder%%%~a">>"%APPDATA%\dirlist.log"
)
goto INPUT_DIR_COUNT0
:check_path_length
set "path_length=%~1"
if not "%path_length:~259%"=="" echo [ERROR] 文件路径超长(260字符上限)
goto :EOF
:INPUT_DIR_COUNT0
rem 如果count记录的文件数为0，则报错
if %count%==0 (
	echo [ERROR] 路径为空目录！
	goto need_folder
)
rem 获取目标目录中的所有文件，并逐次递交负责输出路径控制、MKV封装的模块
for /f "usebackq tokens=*" %%a in ("%APPDATA%\dirlist.log") do (
	if exist "%%~a" (
		set "vdir=%%~a"
		call :Module_GetOutputPath
		call :Module_EncapsulationMKV
	)
)
:check_log_dir
if exist "%logdir%" (
	for /r "%logdir%" %%a in (*.log) do (
		if exist "%%~a" (
			if not "%%~za" GTR "0" (
				rmdir "%logdir%" 2>nul
			) else goto logdir_has_file
		)
	)
)
:ld_has_file
if exist "%date_logdir%" (
	for /r "%date_logdir%" %%a in (*.log) do (
		if exist "%%~a" (
			if not "%%~za" GTR "0" (
				rmdir "%logdir%" 2>nul
			) else goto date_ld_has_file
		)
	)
)
:date_ld_has_file
if exist "%r_out_dir%" (
	for /r "%r_out_dir%" %%a in (*.log) do (
		if exist "%%~a" (
			if not "%%~za" GTR "0" (
				rmdir "%logdir%" 2>nul
			) else goto Process_End
		)
	)
)
:Process_End
title [yyfll的批量混流程序] 混流完成！
if not "%debug_mode%"=="0" cls
if not "%nul_output%"=="0" if defined outpath echo [OutPath] 混流完成的文件输出到"%outpath%"
if %error% GTR 0 (
	goto Has_Error
) else echo [共处理%count%项且全部处理成功]
echo 任务完成！
goto Batch_End
:Has_Error
echo [共处理%count%项，其中有%error%项未能成功处理]
if exist "%logdir%" CHOICE /C YN /M "是否要查看LOG文件？"
if "%error%"=="1" (
	if exist "%logdir%" (
		start "%logdir%"
	) else echo 找不到log文件夹...
echo.
:Batch_End
rem 删除运行所需的文件列表
if exist "%APPDATA%\filelist.log" del /q "%APPDATA%\filelist.log"
rem 如果是不是第三方调用则挂起
if "%~1"=="" pause
exit
:Module_EncapsulationMKV
rem 如果被其他模块要求不执行封装，则立刻退出
if defined notwork set "notwork=" && goto :EOF
set /a working=working+1
title [yyfll的批量混流程序] 正在混流"%filename%"...(第%working%项/共%count%项)
if not "%debug_mode%"=="0" cls
set "mkvinput="
:Start_Encapsulation
if not exist "%logdir%" mkdir "%logdir%" 2>nul
call :show_custom_settings
echo.
for /f "tokens=* usebackq" %%a in ("%APPDATA%\filelist.log") do (
	set /a filecount=filecount+1
)
for /f "tokens=* usebackq" %%a in ("%APPDATA%\filelist.log") do (
	set "mkvinput="%%~a""
	goto end_getfile
)
:end_getfile
set "fileloop=1"
:get_file_input
if %fileloop%==%filecount% goto get_file_input_end
for /f "skip=%fileloop% tokens=* usebackq" %%a in ("%APPDATA%\filelist.log") do (
	set "mkvinput=%mkvinput% +"%%~a""
)
set /a fileloop=fileloop+1
:get_file_input_end
if not defined mkvinput (
	set /a error=error+1 
	goto :EOF
)
rem 当nul_output为0时，将会把结果输出到NUL以在测试时不占用磁盘空间
:run_mkvmerge
set "debug_file=%rf%DEBUG-%working%.log"
if "%nul_output%"=="0" (
	call "%exein%" -o NUL --ui-language "%ui_language%" --append-mode %append_mode% -v %mkvinput%
	if "%errorlevel%"=="2" (
		set /a error=error+1
		echo INPUT_FILE："%vdir%">"%debug_file%"
		echo [DEBUG.mkvmerge] 正在重新运行并重定向mkvmerge输出...
		call "%exein%" -o NUL -v -r "%debug_file%" --ui-language "%ui_language%" --append-mode %append_mode% "%%~a"
	)
) else (
	call "%exein%" -o "%opath%" --ui-language "%ui_language%" --priority "%priority%" -v --title "Append-MKV_%ver%" %mkvinput%
	if not "%errorlevel%"=="0" (
		set /a error=error+1
		echo INPUT_FILE："%vdir%">"%debug_file%"
		echo [DEBUG.mkvmerge] 正在重新运行并重定向mkvmerge输出...
		call "%exein%" -o NUL -r "%debug_file%" --ui-language "%ui_language%" --priority "%priority%" -v --title "Append-MKV_%ver%" %mkvinput%
	)
)
if exist "%debug_file%" move -y "%debug_file%" "%logdir%"
:Encapsulation_OK
if not "%nul_output%"=="0" (
	if not exist "%opath%" (
		set /a error=error+1
		goto :EOF
	)
)
if exist "%~dp0replace.log" (
	for /f "usebackq tokens=1,2 delims=^|" %%a in ("%~dp0replace.log") do (
		if not "%%~a"=="" if exist "%%~a" rename "%%~a" "%%~b"
	)
)
del /q "%~dp0replace.log"
goto :EOF
:Module_DeleteAND
set "return="
if "%~1"=="" (
	echo [ERROR] 输入无效
	pause
	goto :EOF
)
set "inputname=%~n1A"
:re_replace
for /f "tokens=1* delims=^&" %%a in ("%inputname%") do if not "%%b"=="" (
	set "inputname=%%a_%%b"
	goto re_replace
) else set "return=%inputname:~0,-1%"
echo "%~dp1%return%%~x1|%~nx1">>"%~dp0replace.log"
set "inputname="
goto :EOF
:Module_ReplaceBatch
if "%~1"=="" (
	goto RB.error_input
) else if "%~2"=="" (
	goto RB.error_input
)
set "input_string=%~1"
if "%input_string:~0,1%"=="" (
	echo [ERROR] 您没有输入任何字符！
	goto RB.error_input
)
set "for_delims=%~2"
if "%for_delims%"=="" (
	echo [ERROR] 您没有输入任何要替换的字符！
	goto RB.error_input
)
setlocal enabledelayedexpansion
for /l %%a in (0,1,1) do set "delims[%%a]=!for_delims:~%%a!"
if defined delims[1] (
	echo [ERROR] Replace对象必须是单个字符
	goto RB.error_input
)
for /f "tokens=1* delims=%for_delims%" %%a in ("%input_string%") do (
	if "%%~a%%~b"=="%input_string%" (
		echo "%input_string:~1,-1%">"%USERPROFILE%\rforbat.log"
		goto RB.end_clear
	)
)
set "replace_to=%~3"
set "output_string="
set "loop=-1"
:RB.re_replace
set /a loop=loop+1
set "RB_cache=!input_string:~%loop%,1!"
if "%RB_cache%"=="" goto RB.replace_finish
if "%RB_cache%"=="%for_delims%" (
	set "output_string=%output_string%%replace_to%"
) else set "output_string=%output_string%%RB_cache%"
goto RB.re_replace
:RB.replace_finish
echo "%output_string%">"%USERPROFILE%\rforbat.log"
:RB.end_clear
setlocal disabledelayedexpansion
set "RB_cache="
set "input_string="
set "output_string="
set "for_delims="
set "loop="
goto :EOF
:RB.error_input
echo [ERROR] 输入无效
pause
goto RB.end_clear
:Module_GetOutputPath
if exist "%APPDATA%\filelist.log" del /q "%APPDATA%\filelist.log"
for /f "tokens=*" %%a in ('dir /A:-D-I-L /B /S /O:%dir_order% "%vdir%"') do (
	if /i "%%~xa"==".mp4" (
		echo.>nul
	) else if /i "%%~xa"==".mkv" (
		echo.>nul
	) else if /i "%%~xa"==".mpeg" (
		echo.>nul
	) else if /i "%%~xa"==".avi" (
		echo.>nul
	) else if /i "%%~xa"==".rmvb" (
		echo.>nul
	) else if /i "%%~xa"==".m4v" (
		echo.>nul
	) else if /i "%%~xa"==".flv" (
		echo.>nul
	) else if /i "%%~xa"==".wmv" (
		echo.>nul
	) else if /i "%%~xa"==".mpg" (
		echo.>nul
	) else if /i "%%~xa"==".rm" (
		echo.>nul
	) else if /i "%%~xa"==".qt" (
		echo.>nul
	) else if /i "%%~xa"==".ogg" (
		echo.>nul
	) else if /i "%%~xa"==".mov" (
		echo.>nul
	) else if /i "%%~xa"==".m2ts" (
		echo.>nul
	) else if /i "%%~xa"==".webm" (
		echo.>nul
	) else (
		set notwork=0
		set /a working=working+1
		goto :EOF
	)
	echo "%%~a">>"%APPDATA%\filelist.log"
)
set "test="
if "%vdir:~-1%"=="\" (
	for %%a in ("%vdir:~0,-1%") do set "filename=%%~na"
) else for %%a in ("%vdir%") do set "filename=%%~na"
set "ostring=%ifolder%%filename%"
if defined outpath if not "%outpath%"=="" (
	if not exist "%outpath%" mkdir "%outpath%">nul
	for %%a in ("%outpath%") do set "test=%%~aa"
)
if defined test if "%test:~0,1%"=="d" if "%test:~-1%"=="\" (
	set "ostring=%outpath%%filename%"
) else set "ostring=%outpath%\%filename%"
set "test="
set "subnum=0"
set "fontnum=0"
:Start_Get_Output_Path
set "ostring=%ostring%[Append]"
set filenum=1
if not exist "%ostring%.mkv" (
	set "opath=%ostring%.mkv"
	goto :EOF
)
:ReGet_Output_Path
set "opath=%ostring%_%filenum%.mkv"
if exist "%opath%" set /a filenum=filenum+1 & goto ReGet_Output_Path
goto :EOF
:Show_Help
echo Add Subtitle^&Font to MKV [EasyUse1.0]
echo Copyright(c) 2018-2019 By yyfll
echo.
echo 显示帮助页面(本页面)可以使用以下指令:
echo Call "%~dpnx0" -h
echo Call "%~dpnx0" -help
echo Call "%~dpnx0" /h
echo Call "%~dpnx0" /?
echo.
echo 调用开关：
echo   ?h                  	显示帮助^(最高优先^)
echo   ?del [y/n]          	是否删除输入文件
echo   ?sub [y/n]          	没有字幕时是否嵌入字体文件
echo   ^(注意：sub开关在开启时会自动允许字体封装，即notfont为任意值^)
echo   ?out [path]         	输出目录
echo   ?dir [y/n]          	是否搜索子目录
echo   ?dbm [y/n]:[y/n]    	是否使用测试模式和空输出^(测试模式开关:空输出开关^)
echo   ^(注意：dbm开关若只输入一个y则同时开启测试模式和空输出，反之亦然^)
echo   ?ffl [filter]       	文件过滤器
echo   ?pri [0-4]  			选择进程优先级
echo   ?uil [1-4/input]   	选择Mkvmerge的语言
echo   ?exe [path]			自定义MKVmerge的路径
echo. 
echo 调用注意：
echo   开关必须用引号整体括起，比如
echo   "?out %APPDATA%\test ?pri 3 ?dbm n:y"
echo   当然你也可以使用旧输入方式(不能超过8个开关!)
echo   "?out %APPDATA%\test" "?pri 3" "?dbm n:y"
echo.	
echo 调用方法①^(CMD^)：
echo 	ASFMKV "输入路径" "[调用开关]"
echo.
echo 调用方法②^(CMD^):
echo 	Call "(带有某些符号的路径)\ASFMKV" "输入路径" "[调用开关]"
echo.	^(如果路径或文件名中含有括号、空格、与号或其他影响CMD的符号，可以使用Call指令并用双引号括起路径^)
echo.
echo 调用方法③:
echo   直接往BAT拖入文件或文件夹，自动运行重封装
echo.
echo 进程优先级：
echo   [0] lowest ^(最低^)
echo   [1] lower^(较低^)
echo   [2] normal^(标准^)
echo   [3] higher^(较高^)
echo   [4] highest ^(最高/实时^)
echo.
echo MKVmerge输出语言：
echo   [1] en^(English^)
echo   [2] zh_CN^(简体中文^)
echo   [3] zh_TW^(繁體中文^)
echo   [4] ja^(日本語^)
echo   该语言选项仅应用于mkvmerge输出部分，并仅在支持时使用
echo   您也可以直接输入语言，比如 "?uil zh_CN"
echo   可选的语言详见"mkvmerge --ui-language list"
echo.
echo 文件过滤器(未经测试)：
echo   搜索过滤器使用标准文件搜索语法，例如：
echo   "*.mkv"将只输入所有文件后缀名为MKV的文件
echo   "*SEFO*.*"将会输入所有文件名中含有"SEFO"的文件^(不区分大小写^)且不管后缀名是什么
echo   其实就是如何使用通配符的问题罢了
exit
:show_custom_settings
echo [CUSTOM SETTINGS]
echo [A/Active][N/Undefined][L/Unsupport]
if defined outpath (echo [OUT][A] 输出到目录"%outpath%") else (echo [OUT][N] 输出到源目录)
if "%debug_mode%"=="0" (echo [DBM][A] 已启用测试模式) else (echo [DBM][N] 未使用测试模式)
if "%nul_output%"=="0" (echo [NUL][A] 已启用空输出) else (echo [NUL][N] 正常输出)
rem if not defined searchfilter (
rem 	set "searchfilter=*"
rem 	set "filter=.*"
rem 	echo [FFL][N] 未使用文件过滤器
rem ) else echo [FFL][A] 已加载文件过滤器"%searchfilter%"
echo [FFL][L] 暂不支持文件过滤器
echo [PRI][A] 优先级"%priority%"
echo [UIL][A] MKVmerge输出语言"%ui_language%"
if not "%exein%"=="mkvmerge" (
	echo [EXE][A] 使用"%exein%"
) else echo [EXE][N] 使用默认程序
goto :EOF