@rem !This file wrote in GB2312-80(zh-Hans) code page, do not open with other code pages. But you can even open this file with UTF-8 or UTF-16, these code pages can also show the texts!
@rem �ر��������
@echo off
rem �任����
title [��ʼ��] ���Ե�...
rem ------------------------------------------
rem OutPath�Զ������
rem [��] �޸�ֵʱ������Ὣ��װ��ɵ��ļ������Դ�ļ���
rem [��Ч·��] ����ȷ��ֵʱ������Ὣ��װ��ɵ��ļ������Ŀ���ļ���
rem 		(·������Ϊ�����ڵ�·����������Զ�����)
rem �﷨��set "outpath=ֵ(·������Ҫǰ������)"
rem 
rem �������÷���[��Ч·��] ͬ��
rem 			[��Ч·��] �����Դ�ļ��У����޸�ֵ����
set "outpath="
rem ------------------------------------------
rem SearchFilter�Զ������
rem [��] �޸�ֵʱ�������ʹ��Ĭ��ֵ(*.*)
rem [����] ���⸳ֵʱ���������ļ��У�����ֻ��װ����ƥ����ļ�
rem 	�������﷨����ʹ��ͨ���(*)����"*.mp4"��ƥ�����к�׺��ΪMP4���ļ�
rem 				Ҳ�����ļ�����ʹ��ͨ�������"*DMG*.*"��ƥ�����������к���DMG���ļ�
rem �﷨��set "searchfilter=ֵ"
rem 
rem �������÷���[ȱʡ] ͬ"��"
rem 			[����] ͬ"����"
set "searchfilter="
rem ------------------------------------------
rem MKVmerge�������ȼ�/��������
rem ����������ⷽ���֪ʶ���벻Ҫ�����޸�
rem ��������(Ĭ��"zh_CN"(��������))
set "ui_language=zh_CN"
rem ���ȼ�(Ĭ��"normal"(��׼))
set "priority=normal"
rem ------------------------------------------
rem DEBUG_MODE
rem ����ģʽ�½���ر�����CLS������ECHO
rem ע��!�������ǿ�ƿ���NUL_OUTPUT!
rem [0] ����
rem [��0] ͣ��
set "debug_mode=1"
rem ------------------------------------------
rem NUL_OUTPUT
rem �ñ��������ڲ��ԣ��벻Ҫ���⿪����
rem NUL_OUTPUT����ʱ������MKVmerge�ѽ�������NUL(�����)
rem �Լӿ�����ٶȲ����ٴ���ʹ��
rem [0] ����
rem [��0] ͣ��
set "nul_output=1"
rem ------------------------------------------
rem EXEin
rem �ñ�����������ʱ���õ�MKVmerge��·��
rem
set "exein=mkvmerge"
rem ------------------------------------------
rem DIR_ORDER
rem �ñ�������DIR����Ƶ�ļ�������Ҳ������ƴ�Ϻ���Ƶ���Ⱥ�˳��
rem
rem ����˳��     N  ������(��ĸ˳��)     S  ����С(��С����)
rem              E  ����չ��(��ĸ˳��)   D  ������/ʱ��(���ȵ���)
rem              G  ��Ŀ¼����           -  ��ת˳���ǰ׺
rem
set "dir_order=N"
rem ------------------------------------------
rem append_mode
rem �ñ�������mkvmerge���ļ��ϲ�ʱ��ʱ�������ʽ
rem (�����ı�����mkvmerge Document)
rem 
rem �� mkvmerge ��������һ�ļ� (�����м���Ϊ '�ļ�2') ��һ����� (����Ϊ '���2_1' ) rem ׷�Ӻϲ����׸��ļ� (����Ϊ '�ļ�1')��һ����� (����Ϊ '���1_1') ʱ������Ϊ'���2_1' ������ʱ����趨һ��������ʱ��
rem ���� 'file���ļ���' ģʽ����ʱ���� '�ļ�1' �����������ʱ�������ʹ��ʱ��������ڹ�� '���1_1'��
rem ���� track �����ģʽ���´���ʱΪ '���1_1' �����ʱ�����
rem 
rem ���ҵ��� mkvmerge �޷����ʹ������ģʽ��Ϊ�ɿ���
rem 'file���ļ���' ģʽ�Ե����������ļ��Ĵ���ͨ�����ã�������׷�� AVI �� MP4 �ļ�ʱ��
rem 'track�������' ģʽ��һ�����ļ��������ֿ�Ĵ�����ã�������� VOB �� EVO �ļ��� 
rem
set "append_mode=file"
rem ------------------------------------------
rem DEBUGģ�飬�ڳ���������ֹʱ��������
:Module_DEBUG
if not defined debug (
	set debug=0
	cmd /c call "%~0" "%~1" "%~2%~3%~4%~5%~6%~7%~8%~9"
	if "%~1"=="" (
		echo [Module_DEBUG] �밴������˳�... 
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
rem ����
:get_input
rem EasyUse�����������
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
						echo [EasyUse Error] ���·����Ч
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
	echo [ERROR] ����·������
	goto Show_Help	
)
:not_check_input
rem ��ȡ������Ϣ
set "rf=%~dp0"
rem ��λ����������Ŀ¼����ֹ�Թ���Աģʽ�����������ξ���
cd /d "%rf%"
rem �������
if not "%debug_mode%"=="0" cls
title [LOAD] ���ڲ���mkvmerge������...
echo [LOAD] ���ڲ���mkvmerge�Ƿ����...
:check_mkvmerge
rem ����MKVmerge�Ƿ����
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
	echo [ERROR] EXEIN�����õ�·����Ч
	set "errorlevel=0"
) else goto no_check_again

call "mkvmerge" -V>nul 2>nul

if "%errorlevel%"=="0" (
	set "exein=mkvmerge"
	echo [CORRECT] EXEIN=mkvmerge
) else (
	echo [ERROR] �޷�ʹ��MKVmerge
	title [ERROR] AMtMKV can't use MKVmerge
	exit
)
:no_check_again
echo [LOAD] ���ڲ�������"%ui_language%"�Ƿ����...
for /f "skip=1 tokens=1 delims= " %%a in ('call "%exein%" --ui-language list') do (
	if "%ui_language%"=="%%~a" goto uil_check_ok
)
echo [ERROR] ����"%ui_language%"������
echo [CORRECT] �Ѹ���ΪĬ������"en"
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
rem ��ȡMKVmerge�İ汾��Ϣ�����ı���
echo [INF] AMtMKV V%ver% ^| Copyright(c) 2018-2019 yyfll
for /f "tokens=1-2* delims= " %%a in ('call "%exein%" -V') do (
	if "%debug_mode%"=="0" (
		title AppendMedia-to-MKV [USE:%%a %%b][GB2312][VER. %ver%^(DEBUG_MODE^)]
	) else title AppendMedia-to-MKV [USE:%%a %%b][GB2312][VER. %ver%]
	echo [USE] %%a %%b ^| Copyright^(c^) 2002-2019 Moritz Bunkus
)
rem ������������ֱ��ִ��
echo.
@if "%debug_mode%"=="0" echo off
call :show_custom_settings
@if "%debug_mode%"=="0" echo on
if defined ifolder goto check_path
:need_folder
rem ���û���ȡ·��
echo.
set "ifolder="
echo [DEV] ��Alpha�汾�н�֧��˫��Ŀ¼��������
echo [DEV] ����ļ��������"����Ŀ¼\����Ŀ¼"�²��ܱ�ʶ��
echo.
set /p ifolder=�ļ�(��Ŀ¼)·��(��������)��
rem ����û�û�����룬���ٴ����û���ȡ��������ڣ�����ȥ������
if not defined ifolder (
	if not "%debug_mode%"=="0" cls
	echo [ERROR] ��û�������κ�·����
	goto need_folder
)
if exist "%ifolder:~1,-1%" (
	set "ifolder=%ifolder:~1,-1%"
) else set "ifolder=%ifolder%"
rem pause
:check_path
rem ���·�������ڣ����ٴ����û���ȡ
if not exist "%ifolder%" (
	if not "%debug_mode%"=="0" cls
	echo [ERROR] ·����Ч��
	goto need_folder
)
echo.
:start_encode
if not "%debug_mode%"=="0" cls
rem ��ʼ������
set working=0
set error=0
set count=0
rem ȷ����Ŀ¼�����ļ�
set "dirin="
for %%a in ("%ifolder%") do (
	set "attribute=%%~aa"
)
if /i not %attribute:~0,1%==d (
	echo [ERROR] ���벻��Ϊ���ļ�
	goto :EOF
) else goto get_file_list
if defined attribute (
	echo [ERROR] ���벻��Ϊ���ļ�
	goto :EOF
)
:get_file_list
if not "%ifolder:~-1%"=="\" set "ifolder=%ifolder%\"
rem �����Ŀ¼��ִ����������
rem ɾ����ǰ���ڼ�¼�ļ��б��LOG����ֹ�ظ�д��
if exist "%APPDATA%\dirlist.log" del /q "%APPDATA%\dirlist.log"
title [yyfll��������������] ���������ļ��б�...�벻Ҫ�رձ�����...
echo [input.get_file_list] ������������������ļ��б�...
rem �����������������ļ�������·��ȫ��д�뵽filelist�ļ�
for /f "tokens=*" %%a in ('dir /A:D /B "%ifolder%"') do (
	set /a count=count+1
	echo "%ifolder%%%~a">>"%APPDATA%\dirlist.log"
)
goto INPUT_DIR_COUNT0
:check_path_length
set "path_length=%~1"
if not "%path_length:~259%"=="" echo [ERROR] �ļ�·������(260�ַ�����)
goto :EOF
:INPUT_DIR_COUNT0
rem ���count��¼���ļ���Ϊ0���򱨴�
if %count%==0 (
	echo [ERROR] ·��Ϊ��Ŀ¼��
	goto need_folder
)
rem ��ȡĿ��Ŀ¼�е������ļ�������εݽ��������·�����ơ�MKV��װ��ģ��
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
title [yyfll��������������] ������ɣ�
if not "%debug_mode%"=="0" cls
if not "%nul_output%"=="0" if defined outpath echo [OutPath] ������ɵ��ļ������"%outpath%"
if %error% GTR 0 (
	goto Has_Error
) else echo [������%count%����ȫ������ɹ�]
echo ������ɣ�
goto Batch_End
:Has_Error
echo [������%count%�������%error%��δ�ܳɹ�����]
if exist "%logdir%" CHOICE /C YN /M "�Ƿ�Ҫ�鿴LOG�ļ���"
if "%error%"=="1" (
	if exist "%logdir%" (
		start "%logdir%"
	) else echo �Ҳ���log�ļ���...
echo.
:Batch_End
rem ɾ������������ļ��б�
if exist "%APPDATA%\filelist.log" del /q "%APPDATA%\filelist.log"
rem ����ǲ��ǵ��������������
if "%~1"=="" pause
exit
:Module_EncapsulationMKV
rem ���������ģ��Ҫ��ִ�з�װ���������˳�
if defined notwork set "notwork=" && goto :EOF
set /a working=working+1
title [yyfll��������������] ���ڻ���"%filename%"...(��%working%��/��%count%��)
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
rem ��nul_outputΪ0ʱ������ѽ�������NUL���ڲ���ʱ��ռ�ô��̿ռ�
:run_mkvmerge
set "debug_file=%rf%DEBUG-%working%.log"
if "%nul_output%"=="0" (
	call "%exein%" -o NUL --ui-language "%ui_language%" --append-mode %append_mode% -v %mkvinput%
	if "%errorlevel%"=="2" (
		set /a error=error+1
		echo INPUT_FILE��"%vdir%">"%debug_file%"
		echo [DEBUG.mkvmerge] �����������в��ض���mkvmerge���...
		call "%exein%" -o NUL -v -r "%debug_file%" --ui-language "%ui_language%" --append-mode %append_mode% "%%~a"
	)
) else (
	call "%exein%" -o "%opath%" --ui-language "%ui_language%" --priority "%priority%" -v --title "Append-MKV_%ver%" %mkvinput%
	if not "%errorlevel%"=="0" (
		set /a error=error+1
		echo INPUT_FILE��"%vdir%">"%debug_file%"
		echo [DEBUG.mkvmerge] �����������в��ض���mkvmerge���...
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
	echo [ERROR] ������Ч
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
	echo [ERROR] ��û�������κ��ַ���
	goto RB.error_input
)
set "for_delims=%~2"
if "%for_delims%"=="" (
	echo [ERROR] ��û�������κ�Ҫ�滻���ַ���
	goto RB.error_input
)
setlocal enabledelayedexpansion
for /l %%a in (0,1,1) do set "delims[%%a]=!for_delims:~%%a!"
if defined delims[1] (
	echo [ERROR] Replace��������ǵ����ַ�
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
echo [ERROR] ������Ч
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
echo ��ʾ����ҳ��(��ҳ��)����ʹ������ָ��:
echo Call "%~dpnx0" -h
echo Call "%~dpnx0" -help
echo Call "%~dpnx0" /h
echo Call "%~dpnx0" /?
echo.
echo ���ÿ��أ�
echo   ?h                  	��ʾ����^(�������^)
echo   ?del [y/n]          	�Ƿ�ɾ�������ļ�
echo   ?sub [y/n]          	û����Ļʱ�Ƿ�Ƕ�������ļ�
echo   ^(ע�⣺sub�����ڿ���ʱ���Զ����������װ����notfontΪ����ֵ^)
echo   ?out [path]         	���Ŀ¼
echo   ?dir [y/n]          	�Ƿ�������Ŀ¼
echo   ?dbm [y/n]:[y/n]    	�Ƿ�ʹ�ò���ģʽ�Ϳ����^(����ģʽ����:���������^)
echo   ^(ע�⣺dbm������ֻ����һ��y��ͬʱ��������ģʽ�Ϳ��������֮��Ȼ^)
echo   ?ffl [filter]       	�ļ�������
echo   ?pri [0-4]  			ѡ��������ȼ�
echo   ?uil [1-4/input]   	ѡ��Mkvmerge������
echo   ?exe [path]			�Զ���MKVmerge��·��
echo. 
echo ����ע�⣺
echo   ���ر����������������𣬱���
echo   "?out %APPDATA%\test ?pri 3 ?dbm n:y"
echo   ��Ȼ��Ҳ����ʹ�þ����뷽ʽ(���ܳ���8������!)
echo   "?out %APPDATA%\test" "?pri 3" "?dbm n:y"
echo.	
echo ���÷�����^(CMD^)��
echo 	ASFMKV "����·��" "[���ÿ���]"
echo.
echo ���÷�����^(CMD^):
echo 	Call "(����ĳЩ���ŵ�·��)\ASFMKV" "����·��" "[���ÿ���]"
echo.	^(���·�����ļ����к������š��ո���Ż�����Ӱ��CMD�ķ��ţ�����ʹ��Callָ���˫��������·��^)
echo.
echo ���÷�����:
echo   ֱ����BAT�����ļ����ļ��У��Զ������ط�װ
echo.
echo �������ȼ���
echo   [0] lowest ^(���^)
echo   [1] lower^(�ϵ�^)
echo   [2] normal^(��׼^)
echo   [3] higher^(�ϸ�^)
echo   [4] highest ^(���/ʵʱ^)
echo.
echo MKVmerge������ԣ�
echo   [1] en^(English^)
echo   [2] zh_CN^(��������^)
echo   [3] zh_TW^(���w����^)
echo   [4] ja^(�ձ��Z^)
echo   ������ѡ���Ӧ����mkvmerge������֣�������֧��ʱʹ��
echo   ��Ҳ����ֱ���������ԣ����� "?uil zh_CN"
echo   ��ѡ���������"mkvmerge --ui-language list"
echo.
echo �ļ�������(δ������)��
echo   ����������ʹ�ñ�׼�ļ������﷨�����磺
echo   "*.mkv"��ֻ���������ļ���׺��ΪMKV���ļ�
echo   "*SEFO*.*"�������������ļ����к���"SEFO"���ļ�^(�����ִ�Сд^)�Ҳ��ܺ�׺����ʲô
echo   ��ʵ�������ʹ��ͨ������������
exit
:show_custom_settings
echo [CUSTOM SETTINGS]
echo [A/Active][N/Undefined][L/Unsupport]
if defined outpath (echo [OUT][A] �����Ŀ¼"%outpath%") else (echo [OUT][N] �����ԴĿ¼)
if "%debug_mode%"=="0" (echo [DBM][A] �����ò���ģʽ) else (echo [DBM][N] δʹ�ò���ģʽ)
if "%nul_output%"=="0" (echo [NUL][A] �����ÿ����) else (echo [NUL][N] �������)
rem if not defined searchfilter (
rem 	set "searchfilter=*"
rem 	set "filter=.*"
rem 	echo [FFL][N] δʹ���ļ�������
rem ) else echo [FFL][A] �Ѽ����ļ�������"%searchfilter%"
echo [FFL][L] �ݲ�֧���ļ�������
echo [PRI][A] ���ȼ�"%priority%"
echo [UIL][A] MKVmerge�������"%ui_language%"
if not "%exein%"=="mkvmerge" (
	echo [EXE][A] ʹ��"%exein%"
) else echo [EXE][N] ʹ��Ĭ�ϳ���
goto :EOF