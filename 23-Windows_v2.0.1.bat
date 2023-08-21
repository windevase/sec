pushd %~dp0
@echo off
color 3f
mode con lines=50 cols=100
set JOYSEC=C:\\JOYSEC
set script=C:\\JOYSEC\\script
FOR /F "tokens=1" %%a IN ('chdir') DO set chdir==%%a
if not %chdir% == %JOYSEC% goto End-1
FOR /F "tokens=1" %%a IN ('date /t') DO set day=%%a

@echo off
::bcdedit > nul || (echo. & echo. & echo �� ������ �������� ������ �ּ���!! & echo. & echo. & echo. & pause & exit)

REM :Q
TITLE 2023 Windows Security Check v1.6.8
@echo off

echo.                                                                           
@REM echo ####               ���� ������ �����ϰڽ��ϱ�(Y/N)                   ####  
echo.                                                                           

:: set/p "cho=�� Windows ���� ������ �����ϰڽ��ϱ�? (Y/N) : "
set cho=Y

if %cho%==Y goto start
if %cho%==y goto start
:: if %cho%==n goto end-2
:: if %cho%==N goto end-2
:: if %cho%==z goto end-3

:end-2
pause
EXIT

:start

@REM ������ ���� �ĺ�
%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProductName" > WinVer.log

type WinVer.log | findstr "Windows server 2003" 	> nul
IF NOT ERRORLEVEL 1 set WinVer=Win2003
type WinVer.log | findstr /c:"Windows 10" 	> nul
IF NOT ERRORLEVEL 1 set WinVer=Win10
type WinVer.log | findstr /c:"Windows Server 2008"	> nul
IF NOT ERRORLEVEL 1 set WinVer=Win2008
type WinVer.log | findstr /c:"Windows Server 2012"	> nul
IF NOT ERRORLEVEL 1 set WinVer=Win2012
type WinVer.log | findstr /c:"Windows Server 2012 R2"	> nul
IF NOT ERRORLEVEL 1 set WinVer=Win2012R2
type WinVer.log | findstr /c:"Windows Server 2016"	> nul
IF NOT ERRORLEVEL 1 set WinVer=Win2016
type WinVer.log | findstr /c:"Windows Server 2019"	> nul
IF NOT ERRORLEVEL 1 set WinVer=Win2019
type WinVer.log | findstr /c:"Windows Server 2022"	> nul
IF NOT ERRORLEVEL 1 set WinVer=Win2022


type WinVer.log | findstr "Windows server 2003"	> nul
IF NOT ERRORLEVEL 1 goto windows2003

del %JOYSEC%\WinVer.log	2>nul

bcdedit > nul || (echo. & echo. & echo �� ������ �������� ������ �ּ���!! & echo. & echo. & echo. & pause & exit)



:windows2003

del %JOYSEC%\WinVer.log	2>nul
::for /F "tokens=2 delims= " %%a in ('%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\CurrentVersion"') do (
::	set WinBuild1=%%a
::)
::for /F "tokens=2 delims= " %%a in ('echo %WinBuild1%') do (
::	set WinBuild=%%a
::)
::if "%WinBuild%" == "6.0" set WinVer=Win2008
::if "%WinBuild%" == "6.1" set WinVer=Win2008R2
::if "%WinBuild%" == "6.2" set WinVer=Win2012
::if "%WinBuild%" == "6.3" set WinVer=Win2012R2
::if "%WinBuild%" == "10." set WinVer=Win2016


@REM IIS ���� Ȯ��
for /F "tokens=3 delims= " %%a in ('%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp\VersionString"') do (
	set IISV=%%a
)

::echo IIS Version %IISV%

echo.                                                                                       > result.log
echo Copyright(c) JOYCITY Co. Ltd. All right Reserved                                      >> result.log
echo ##################################################################################### >> result.log
echo ####                Windows Server Security Check                                #### >> result.log
echo ####                                                                             #### >> result.log
echo ##################################################################################### >> result.log
echo �� �� ��ũ��Ʈ�� '����'�� ���� ������ ���Ȱ��̵���� �������� ����� �����Դϴ�.               >> result.log
echo    �����׸񺰷� ��ü���� ���� ���ذ� ��ġ����� '���Ȱ��̵����' ������ �����Ͻñ� �ٶ��ϴ�.   >> result.log
echo �� Ư���� �����̳� ���ǵǾ� ���� ���� ���Ͽ� ���ؼ��� ��Ž�� ���� �� ������,                   >> result.log
echo    ��Ȯ�� ������ ���ؼ��� ���� ���� ��Ȳ�� ���Ȱ��̵���� ������ �������� �Ǵ��Ͻñ� �ٶ��ϴ�. >> result.log
echo ##################################################################################### >> result.log
echo  Script File    : 23-Windows_v2.0.1.bat                                                >> result.log
echo  OS Version     : %WinVer%                                        					 >> result.log
echo  Launching Time : %DATE% %TIME%                                                       >> result.log
echo  Hostname       : %COMPUTERNAME%                                                      >> result.log
::echo  IP address     :                                                                     >> result.log
ipconfig | find "IPv4"                                                                     >> result.log
echo ##################################################################################### >> result.log
wmic os get name | findstr Microsoft > OSVersion
for /f "tokens=1 delims=|" %%a in ('type OSVersion') Do set OSVersion=%%a
for /F "tokens=1-8" %%a in ('%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\BuildLab"') Do set BuildLab=%%c %%d %%e %%f %%g %%h
for /F "tokens=1-8" %%a in ('%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\BuildLabEx"') Do set BuildLabEx=%%c %%d %%e %%f %%g %%h
echo  OS Version     : %OSVersion%				                                           >> result.log
echo  BuildLab     : %BuildLab%  %BuildLabEx%                                              >> result.log
echo ##################################################################################### >> result.log
echo.                                                                                      >> result.log
echo.                                                                                      >> result.log
DEL OSVersion





@REM ����� �׸񸮽�Ʈ�� ��Ÿ���������� ���ϻ���
echo ##################################################################################### >> result.log
echo ################################## ��� �׸� ����Ʈ ################################# >> result.log
echo ##################################################################################### >> result.log

                                                                 
@REM N/A �׸񸮽�Ʈ�� ��Ÿ���������� ���ϻ���
echo.                                                                                       > not-apply.log
echo.                                                                                      >> not-apply.log   

echo ##################################################################################### >> not-apply.log
echo ################################### N/A �׸� ����Ʈ ################################# >> not-apply.log
echo ##################################################################################### >> not-apply.log
                                                       


@REM ���, N/A �׸񳻿��� ��Ÿ�������� ���ϻ���
::echo.                                                                                       > %COMPUTERNAME%-list.log
::echo.                                                                                      >> %COMPUTERNAME%-list.log
::echo ##################################################################################### >> %COMPUTERNAME%-list.log
::echo ######################## ��� �� N/A �׸� ���� �� ���ܰ�� ###################### >> %COMPUTERNAME%-list.log
::echo ##################################################################################### >> %COMPUTERNAME%-list.log
::echo.                                                                                      >> %COMPUTERNAME%-list.log                                                          
::echo.                                                                                       > %COMPUTERNAME%-test.log
::echo.                                                                                      >> %COMPUTERNAME%-test.log

echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo ##################################################################################### >> %COMPUTERNAME%-test.log
echo ######################### ��ü �׸� ����  �� ���ܰ�� ########################### >> %COMPUTERNAME%-test.log
echo ##################################################################################### >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo �� Start Time                                                                         >> %COMPUTERNAME%-test.log
date /t                                                                                    >> %COMPUTERNAME%-test.log
time /t                                                                                    >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log     


echo ##################################################################################### >> %COMPUTERNAME%-test.log
echo ###############################  Interface Information  ############################# >> %COMPUTERNAME%-test.log
echo ##################################################################################### >> %COMPUTERNAME%-test.log
ipconfig /all                                                                              >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log

echo ##################################################################################### >> %COMPUTERNAME%-test.log
echo #################################  Port Information  ################################ >> %COMPUTERNAME%-test.log
echo ##################################################################################### >> %COMPUTERNAME%-test.log
netstat -an                                                                                >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log

echo ##################################################################################### >> %COMPUTERNAME%-test.log
echo ############################  Service Daemon Information  ########################### >> %COMPUTERNAME%-test.log
echo ##################################################################################### >> %COMPUTERNAME%-test.log
net start | findstr /I /v "����� completed"                                               >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log


echo �� ��ü ���� ���                                                                     >> %COMPUTERNAME%-test.log
echo �� ��ü ���� ����   
echo ### 1.1 ���� ���� ��� ����   #############################################################  
echo #####################################################################################  > %COMPUTERNAME%-1-1.log
echo ### 1.1 ���� ���� ��� ����   ############################################################## >> %COMPUTERNAME%-1-1.log
echo ##################################################################################### >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo START                                                                                      >> %COMPUTERNAME%-1-1.log
echo �� ����1 : ������ ������ Administrator �������� �����Ͽ� ���.                         >> %COMPUTERNAME%-1-1.log
echo �� ����2 : Guest ������ ��Ȱ��ȭ                                                       >> %COMPUTERNAME%-1-1.log
echo �� ����3 : ���ʿ��� ������ ����. ����ϴ� ������ [����] �κп� ���뵵 ����           >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo �� ������ ���� Administrator ������ ��Ȳ                                              >> %COMPUTERNAME%-1-1.log
net localgroup Administrators | findstr /I /v "����� completed"                       	   >> %COMPUTERNAME%-1-1.log
echo - Administrator ���� ��Ȳ                                                             >> %COMPUTERNAME%-1-1.log
net user Administrator  > nul
IF NOT ERRORLEVEL 1 net user Administrator | findstr /I "Ȱ�� active"                                  >> %COMPUTERNAME%-1-1.log
net user Administrator | findstr /I "Ȱ�� active" | findstr /I "�� Yes" > nul
IF NOT ERRORLEVEL 1 ECHO bad								   >> 1-1-result.log
net user Administrator | findstr /I "Ȱ�� active" | findstr /I "���" > nul
IF NOT ERRORLEVEL 1 ECHO bad								   >> 1-1-result.log

echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo �� Guest ���� ��Ȳ                                                                    >> %COMPUTERNAME%-1-1.log
net user Guest | findstr /I "Ȱ�� active"                                        >> %COMPUTERNAME%-1-1.log
net user Guest | findstr /I "Ȱ�� active" | findstr /I "�� Yes" > nul
IF NOT ERRORLEVEL 1 ECHO bad								   >> 1-1-result.log
net user Guest | findstr /I "Ȱ�� active" | find "���" > nul
IF NOT ERRORLEVEL 1 ECHO bad								   >> 1-1-result.log

echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
::echo �� ���ʿ��� ���� Ȯ�� �ʿ�                                                            >> %COMPUTERNAME%-1-1.log
::net user | findstr /I /v "���� accounts" | find /v "----" | findstr /I /v "����� completed"                                >> 1-1-userlist.log
::FOR /F "TOKENS=1" %%i IN ('type 1-1-userlist.log') DO ECHO %%i | find /v "Administrator" | find /v "Guest"           	  >> 1-1-accounts.log
::FOR /F "TOKENS=2" %%i IN ('type 1-1-userlist.log') DO ECHO %%i | find /v "Administrator" | find /v "Guest"           	  >> 1-1-accounts.log
::FOR /F "TOKENS=3" %%i IN ('type 1-1-userlist.log') DO ECHO %%i | find /v "Administrator" | find /v "Guest"           	  >> 1-1-accounts.log


::dir 1-1-accounts.log | find " 0 ����Ʈ" > nul
::IF NOT ERRORLEVEL 1 goto 1-1-check
::dir 1-1-accounts.log | find " 0 bytes" > nul
::IF NOT ERRORLEVEL 1 goto 1-1-check

::FOR /F "TOKENS=1" %%i IN ('type 1-1-accounts.log') DO (
::net user %%i | findstr /I "Ȱ�� active" | findstr /I " �� Yes" > nul
::IF NOT ERRORLEVEL 1 echo %%i >> 1-1-explain.log
::)

::FOR /F "USEBACKQ DELIMS=" %%i IN ("1-1-explain.log") DO (
::net user %%i | findstr /I "�̸� Ȱ�� ���� name active comment"	| find /I /V "����� ����" | find /I /V "��ü �̸�" 	  		>> %COMPUTERNAME%-1-1.log
::echo. >> %COMPUTERNAME%-1-1.log
::)
::FOR /F "USEBACKQ DELIMS=" %%i IN ("1-1-accounts.log") DO net user %%i | findstr /I "Ȱ�� active"     >> 1-1-Activation.log
::
::type 1-1-Activation.log | find /c "��"								    > 1-1-Yesnum.log
::FOR /F "USEBACKQ DELIMS=" %%i IN ("1-1-Yesnum.log") DO set compare_val=%%i
::IF %compare_val% GTR 1 ECHO bad 								>> 1-1-result.log
::type 1-1-Activation.log | find /c "Yes"								    > 1-1-Yesnum.log
::FOR /F "USEBACKQ DELIMS=" %%i IN ("1-1-Yesnum.log") DO set compare_val=%%i
::IF %compare_val% GTR 1 ECHO bad 								>> 1-1-result.log

::echo ����                               >> 1-1-comp.log
::FOR /F "TOKENS=1" %%i IN ('type 1-1-explain.log') DO (
::net user %%i | findstr /I "���� explain" | findstr /I /v "����� user" > 1-1-explain2.log
::echo n | comp 1-1-comp.log 1-1-explain2.log 2>nul | findstr /I "�����ϴ� SAME" > NUL
::IF NOT ERRORLEVEL 1 ECHO bad >> 1-1-result.log
::)

:1-1-check
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
type 1-1-result.log | find "bad" > nul
IF NOT ERRORLEVEL 1 goto 1-1-bad
echo �� ������ ������ Administrator �������� �����ϰ�, GUEST ���� ��Ȱ��ȭ, ���ʿ��� ���� ���� �ǰ� >> %COMPUTERNAME%-1-1.log
echo. >> %COMPUTERNAME%-1-1.log
echo @ ��ȣ - 1.1 ���� ���� ��� ����  		                                   >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
type %COMPUTERNAME%-1-1.log                                                                >> %COMPUTERNAME%-test.log
GOTO 1-2

:1-1-bad
echo. >> %COMPUTERNAME%-1-1.log
echo �� ������ ������ Administrator �������� �����ϰ�, GUEST ���� ��Ȱ��ȭ, ���ʿ��� ���� ���� �ǰ� >> %COMPUTERNAME%-1-1.log
echo. >> %COMPUTERNAME%-1-1.log
echo @ ��� - 1.1 ���� ���� ��� ����  >> %COMPUTERNAME%-1-1.log | echo @ ��� - 1.1 ���� ���� ��� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
type %COMPUTERNAME%-1-1.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-1-1.log                                                                >> %COMPUTERNAME%-test.log




:1-2
echo ### 1.2 ���� ��� ��å ����  ##############################################################
echo END##################################################################################  > %COMPUTERNAME%-1-2.log
echo ### 1.2 ���� ��� ��å ����  ############################################################### >> %COMPUTERNAME%-1-2.log
echo ##################################################################################### >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo START                                                                                      >> %COMPUTERNAME%-1-2.log
echo �� ���� : ���� ��� �Ⱓ�� '10�� �̻�', ���� ��ݼ��� ������� ������ '10�� �̻�' ���� ���       >> %COMPUTERNAME%-1-2.log
echo          �Ӱ谪 '10�� ����'�� �����Ǿ� �ְų� AMS(���������ý���)�� �����Ǿ� ������ ��ȣ  		  >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo �� ��Ȳ                                                                               >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log 
net start | find "OmniWorker" > NUL
IF ERRORLEVEL 1 GOTO AMS-DISABLE
IF NOT ERRORLEVEL 1 GOTO AMS-ACTIVE



:AMS-ACTIVE
echo �� AMS(���������ý���)�� �����Ǿ� �ֽ��ϴ�.                                           >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo @ ��ȣ - 1.2 ���� ��� ��å ����                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
type %COMPUTERNAME%-1-2.log                                                                >> %COMPUTERNAME%-test.log  
GOTO 1-3

:AMS-DISABLE
secedit /EXPORT /CFG Local_Security_Policy.txt 	 > NUL					   					 
type Local_Security_Policy.txt | findstr /I "LockoutDuration LockoutBadCount ResetLockoutCount"                    > 1-2-PASSWORD_POL.log
echo �� ������ ���� ��� ��å															                           >> %COMPUTERNAME%-1-2.log
echo.                                                                                                              >> %COMPUTERNAME%-1-2.log
echo [���� ��� �Ⱓ - 10��(�̻�)]														                                       >> %COMPUTERNAME%-1-2.log
type Local_Security_Policy.txt | findstr /I "LockoutDuration"    		                                           >> %COMPUTERNAME%-1-2.log
IF ERRORLEVEL 1 ECHO '���� ��� �Ⱓ ����' ����											                           >> %COMPUTERNAME%-1-2.log
echo.                                                                                                              >> %COMPUTERNAME%-1-2.log 
echo [���� ��� �Ӱ谪 - 10��(����)]													                                           >> %COMPUTERNAME%-1-2.log
type Local_Security_Policy.txt | findstr /I "LockoutBadCount"    		                                           >> %COMPUTERNAME%-1-2.log
echo.                                                                                                              >> %COMPUTERNAME%-1-2.log 
echo [���� ��� �Ⱓ ������� ���� - 10��(�̻�]													                               >> %COMPUTERNAME%-1-2.log
type Local_Security_Policy.txt | findstr /I "ResetLockoutCount"    		                                           >> %COMPUTERNAME%-1-2.log
IF ERRORLEVEL 1 ECHO '���� ��� �Ⱓ ������� ����' ����									                       >> %COMPUTERNAME%-1-2.log
echo.                                                                                                              >> %COMPUTERNAME%-1-2.log 

type Local_Security_Policy.txt | findstr /I "LockoutDuration"                       > 1-2-PASSWORD_POL.log
IF ERRORLEVEL 1 goto 1-2-1
for /f "tokens=3" %%a in ('type 1-2-PASSWORD_POL.log') DO set compare_val=%%a
IF NOT %compare_val% GEQ 10 goto 1-2-bad

:1-2-1
type Local_Security_Policy.txt | findstr /I "LockoutBadCount"                       > 1-2-PASSWORD_POL.log
IF ERRORLEVEL 1 goto 1-2-2
for /f "tokens=3" %%a in ('type 1-2-PASSWORD_POL.log') DO set compare_val=%%a
IF NOT %compare_val% LEQ 10 goto 1-2-bad

:1-2-2
type Local_Security_Policy.txt | findstr /I "ResetLockoutCount"                       > 1-2-PASSWORD_POL.log
IF ERRORLEVEL 1 goto 1-2-3
for /f "tokens=3" %%a in ('type 1-2-PASSWORD_POL.log') DO set compare_val=%%a
IF NOT %compare_val% GEQ 10 goto 1-2-bad

echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo �� ���� ��� �Ⱓ '10�� �̻�', ���� ��� �Ӱ谪 '10�� ����', ���� ��� �Ⱓ ������� ���� '10�� �̻�'���� ���� �ǰ�  >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo @ ��ȣ - 1.2 ���� ��� ��å ����                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
type %COMPUTERNAME%-1-2.log                                                                >> %COMPUTERNAME%-test.log
GOTO 1-3

:1-2-3
:1-2-bad
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo �� ���� ��� �Ⱓ '10�� �̻�', ���� ��� �Ӱ谪 '10�� ����', ���� ��� �Ⱓ ������� ���� '10�� �̻�'���� ���� �ǰ�  >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo @ ��� - 1.2 ���� ��� ��å ����  >> %COMPUTERNAME%-1-2.log | echo @ ��� - 1.2 ���� ��� ��å ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
type %COMPUTERNAME%-1-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-1-2.log                                                                >> %COMPUTERNAME%-test.log





:1-3
echo ### 1.3 ��ȣ ��å ����  #################################################################
echo END#################################################################################  > %COMPUTERNAME%-1-3.log
echo ### 1.3 ��ȣ ��å ����  ################################################################## >> %COMPUTERNAME%-1-3.log
echo #################################################################################### >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo START                                                                                  >> %COMPUTERNAME%-1-3.log
echo �� ���� : �ִ� ��ȣ ��� �Ⱓ '90�� ����' AND ��ȣ�� ���⼺�� �����ؾ� �� '���' >> %COMPUTERNAME%-1-3.log
echo           AND �ּ� ��ȣ ���� '9���� �̻�' AND �ֱ� ��ȣ ��� '12��' AND  >> %COMPUTERNAME%-1-3.log
echo         �ص� ������ ��ȣȭ�� ����Ͽ� ��ȣ���� '������'�� �����Ǿ� ������ ��ȣ      >> %COMPUTERNAME%-1-3.log
::echo �� ����2: ������ �н����� ����. 3���� �̻��� �������� 8�� �̻��� �н������ �����ؾ� ��      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo �� ��Ȳ                                                                               >> %COMPUTERNAME%-1-3.log
echo.                                                                 						 >> %COMPUTERNAME%-1-3.log 
net start | find "OmniWorker" > NUL
IF ERRORLEVEL 1 GOTO AMS-DISABLE
IF NOT ERRORLEVEL 1 GOTO AMS-ACTIVE

:AMS-ACTIVE
echo �� AMS(���������ý���)�� �����Ǿ� �ֽ��ϴ�.                                           >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo @ ��ȣ - 1.3 ��ȣ ��å ����                                                           >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
type %COMPUTERNAME%-1-3.log                                                                >> %COMPUTERNAME%-test.log  
goto 2-1

:AMS-DISABLE
type Local_Security_Policy.txt | findstr /I "PasswordComplexity PasswordHistorySize MaximumPasswordAge MinimumPasswordLength MinimumPasswordAge ClearTextPassword"                              > 1-3-PASSWORD_POL.log
echo �� ������ ��ȣ��å  															   >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
echo [��ȣ ���⼺�� �����ؾ� �� - 1(���)]  													   >> %COMPUTERNAME%-1-3.log
type Local_Security_Policy.txt | findstr /I "PasswordComplexity"		               >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
echo [�ֱ� ��ȣ ��� - 4]														           >> %COMPUTERNAME%-1-3.log
type Local_Security_Policy.txt | findstr /I "PasswordHistorySize"		               >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
echo [�ִ� ��ȣ ��� �Ⱓ - 90��(����)]													           >> %COMPUTERNAME%-1-3.log
type Local_Security_Policy.txt | findstr /I "MaximumPasswordAge" | findstr /I /v "Services"	               >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
echo [�ּ� ��ȣ ���� - 9����(�̻�)]													   			   >> %COMPUTERNAME%-1-3.log
type Local_Security_Policy.txt | findstr /I "MinimumPasswordLength"		   			   >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
::echo [�ּ� ��ȣ ��� �ð� - 1��(�̻�)]												   			   >> %COMPUTERNAME%-1-3.log
::type Local_Security_Policy.txt | findstr /I "MinimumPasswordAge"		   			   >> %COMPUTERNAME%-1-3.log
::echo.                                                                                  >> %COMPUTERNAME%-1-3.log
echo [�ص� ������ ��ȣȭ�� ����Ͽ� ��ȣ ���� - 0(������)]										   >> %COMPUTERNAME%-1-3.log
type Local_Security_Policy.txt | findstr /I "ClearTextPassword"		   				   >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
::echo �� �ý��� ��¥ ����    			                       							>> %COMPUTERNAME%-1-3.log
::echo.                                                                                       >> %COMPUTERNAME%-1-3.log 
::echo %date% 																				>> %COMPUTERNAME%-1-3.log
::for /f %%d in ('cscript //nologo %script%\OldDateCode.vbs') do set cu_date=%%d
::echo.                                                                                       >> %COMPUTERNAME%-1-3.log 
::echo �� ������ �н����� ������ Ȯ��          	 												>> %COMPUTERNAME%-1-3.log
::echo.                                                                                       >> %COMPUTERNAME%-1-3.log 
::net user | findstr /I /v "���� accounts" | find /v "----" | findstr /I /v "����� completed"                                >> 1-3-pch.log
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch.log') DO ECHO %%i            	  >> 1-3-pch1.log
::FOR /F "TOKENS=2" %%i IN ('type 1-3-pch.log') DO ECHO %%i            	  >> 1-3-pch1.log
::FOR /F "TOKENS=3" %%i IN ('type 1-3-pch.log') DO ECHO %%i            	  >> 1-3-pch1.log
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch1.log') do (
::net user %%i | findstr /I "Ȱ�� active" | findstr /I "�� Yes" > nul
::IF NOT ERRORLEVEL 1 echo %%i >> 1-3-pch2.log
::)
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch2.log') DO net user %%i | findstr /I "%%i ������ last" | findstr /V /I "��ü �̸�" | findstr /V /I "���� �׷� ������"		        >> %COMPUTERNAME%-1-3.log
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch2.log') DO net user %%i | findstr /I "%%i ������ last" | findstr /V /I "��ü �̸�" | findstr /V /I "���� �׷� ������ ����� �̸�" 	>> 1-3-pch3.log
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch2.log') DO net user %%i | findstr /I "%%i ������ set" | findstr /V /I "��ü �̸�" | findstr /V /I "���� �׷� ������"		        >> %COMPUTERNAME%-1-3.log
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch2.log') DO net user %%i | findstr /I "%%i ������ set" | findstr /V /I "��ü �̸�" | findstr /V /I "���� �׷� ������ ����� �̸�"	>> 1-3-pch3.log


::chcp | findstr /I "949" > nul
::IF NOT ERRORLEVEL 1 goto kkk

::FOR /F "TOKENS=4" %%i IN ('type 1-3-pch3.log') DO echo %%i >> 1-3-pch4.log
::goto kkee

:::kkk
::FOR /F "TOKENS=5" %%i IN ('type 1-3-pch3.log') DO echo %%i >> 1-3-pch4.log

:::kkee
::setlocal
::for /f "tokens=1" %%i in ('type 1-3-pch4.log') do (
::call :a "%%i"
::)
::set aa=%a1%
::set ab=%a2%
::set ac=%a3%
::set ad=%a4%
::set ae=%a5%
::set af=%a6%
::set ag=%a7%
::set ah=%a8%
::set ai=%a9%
::set aj=%a10%
::set aa=%aa:-?=%
::set ab=%ab:-?=%
::set ac=%ac:-?=%
::set ad=%ad:-?=%
::set ae=%ae:-?=%
::set af=%af:-?=% 
::set ag=%ag:-?=%
::set ah=%ah:-?=%
::set ai=%ai:-?=%
::set aj=%aj:-?=%
::echo %aa% >> pw2.log
::echo %ab% >> pw2.log
::echo %ac% >> pw2.log
::echo %ad% >> pw2.log
::echo %ae% >> pw2.log
::echo %af% >> pw2.log
::echo %ag% >> pw2.log
::echo %ah% >> pw2.log
::echo %ai% >> pw2.log
::echo %aj% >> pw2.log

::goto :end
:::a
::set /a z_sum+=1
::set "a%z_sum%=%~1"
::goto :eof
:::end
::endlocal

::FOR /F "TOKENS=1" %%i IN ('type pw2.log') DO ECHO %%i | find /v "-=" >> pw3.log
::FOR /F "TOKENS=1" %%i IN ('type pw3.log') DO (
::echo %cu_date% >> pw4.log
::echo %%i >> pw4.log
::if %cu_date% GTR %%i goto limit
::rem if not %cu_date% LSS %%i goto pwpol_check
::)
::goto pwpol_check

:::limit
::echo �� �н����� ��������� 90���� �ʰ��Ͽ����ϴ� >> %COMPUTERNAME%-1-3.log
::set passwdbad=0



:pwpol_check
type Local_Security_Policy.txt | findstr /I "PasswordComplexity"                       > 1-3-PASSWORD_POL.log
IF ERRORLEVEL 1 GOTO 1-31
for /f "tokens=3" %%a in ('type 1-3-PASSWORD_POL.log') DO set compare_val=%%a
IF NOT %compare_val% EQU 1 goto 1-3-bad

:1-31
type Local_Security_Policy.txt | findstr /I "PasswordHistorySize"                       > 1-3-PASSWORD_POL.log
IF ERRORLEVEL 1 GOTO 1-32
for /f "tokens=3" %%a in ('type 1-3-PASSWORD_POL.log') DO set compare_val=%%a
IF NOT %compare_val% GEQ 4 goto 1-3-bad

:1-32
type Local_Security_Policy.txt | findstr /I "MaximumPasswordAge"                       > 1-3-PASSWORD_POL.log
IF ERRORLEVEL 1 GOTO 1-33
for /f "tokens=3" %%a in ('type 1-3-PASSWORD_POL.log') DO set compare_val=%%a
IF NOT %compare_val% LEQ 90 goto 1-3-bad

:1-33
type Local_Security_Policy.txt | findstr /I "MinimumPasswordLength"                       > 1-3-PASSWORD_POL.log
IF ERRORLEVEL 1 GOTO 1-35
for /f "tokens=3" %%a in ('type 1-3-PASSWORD_POL.log') DO set compare_val=%%a
IF NOT %compare_val% GEQ 9 goto 1-3-bad

:::1-34
::type Local_Security_Policy.txt | findstr /I "MinimumPasswordAge"                       > 1-3-PASSWORD_POL.log
::IF ERRORLEVEL 1 GOTO 1-35
::for /f "tokens=3" %%a in ('type 1-3-PASSWORD_POL.log') DO set compare_val=%%a
::IF NOT %compare_val% GEQ 1 goto 1-3-bad

:1-35
type Local_Security_Policy.txt | findstr /I "ClearTextPassword"                       > 1-3-PASSWORD_POL.log
IF ERRORLEVEL 1 GOTO 1-36
for /f "tokens=3" %%a in ('type 1-3-PASSWORD_POL.log') DO set compare_val=%%a
IF NOT %compare_val% EQU 0 goto 1-3-bad

:1-36
echo %passwdbad% | findstr "0" > nul
IF ERRORLEVEL 1 goto 1-3-1
IF %passwdbad% EQU 0 goto 1-3-bad

:1-3-1
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo �� ��ȣ��å ���� �� 3���� �̻��� �������� 9�� �̻� ��� �ǰ�                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo @ ��ȣ - 1.3 ��ȣ ��å ����                                                          >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
type %COMPUTERNAME%-1-3.log                                                                >> %COMPUTERNAME%-test.log
goto 2-2


:1-3-bad
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo �� ��ȣ��å ���� �� 3���� �̻��� �������� 9�� �̻� ��� �ǰ�                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
ECHO @ ��� - 1.3 ��ȣ ��å ���� >> %COMPUTERNAME%-1-3.log | echo @ ��� - 1.3 ��ȣ ��å ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
type %COMPUTERNAME%-1-3.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-1-3.log                                                                >> %COMPUTERNAME%-test.log
goto 2-2


:2-2
echo ### 2.1 ����� Ȩ ���͸� ��������  #########################################################
echo END##################################################################################  > %COMPUTERNAME%-2-2.log
echo ### 2.1 ����� Ȩ ���͸� ��������  ########################################################## >> %COMPUTERNAME%-2-2.log
echo ##################################################################################### >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo START                                                                                 >> %COMPUTERNAME%-2-2.log
echo �� ���� : Ȩ���͸� ������ Users:F �Ǵ� Everyone:F �� ������ ��ȣ                     >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
cacls "c:\users\*"               		                                   				   >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
cacls "c:\users\*"                          	                                           > 2-2-user-access.log

type 2-2-user-access.log | find  "\Users:(OI)(CI)F" > nul
IF ERRORLEVEL 1 goto no-user-F 
IF NOT ERRORLEVEL 1 goto yes-user-F
echo.                                                                                      >> %COMPUTERNAME%-2-2.log

:no-user-F
type 2-2-user-access.log | find  "Everyone:(OI)(CI)F" >nul
IF NOT ERRORLEVEL 1 goto no-user-yes-everyone-F
IF ERRORLEVEL 1 echo �� User:F �Ǵ� Everyone:F �� �������� �ʽ��ϴ�						   >> %COMPUTERNAME%-2-2.log 
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo �� Ȩ���丮 ������ Users:F �Ǵ� Everyone:F  ���� ���� �ǰ�  >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo @ ��ȣ - 2.1 ����� Ȩ ���͸� ��������				                               >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-test.log
goto 2-3

:yes-user-F
type 2-2-user-access.log | find  "Everyone:(OI)(CI)F" >nul
IF ERRORLEVEL 1 goto yes-user-no-everyone-F
IF NOT ERRORLEVEL 1 goto yes-user-yes-everyone-F

:yes-user-no-everyone-F
echo �� Users:(OI)(CI)F �� �����մϴ�. ���ʿ��� ��� �����Ͻñ� �ٶ��ϴ�.                  >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo. 																					   >> %COMPUTERNAME%-2-2.log
echo �� Ȩ���丮 ������ Users:F �Ǵ� Everyone:F  ���� ���� �ǰ�  						>> %COMPUTERNAME%-2-2.log
echo. >> %COMPUTERNAME%-2-2.log
echo @ ��� - 2.1 ����� Ȩ ���͸� �������� >> %COMPUTERNAME%-2-2.log | echo @ ��� - 2.1 ����� Ȩ ���͸� �������� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log


type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-test.log
goto 2-3

:no-user-yes-everyone-F
echo �� Everyone:(OI)(CI)F �� �����մϴ�. ���ʿ��� ��� �����Ͻñ� �ٶ��ϴ�.               >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo. >> %COMPUTERNAME%-2-2.log
echo �� Ȩ���丮 ������ Users:F �Ǵ� Everyone:F  ���� ���� �ǰ�  >> %COMPUTERNAME%-2-2.log
echo. >> %COMPUTERNAME%-2-2.log
echo @ ��� - 2.1 ����� Ȩ ���͸� �������� >> %COMPUTERNAME%-2-2.log | echo @ ��� - 2.1 ����� Ȩ ���͸� �������� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log


type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-test.log
goto 2-3

:yes-user-yes-everyone-F
echo �� Users:(OI)(CI)F �� Everyone:(OI)(CI)F �� �����մϴ�. ���ʿ��� ��� �����Ͻñ� �ٶ��ϴ�. >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo. >> %COMPUTERNAME%-2-2.log
echo �� Ȩ���丮 ������ Users:F �Ǵ� Everyone:F  ���� ���� �ǰ�  >> %COMPUTERNAME%-2-2.log
echo. >> %COMPUTERNAME%-2-2.log
echo @ ��� - 2.1 ����� Ȩ ���͸� �������� >> %COMPUTERNAME%-2-2.log | echo @ ��� - 2.1 ����� Ȩ ���͸� �������� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log


type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-test.log
goto 2-3





:2-3
echo ### 2.2 ���� ���� ����  #################################################################
echo END##################################################################################  > %COMPUTERNAME%-2-3.log
echo ### 2.2 ���� ���� ����  ################################################################### >> %COMPUTERNAME%-2-3.log
echo ##################################################################################### >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo START                                                                                 >> %COMPUTERNAME%-2-3.log
echo �� ����1 : C$, D$, Admin$ (IPC$ ����)���� �⺻ �������� ���� �� AutoShareServer ������Ʈ������ 0���� ���� >> %COMPUTERNAME%-2-3.log
echo �� ����2 : ���� ���� ��� �� ���� ���� ���� ���ѿ� Everyone ���� �� ��ȣ�� ��ȣ�� ���� ����               >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo [ �������� ��Ȳ ]                                                                     >> %COMPUTERNAME%-2-3.log
net share | find /V "IPC$" | findstr /I /v "����� completed"                     		   >> %COMPUTERNAME%-2-3.log
::echo.                                                                                      >> %COMPUTERNAME%-2-3.log
::echo �� OS ���� ��Ȳ                                                                       >> %COMPUTERNAME%-2-3.log
::%script%\psinfo | find "Product type"	  				                                   >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo 1) AutoShareServer ������Ʈ�� ������                                                  >> %COMPUTERNAME%-2-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareServer" >> %COMPUTERNAME%-2-3.log
IF ERRORLEVEL 1 ECHO AutoShareServer ������Ʈ�� ���� ��ϵǾ� ���� �ʽ��ϴ�.(AutoShareServer ���� �ʿ�)	   >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo 2) ������� �������� ���ٱ��� ��Ȳ                                                                 >> %COMPUTERNAME%-2-3.log
::echo.                                                                                      >> %COMPUTERNAME%-2-3.log
::net share | find /V "IPC$" | findstr /I /v "����� completed" | findstr /I "�⺻ ���� Default Remote"		>> %COMPUTERNAME%-2-3.log
::net share | find /V "IPC$" | findstr /I /v "����� completed" | find /v "The command completed successfully"                         > 2-3-netsharelist.log
echo > 2-2-result.log
net share | find /V "IPC$" | findstr /I /v "����� completed" | findstr /I "�⺻ ���� Default Remote" > NUL	
IF NOT ERRORLEVEL 1 echo 2-3-1-bad  >> 2-2-result.log

echo > 2-3-netsharelist.log
net share | find /V "IPC$" | findstr /I /v "����� completed" | findstr /I /v "�⺻ ���� Default Remote"		>> 2-3-netsharelist.log
FOR /F "tokens=2 skip=4" %%j IN ('type 2-3-netsharelist.log') DO cacls %%j        		   >> folderper.log 2>&1
::net share | findstr /I /v /R ^[a-z][\\][a-z] | find /V "IPC$" | findstr /I /v "����� completed" | find /v "The command completed successfully"	> 2-3-netsharelist.log
::FOR /F "tokens=2 skip=4" %%j IN ('type 2-3-netsharelist.log') DO cacls %%j        		   >> folderper.log 2>&1
type folderper.log 																		   >> %COMPUTERNAME%-2-3.log	
::echo.                                                                                      >> %COMPUTERNAME%-2-3.log
::FOR /F "tokens=1,2,3 skip=4" %%a IN ('net share') DO echo %%a %%b %%c             		   >> 2-3-harddirsk-netshare.log
::TYPE 2-3-harddirsk-netshare.log | find /V "IPC$" | findstr /I /v "�⺻ ���� Default Remote ����� completed" > NUL	
::TYPE 2-3-harddirsk-netshare.log | findstr /I /v /R ^[a-z][\\][a-z] | find /V "IPC$" | findstr /I /v "����� completed" > NUL	
::IF NOT ERRORLEVEL 1 echo 2-3-2-bad  >> 2-2-result.log

echo > 2-3-harddisk-reg.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareServer" >> 2-3-harddisk-reg.log
::echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo > 2-3-harddisk-reg1.log
TYPE 2-3-harddisk-reg.log | find /v "unable"                                      >> 2-3-harddisk-reg1.log
TYPE 2-3-harddisk-reg1.log | find "AutoShareServer	0" > NUL
IF ERRORLEVEL 1 echo 2-3-3-bad  >> 2-2-result.log
echo > 2-3-netshare.log
FOR /F "tokens=2 skip=4" %%j IN ('type 2-3-netsharelist.log') DO cacls %%j        >> 2-3-netshare.log
type 2-3-netshare.log | find "Everyone" > nul
IF NOT ERRORLEVEL 1 echo �� ���� ���� Everyone ���� �ʿ�(��ȭ�� �� SG�� ���� ���� ����)  >> %COMPUTERNAME%-2-3.log


type 2-2-result.log | find "bad" > nul
IF NOT ERRORLEVEL 1 goto 2-3-bad


::echo �� ���������� �������� ������, ������Ʈ�� ���� ��ȣ�մϴ�                             >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo. >> %COMPUTERNAME%-2-3.log
echo �� �ý��� �������� ���� �� ���� ���� ������ ������ ���� �ǰ� >> %COMPUTERNAME%-2-3.log
echo. 																					   >> %COMPUTERNAME%-2-3.log
echo @ ��ȣ - 2.2. ���� ���� ����                                                          >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
type %COMPUTERNAME%-2-3.log                                                                >> %COMPUTERNAME%-test.log
goto 2-4

:2-3-bad
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo. 																					   >> %COMPUTERNAME%-2-3.log
echo �� �ý��� �������� ���� �� ���� ���� ������ ������ ���� �ǰ� >> %COMPUTERNAME%-2-3.log
echo. 																					   >> %COMPUTERNAME%-2-3.log
ECHO @ ��� - 2.2 ���� ���� ���� >> %COMPUTERNAME%-2-3.log | echo @ ��� - 2.2 ���� ���� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
type %COMPUTERNAME%-2-3.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-2-3.log                                                                >> %COMPUTERNAME%-test.log




:2-4
echo ### 2.3 SAM ���� ���� ����  #############################################################
echo END##################################################################################  > %COMPUTERNAME%-2-4.log
echo ### 2.3 SAM ���� ���� ����  ###############################################################  >> %COMPUTERNAME%-2-4.log
echo ##################################################################################### >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo START                                                                                 >> %COMPUTERNAME%-2-4.log
echo �� ���� : SAM���� ���ٱ����� Administrator, System �׷츸 ��� �������� ��ϵǾ� �ִ� ��� >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
cacls %systemroot%\system32\config\SAM				                   					   >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
cacls %systemroot%\system32\config\SAM | find /I "ER" > NUL
IF ERRORLEVEL 1 goto 2-4-good
IF NOT ERRORLEVEL 1 goto 2-4-bad

:2-4-bad
echo. >> %COMPUTERNAME%-2-4.log
echo �� SAM ���� ���ٱ����� Administrators, System �׷츸 ��� ���� ���� �ǰ�  >> %COMPUTERNAME%-2-4.log
echo. >> %COMPUTERNAME%-2-4.log
ECHO @ ��� - 2.3 SAM ���� ���� ���� >> %COMPUTERNAME%-2-4.log | echo @ ��� - 2.4 SAM ���� ���� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
type %COMPUTERNAME%-2-4.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-2-4.log                                                                >> %COMPUTERNAME%-test.log
goto 3-1

:2-4-good
echo. >> %COMPUTERNAME%-2-4.log
echo �� SAM ���� ���ٱ����� Administrators, System �׷츸 ��� ���� ���� �ǰ�  >> %COMPUTERNAME%-2-4.log
echo. >> %COMPUTERNAME%-2-4.log
ECHO @ ��ȣ - 2.3 SAM ���� ���� ����                             >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
type %COMPUTERNAME%-2-4.log                                                                >> %COMPUTERNAME%-test.log



:3-1
echo ### 3.1 �͹̳� ���� ��ȣȭ ���� ����  #######################################################
echo END##################################################################################  > %COMPUTERNAME%-3-1.log
echo ### 3.1 �͹̳� ���� ��ȣȭ ���� ����  ####################################################### >> %COMPUTERNAME%-3-1.log
echo ##################################################################################### >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo START                                                                                 >> %COMPUTERNAME%-3-1.log
echo �� ���� : ���ʿ�� �͹̳� ���񽺸� ������� �ʰų� ���� ��ȣȭ ������ 		   >> %COMPUTERNAME%-3-1.log
echo           "Ŭ���̾�Ʈ ȣȯ ����" �̻� �� ��Ʈ��ũ ���� ���� ���	   >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo �� ��Ȳ                                                                               >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo 1) Terminal ���� ��������                                                           >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
sc query TermService | findstr /I "RUNNING STOPPED"					    > 3-1-terminal.log
TYPE 3-1-terminal.log																	   >> %COMPUTERNAME%-3-1.log
net start | find "Remote Desktop Services" | find /v "Remote Desktop Services UserMode Port Redirector" > nul
IF NOT ERRORLEVEL 1 GOTO TERMINAL-ACTIV                                                    >> %COMPUTERNAME%-3-1.log
net start | find /i "Terminal Services" > nul
IF NOT ERRORLEVEL 1 GOTO TERMINAL-ACTIV                                                    >> %COMPUTERNAME%-3-1.log


IF ERRORLEVEL 1 ECHO �� �͹̳μ��񽺸� ��������� �ʽ��ϴ�.                                   >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo @ ��ȣ - 3.1 �͹̳� ���� ��ȣȭ ���� ����                                           >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
type %COMPUTERNAME%-3-1.log                                                                >> %COMPUTERNAME%-test.log
goto 3-2

:TERMINAL-ACTIV
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo �� �͹̳� ���񽺸� ������Դϴ�.                                                         >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo 2) Ŭ�󸮾�Ʈ ���� ��ȣȭ ����(2 �̻� ��ȣ)												           >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\MinEncryptionLevel"  >> %COMPUTERNAME%-3-1.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\MinEncryptionLevel"  >> 3-1-el.log
type 3-1-el.log | find /i "unable"
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
IF NOT ERRORLEVEL 1 ECHO �� Ŭ���̾�Ʈ ���� ��ȣȭ ������ �����Ǿ� ���� �ʽ��ϴ�.             >> %COMPUTERNAME%-3-1.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\MinEncryptionLevel" | findstr "2 3 4" > NUL
IF ERRORLEVEL 1 set terminalbad=1
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo 3) ��Ʈ��ũ ���� ���� ��� ����(1:���, 0:�̻��)										       >> %COMPUTERNAME%-3-1.log
echo �� �н����� 90�� ���� ���� ����ڰ� ���� �н����� ������ ���� �̻��                              >> %COMPUTERNAME%-3-1.log
::%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\UserAuthentication"  >> %COMPUTERNAME%-3-1.log
::%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\UserAuthentication"  >> 3-1-terminaldrive.log
::type 3-1-terminaldrive.log | find /i "unable"
::echo.                                                                                      >> %COMPUTERNAME%-3-1.log
::IF NOT ERRORLEVEL 1 ECHO �� ��Ʈ��ũ ���� ���� ��� ������ �Ǿ� ���� �ʽ��ϴ�.              >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
::%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\UserAuthentication" | findstr "1" > NUL
::IF ERRORLEVEL 1 GOTO 3-1-bad
echo %terminalbad% | findstr "1" >nul
IF ERRORLEVEL 1 goto 3-1-good
IF %terminalbad% EQU 1 goto 3-1-bad

:3-1-bad
::echo �� ���� � �� ������ ���� ����̺� ���ٷ��� ��� �ʿ�(��ȭ�� ��å ������ ���� �߰� �������� ����)                   >> %COMPUTERNAME%-3-1.log
echo.                                                                                               >> %COMPUTERNAME%-3-1.log
echo.                                                                                               >> %COMPUTERNAME%-3-1.log
::echo �� ���ʿ��� ��� �͹̳� ���� �����ϰų� ��� �� ��ȣȭ ������ ��Ŭ���̾�Ʈ ȣȯ ���ɡ� �̻��  >> %COMPUTERNAME%-3-1.log
::echo    "��Ʈ��ũ ���� ���� ���" ���� �ǰ�     										>> %COMPUTERNAME%-3-1.log
echo �� ���ʿ��� ��� �͹̳� ���� �����ϰų� ��� �� ��ȣȭ ������ ��Ŭ���̾�Ʈ ȣȯ ���ɡ� �̻� ���� �ǰ�  >> %COMPUTERNAME%-3-1.log
echo. 																								>> %COMPUTERNAME%-3-1.log
echo @ ��� - 3.1 �͹̳� ���� ��ȣȭ ���� ���� >> %COMPUTERNAME%-3-1.log | echo @ ��� - 3.1 �͹̳� ���� ��ȣȭ ���� ���� >> result.log
::echo @ ��ȣ - 3.1 �͹̳� ���� ��ȣȭ ���� �� ���𷺼� ����                                              >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
type %COMPUTERNAME%-3-1.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-3-1.log                                                                >> %COMPUTERNAME%-test.log
goto 3-2

:3-1-good
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
::echo �� ���ʿ��� ��� �͹̳� ���� �����ϰų� ��� �� ��ȣȭ ������ ��Ŭ���̾�Ʈ ȣȯ ���ɡ� �̻��  >> %COMPUTERNAME%-3-1.log
::echo    "��Ʈ��ũ ���� ���� ���" ���� �ǰ�     										>> %COMPUTERNAME%-3-1.log
echo �� ���ʿ��� ��� �͹̳� ���� �����ϰų� ��� �� ��ȣȭ ������ ��Ŭ���̾�Ʈ ȣȯ ���ɡ� �̻� ���� �ǰ�  >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo @ ��ȣ - 3.1 �͹̳� ���� ��ȣȭ ���� �� ���𷺼� ����                               >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
type %COMPUTERNAME%-3-1.log                                                                >> %COMPUTERNAME%-test.log



:3-2
echo ### 3.2 ��ȭ�� ��å ����  ############################################################### 
echo END#################################################################################  > %COMPUTERNAME%-3-2.log
echo ### 3.2 ��ȭ�� ��å ����  ################################################################ >> %COMPUTERNAME%-3-2.log
echo #################################################################################### >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo START                                                                                 >> %COMPUTERNAME%-3-2.log
echo �� ���� : �ܺ� ���� ������ ���� ��ȭ�� ��å ����                                       >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo �� ��������� ������ ���� ���� ��� ���� �Ǿ� ����  	                                               >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo @ ��ȣ - 3.2 ��ȭ�� ��å ���� 													     	   >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
type %COMPUTERNAME%-3-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-3-2.log                                                                >> %COMPUTERNAME%-test.log




:4-1
echo ### 4.1 Telnet ���� ����  ###########################################################
echo END################################################################################ > %COMPUTERNAME%-4-1.log
echo ### 4.1 Telnet ���� ����  ############################################################ >> %COMPUTERNAME%-4-1.log
echo ################################################################################### >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
echo START                                                                                 >> %COMPUTERNAME%-4-1.log
echo �� ���� : ���ʿ��� TELNET ���� ��� ����                                               >> %COMPUTERNAME%-4-1.log
echo.																						 >> %COMPUTERNAME%-4-1.log
echo �� ��Ȳ                                                                                  >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
net start | find "Telnet" > NUL
IF ERRORLEVEL 1 GOTO TELNET-DISABLE
IF NOT ERRORLEVEL 1 GOTO TELNET-ACTIVE

:TELNET-ACTIVE
echo �� TELNET ���񽺰� ��� �� �Դϴ�.                                                      >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log

:4-1-bad
echo. >> %COMPUTERNAME%-4-1.log
echo �� ���ʿ��� ��� Telnet ���� ������ �ǰ�  											 >> %COMPUTERNAME%-4-1.log
echo. >> %COMPUTERNAME%-4-1.log
ECHO @ ��� - 4.1 Telnet ���� ���� ���� >> %COMPUTERNAME%-4-1.log | echo @ ��� - 4.1 Telnet ���� ���� ���� >> result.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
type %COMPUTERNAME%-4-1.log >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-4-1.log >> %COMPUTERNAME%-test.log
goto 4-2

:TELNET-DISABLE
ECHO �� TELNET ���񽺰� ��� ������ �ʽ��ϴ�.                                                >> %COMPUTERNAME%-4-1.log 
echo.                                                                                        >> %COMPUTERNAME%-4-1.log

:4-1-good
echo. 																						 >> %COMPUTERNAME%-4-1.log
echo �� ���ʿ��� ��� Telnet ���� ������ �ǰ�  											 >> %COMPUTERNAME%-4-1.log
echo. 																						 >> %COMPUTERNAME%-4-1.log
echo @ ��ȣ - 4.1 Telnet ���� ���� ����                                                    >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
type %COMPUTERNAME%-4-1.log 															     >> %COMPUTERNAME%-test.log  




:4-2
echo ### 4.2 DNS ���� ����  ###############################################################
echo END################################################################################  > %COMPUTERNAME%-4-2.log
echo ### 4.2 DNS ���� ����  ################################################################ >> %COMPUTERNAME%-4-2.log
echo ################################################################################### >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
echo START                                                                                 >> %COMPUTERNAME%-4-2.log
echo �� ���� : DNS���񽺸� ��� �ʰų� ���������� '�ƹ� ������' �����Ǿ� ���� ������ ��ȣ >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
echo �� ��Ȳ                                                                               >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
net start | find "DNS Server" > NUL
IF ERRORLEVEL 1 GOTO DNS-DISABLE
IF NOT ERRORLEVEL 1 GOTO DNS-ACTIVE

:DNS-ACTIVE
ECHO �� DNS ���񽺰� ��� ���Դϴ�.                                                        >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | findstr /I "windows" > nul
IF NOT ERRORLEVEL 1 goto 4-2-A
IF ERRORLEVEL 1 goto 4-2-B

:4-2-A
%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s > dnslist.log
type dnslist.log | findstr /I "windows SecureSecondaries"  >> %COMPUTERNAME%-4-2.log
type dnslist.log | findstr /I "SecureSecondaries" | findstr /I "0x0" > nul
IF NOT ERRORLEVEL 1 GOTO 4-2-bad
IF ERRORLEVEL 1 GOTO 4-2-good

:4-2-B
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s  > dnslist.log
type dnslist.log | findstr /I "windows SecureSecondaries" >> %COMPUTERNAME%-4-2.log
type dnslist.log | findstr /I "SecureSecondaries" | findstr /I "0x0" > nul
IF NOT ERRORLEVEL 1 GOTO 4-2-bad
IF ERRORLEVEL 1 GOTO 4-2-good

:4-2-bad
echo. >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo �� ���ʿ��� ��� DNS ���񽺸� �����ϰų�, ����� ��� ���� ������ ���ƹ� �����Ρ� �������� �ʴ� ���� �ǰ� >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
ECHO @ ��� - 4.2 DNS(Domain Name Service) ���� ���� >> %COMPUTERNAME%-4-2.log | echo @ ��� - 4.2 DNS(Domain Name Service) ���� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log

type %COMPUTERNAME%-4-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-4-2.log                                                                >> %COMPUTERNAME%-test.log
goto 4-3

:4-2-good
echo. >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo �� ���ʿ��� ��� DNS ���񽺸� �����ϰų�, ����� ��� ���� ������ ���ƹ� �����Ρ� �������� �ʴ� ���� �ǰ� >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo @ ��ȣ - 4.2 DNS(Domain Name Service) ���� ����                                      >> %COMPUTERNAME%-4-2.log
type %COMPUTERNAME%-4-2.log                                                                >> %COMPUTERNAME%-test.log
goto 4-3

:DNS-DISABLE
ECHO �� DNS ���񽺰� ��� ������ �ʽ��ϴ�.                                                 >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo �� ���ʿ��� ��� DNS ���񽺸� �����ϰų�, ����� ��� ���� ������ ���ƹ� �����Ρ� �������� �ʴ� ���� �ǰ� >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo @ ��ȣ - 4.2 DNS(Domain Name Service) ���� ����                                      >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
type %COMPUTERNAME%-4-2.log                                                                >> %COMPUTERNAME%-test.log




:4-3
echo ### 4.3 SNMP ���� ���� ����  ######################################################### 
echo END################################################################################  > %COMPUTERNAME%-4-3.log
echo ### 4.3 SNMP ���� ���� ����  ########################################################## >> %COMPUTERNAME%-4-3.log
echo ################################################################################### >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo START                                                                                 >> %COMPUTERNAME%-4-3.log
echo �� ���� : SNMP ���񽺸� ������� �ʰų� Community String�� ������� �ʰų� public, private�� �ƴ� >> %COMPUTERNAME%-4-3.log
echo          9�ڸ� �̻��� �ڸ����� ����, ��ȣ�� ȥ���Ͽ� ��� �Ǵ� NULL ���� �����Ǿ� ������ ��ȣ    >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo �� ��Ȳ                                                                               >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
net start | find /i "SNMP Service" >nul                 
IF ERRORLEVEL 1 GOTO 4-3-SNMP-DISABLE                                                      >> %COMPUTERNAME%-4-3.log
IF NOT ERRORLEVEL 1 GOTO 4-3-SNMP-ACTIVE                                                   >> %COMPUTERNAME%-4-3.log

:4-3-SNMP-DISABLE
echo �� SNMP ���񽺰� ��������� �ʽ��ϴ�.                                                 >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo @ ��ȣ - 4.3 SNMP(Simple Network Management Protocol) ���� ���� ����               >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
type %COMPUTERNAME%-4-3.log                                                                >> %COMPUTERNAME%-test.log
goto 5-1

:4-3-SNMP-ACTIVE
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo �� SNMP ���񽺰� ������Դϴ�.                                                        >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log

echo ************************  Community String(Ŀ�´�Ƽ �̸�)  ************************** >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities" >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\TrapConfiguration" >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities" | find /v "ValidCommunities" | findstr [a-zA-Z] > 4-3-snmp.log
for /f "tokens=2" %%a in ('type 4-3-snmp.log') DO echo %%a | findstr [a-zA-Z] > nul
IF ERRORLEVEL 1 goto 4-3-good


for /f "tokens=2" %%a in ('type 4-3-snmp.log') DO echo %%a | findstr [a-zA-Z] >> 4-3-1-snmp.log
for /f "tokens=1 delims=:" %%a in ('findstr /N /R [a-zA-Z] 4-3-1-snmp.log') DO set compare_val1=%%a
for /f "tokens=2" %%a in ('type 4-3-snmp.log') DO echo %%a | findstr /R "........." >> 4-3-2-snmp.log
for /f "tokens=1 delims=:" %%a in ('findstr /N /R "........." 4-3-2-snmp.log') DO set compare_val2=%%a
IF NOT %compare_val1% EQU %compare_val2% goto 4-3-bad

type 4-3-snmp.log | find "public" > nul
IF NOT ERRORLEVEL 1 goto 4-3-bad

type 4-3-snmp.log | find "private" > nul
IF NOT ERRORLEVEL 1 goto 4-3-bad
IF ERRORLEVEL 1 echo @ ��ȣ - 4.3 SNMP(Simple Network Management Protocol) ���� ���� ����  >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
type %COMPUTERNAME%-4-3.log                                                                >> %COMPUTERNAME%-test.log
goto 5-1


:4-3-bad
echo. >> %COMPUTERNAME%-4-3.log
echo �� ���ʿ��� ��� SNMP ���񽺸� ���� �ϰų�, Community String�� ������� �ʰų� >> %COMPUTERNAME%-4-3.log
echo    public, private�� �ƴ� 9�ڸ� �̻����� �����ϰ� ���� �ǰ� 					>> %COMPUTERNAME%-4-3.log
echo. 																				>> %COMPUTERNAME%-4-3.log
ECHO @ ��� - 4.3 SNMP(Simple Network Management Protocol) ���� ���� ���� >> %COMPUTERNAME%-4-3.log | echo @ ��� - 4.3 SNMP(Simple Network Management Protocol) ���� ���� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.
type %COMPUTERNAME%-4-3.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-4-3.log                                                                >> %COMPUTERNAME%-test.log
goto 5-1


:4-3-good
ECHO �� SNMP ���񽺰� �������̳�, Ŀ�´�Ƽ ��Ʈ�� ���� �� ����                                              >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo �� ���ʿ��� ��� SNMP ���񽺸� ���� �ϰų�, Community String�� ������� �ʰų� >> %COMPUTERNAME%-4-3.log
echo    public, private�� �ƴ� 9�ڸ� �̻����� �����ϰ� ���� �ǰ� 					>> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo @ ��ȣ - 4.3 SNMP(Simple Network Management Protocol) ���� ���� ����                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
type %COMPUTERNAME%-4-3.log                                                                >> %COMPUTERNAME%-test.log

:5-1

echo ### 5.1 �ֽ� ���� �� ���� Ȯ��  ########################################################
echo END################################################################################  > %COMPUTERNAME%-5-1.log
echo ### 5.1 �ֽ� ���� �� ���� Ȯ��  ######################################################### >> %COMPUTERNAME%-5-1.log
echo ################################################################################### >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo START                                                                                 >> %COMPUTERNAME%-5-1.log
echo �� ���� : �ֽż������� ����ϰ� ������ ��ȣ           							   >> %COMPUTERNAME%-5-1.log
echo          Windows2008-SP2, Windows2008R2-SP1, Windows2012 �̻� SP0                   >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo ������� OS�� %WinVer% �Դϴ�.                                                        >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
%script%\psinfo | find "pack"                                                              >> 5-1-sp.log
%script%\psinfo | find "Kernel build number"                                               >> 5-2-sp.log
type 5-1-sp.log                           													>> %COMPUTERNAME%-5-1.log
type 5-2-sp.log                           													>> %COMPUTERNAME%-5-1.log
::%script%\psinfo | find "pack"                                                              >> %COMPUTERNAME%-5-1.log
::%script%\psinfo | find "Kernel build number"                                               >> %COMPUTERNAME%-5-1.log
systeminfo | findstr /i "���� Version" | find /v "BIOS"									   >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
rem systeminfo | find /i "service pack"														   >> %COMPUTERNAME%-5-1.log
rem systeminfo | find /i "service pack"														   >> 5-1-sp.log
rem echo.                                                                                      >> %COMPUTERNAME%-5-1.log

type 5-1-sp.log | find "0" > nul
IF NOT ERRORLEVEL 1 if "%WinVer%" == "Win2012" goto 5-1-yes-sp
type 5-1-sp.log | find "0" > nul
IF NOT ERRORLEVEL 1 if "%WinVer%" == "Win2012R2" goto 5-1-yes-sp
type 5-1-sp.log | find "0" > nul
IF NOT ERRORLEVEL 1 if "%WinVer%" == "Win2016" goto 5-1-yes-sp
type 5-1-sp.log | find "0" > nul
IF NOT ERRORLEVEL 1 if "%WinVer%" == "Win2019" goto 5-1-yes-sp
type 5-1-sp.log | find "0" > nul
IF NOT ERRORLEVEL 1 if "%WinVer%" == "Win2022" goto 5-1-yes-sp

type 5-1-sp.log | find "1" > nul
IF NOT ERRORLEVEL 1 if "%WinVer%" == "Win2008R2" goto 5-1-yes-sp
::type 5-2-sp.log | find "7601" > nul
::IF NOT ERRORLEVEL 1 if "%WinVer%" == "Win2008R2" goto 5-1-yes-sp

type 5-1-sp.log | find "2" > nul
IF NOT ERRORLEVEL 1 if "%WinVer%" == "Win2008" goto 5-1-yes-sp
::type 5-2-sp.log | find "6002" > nul
::IF NOT ERRORLEVEL 1 if "%WinVer%" == "Win2008" goto 5-1-yes-sp


:5-1-no-sp
echo �� �ֽ� ���� ���� ��ġ�Ǿ� ���� �ʽ��ϴ�.                                           >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo. >> %COMPUTERNAME%-5-1.log
echo �� �ֽ� ������ ��ġ�� �ǰ�							   >> %COMPUTERNAME%-5-1.log

echo. >> %COMPUTERNAME%-5-1.log
echo @ ��� - 5.1 �ֽ� ���� �� ���� >> %COMPUTERNAME%-5-1.log | echo @ ��� - 5.1 �ֽ� ���� �� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log

type %COMPUTERNAME%-5-1.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-5-1.log                                                                >> %COMPUTERNAME%-test.log
goto 5-2

:5-1-yes-sp
echo �� �ֽ� ���� ���� ��ġ�Ǿ� �ֽ��ϴ�.                                                >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo �� �ֽ� ������ ��ġ�� �ǰ�							   >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo @ ��ȣ - 5.1 �ֽ� ���� �� ����                                                     >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
type %COMPUTERNAME%-5-1.log                                                                >> %COMPUTERNAME%-test.log
goto 5-2



:5-2
echo ### 5.2 �ֽ� HOT FIX ���� Ȯ��  #######################################################
echo END################################################################################  > %COMPUTERNAME%-5-2.log
echo ### 5.2 �ֽ� HOT FIX ���� Ȯ��  ######################################################## >> %COMPUTERNAME%-5-2.log
echo ################################################################################### >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo START                                                                                 >> %COMPUTERNAME%-5-2.log
echo �� ���� : 6���� �̳��� �ֽ� ��ġ�� ��ġ�Ǿ� ������ ��ȣ								   				   >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log

::dism /online /get-intl																		>> lang.log
::TYPE lang.log | findstr "ko-"  > nul
::IF NOT ERRORLEVEL 1 GOTO lang-KR
::IF ERRORLEVEL 1 GOTO lang-EN

:::lang-KR
::FOR /f "tokens=1-4 delims=-" %%i in ('date /t') do set Rcu_dateY=%%i                         
::SET /a Rcu_dateY=%DATE:~0,4%%DATE:~5,0%%DATE:~8,0%
::SET /a Rcu_dateM=%DATE:~0,0%%DATE:~5,2%%DATE:~8,0%
::SET /a Rcu_dateS=(%Rcu_dateY%*12) + %Rcu_dateM%
::GOTO lang

:::lang-EN
::FOR /f "tokens=2-6 delims=/" %%i in ('date /t') do set Rcu_dateY=%%k                         
::SET /a Rcu_dateY=%DATE:~10,4%%DATE:~4,0%%DATE:~7,0%
::SET /a Rcu_dateM=%DATE:~10,0%%DATE:~4,2%%DATE:~7,0%
::SET /a Rcu_dateS=(%Rcu_dateY%*12) + %Rcu_dateM%
::GOTO lang

:::lang
FOR /f %%i in ('cscript //nologo %script%\OldDateCode2.vbs') do echo %%i                   >> HotfixBaseday.log
FOR /F "TOKENS=1,2,3 delims=/" %%i IN ('type HotfixBaseday.log') DO set cu_dateY=%%k
FOR /F "TOKENS=1,2,3 delims=/" %%i IN ('type HotfixBaseday.log') DO set cu_dateM=%%i
SET /a Start_Date=(%cu_dateY% * 12) + %cu_dateM% > nul

echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo �� ������Ʈ�� HOT FIX ��� Ȯ��                                                       >> %COMPUTERNAME%-5-2.log
wmic QFE Get HotFixID,InstalledOn | sort /r | findstr /n /v "HotFixID" | findstr /i "^[1-9]:"    >> %COMPUTERNAME%-5-2.log
::wmic QFE Get HotFixID,InstalledOn | sort /r | findstr /v "HotFixID"                        >> HotFixL.log
wmic QFE Get HotFixID,InstalledOn | sort /r | findstr /i "\/" | findstr /v "HotFixID"                        >> HotFixL.log
::type HotFixL.log                                                                           >> %COMPUTERNAME%-5-2.log
type HotFixL.log | findstr /i "KB" > nul
IF ERRORLEVEL 1 GOTO 5-2-bad1

::wmic QFE Get HotFixID,InstalledOn | findstr /n /v "HotFixID" | sort /r                     >> HotFixCh.log
type HotFixL.log | findstr /n "KB" | findstr /i "^1:KB"                                       >> HotFixCh.log
FOR /F "TOKENS=2" %%i IN ('type HotFixCh.log') DO echo %%i                                 >> HotFixCh1.log
FOR /F "TOKENS=1,2,3 delims=/" %%i IN ('type HotFixCh1.log') DO set Rcu_dateY=%%k
FOR /F "TOKENS=1,2,3 delims=/" %%i IN ('type HotFixCh1.log') DO set Rcu_dateM=%%i
::echo %Rcu_dateY%  >> Rcu_dateY.log
::echo %Rcu_dateM%  >> Rcu_dateM.log
SET /a End_Date=(%Rcu_dateY%*12) + %Rcu_dateM% > nul
::echo %End_Date%  >> end_date.log
echo �� ���� ��¥                                                                              >> %COMPUTERNAME%-5-2.log
TYPE HotfixBaseday.log                                                                     >> %COMPUTERNAME%-5-2.log


IF %End_Date% LSS %Start_Date% GOTO 5-2-bad
IF %End_Date% GEQ %Start_Date% GOTO 5-2-good

:5-2-good
echo. >> %COMPUTERNAME%-5-2.log
echo �� "Windows Update - ������Ʈ Ȯ��" ���� 6���� �̳� �ֽ� ��ġ ��ġ�� �ǰ�             >> %COMPUTERNAME%-5-2.log
echo. 																					   >> %COMPUTERNAME%-5-2.log
echo @ ��ȣ - 5.2 �ֽ� HOT FIX ����                                                        >> %COMPUTERNAME%-5-2.log 
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
type %COMPUTERNAME%-5-2.log 			                                           		   >> %COMPUTERNAME%-test.log
goto 6-1


:5-2-bad
echo. >> %COMPUTERNAME%-5-2.log
echo �� "Windows Update > ������Ʈ Ȯ��" ���� 6���� �̳� �ֽ� ��ġ ��ġ�� �ǰ�             >> %COMPUTERNAME%-5-2.log
echo. 																					   >> %COMPUTERNAME%-5-2.log
ECHO @ ��� - 5.2 �ֽ� HOT FIX ���� Ȯ�� >> %COMPUTERNAME%-5-2.log | echo @ ��� - 5.2 �ֽ� HOT FIX ���� Ȯ�� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log 
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
type %COMPUTERNAME%-5-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-5-2.log                                                                >> %COMPUTERNAME%-test.log
goto 6-1

:5-2-bad1
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo   �ý��ۿ� ��ġ�� HotFix ��ġ�� Ȯ�� �� �� �����ϴ�.                                             >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo �� "Windows Update > ������Ʈ Ȯ��" ���� 6���� �̳� �ֽ� ��ġ ��ġ�� �ǰ�             >> %COMPUTERNAME%-5-2.log
echo. 																					   >> %COMPUTERNAME%-5-2.log
ECHO @ ��� - 5.2 �ֽ� HOT FIX ���� Ȯ�� >> %COMPUTERNAME%-5-2.log | echo @ ��� - 5.2 �ֽ� HOT FIX ���� Ȯ�� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log 
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
type %COMPUTERNAME%-5-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-5-2.log                                                                >> %COMPUTERNAME%-test.log
goto 6-1




:6-1
echo ### 6.1 ���� �α����� ���� ����  #########################################################
echo END###############################################################################  > %COMPUTERNAME%-6-1.log
echo ### 6.1 ���� �α����� ���� ����  ########################################################## >> %COMPUTERNAME%-6-1.log
echo ################################################################################## >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
echo START                                                                                 >> %COMPUTERNAME%-6-1.log
echo �� ���� : �α� ���͸� ���� ���ѿ� Users/Everyone�� ���ؼ� ������, ���� �� ���� ������ ������ ��ȣ      >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log

cacls %systemroot%\system32\config                                                         >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
cacls %systemroot%\system32\logfiles                                                       >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log

cacls %systemroot%\system32\config | find /I /V "Power Users" > 6-1-Users_pum.log
cacls %systemroot%\system32\logfiles | find /I /V "Power Users" >> 6-1-Users_pum.log

TYPE 6-1-Users_pum.log | find /I "Users:" | find /I ":F" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Users:" | find /I ")F" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Users:" | find /I ":C" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Users:" | find /I ")C" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Users:" | find /I ":W" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Users:" | find /I ")W" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Everyone:" | find /I ":F" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Everyone:" | find /I ")F" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Everyone:" | find /I ":C" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Everyone:" | find /I ")C" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Everyone:" | find /I ":W" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
TYPE 6-1-Users_pum.log | find /I "Everyone:" | find /I ")W" > NUL
IF NOT ERRORLEVEL 1 goto 6-1-bad
IF ERRORLEVEL 1 goto 6-1-good

:6-1-bad
echo. >> %COMPUTERNAME%-6-1.log
echo �� �ý��� �α����� ���丮�� ���ٱ��ѿ� Users/Everyone ��� ����, ����, ���� ���� ���� ���� �ǰ� >> %COMPUTERNAME%-6-1.log
echo. >> %COMPUTERNAME%-6-1.log
ECHO @ ��� - 6.1 ���� �α����� ���� ���� >> %COMPUTERNAME%-6-1.log | echo @ ��� - 6.1 ���� �α����� ���� ���� >> result.log 
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log

type %COMPUTERNAME%-6-1.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-1.log                                                                >> %COMPUTERNAME%-test.log
goto 6-2

:6-1-good
echo. >> %COMPUTERNAME%-6-1.log
echo �� �ý��� �α����� ���丮�� ���ٱ��ѿ� Users/Everyone ��� ����, ����, ���� ���� ���� ���� �ǰ� >> %COMPUTERNAME%-6-1.log
echo. >> %COMPUTERNAME%-6-1.log
echo @ ��ȣ - 6.1 ���� �α����� ���� ����                                                  >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
type %COMPUTERNAME%-6-1.log                                                                >> %COMPUTERNAME%-test.log
goto 6-2



:6-2
echo ### 6.2 ȭ�� ��ȣ�� ����  ##############################################################
echo END################################################################################   > %COMPUTERNAME%-6-2.log
echo ### 6.2 ȭ�� ��ȣ�� ����  ###############################################################  >> %COMPUTERNAME%-6-2.log
echo ###################################################################################  >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
echo START                                                                                 >> %COMPUTERNAME%-6-2.log
echo �� ���� : ȭ�麸ȣ�⸦ �����ϰ� ��ȣ�� ����ϸ� ��� �ð��� 10���̸� ��ȣ             						  >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
echo [ HKCU\Control Panel\Desktop ]                                                        >> %COMPUTERNAME%-6-2.log
%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaveActive"                           >> %COMPUTERNAME%-6-2.log
%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaverIsSecure"                        >> %COMPUTERNAME%-6-2.log
%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaveTimeOut"                          >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
echo [ HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop ]                                                     >> %COMPUTERNAME%-6-2.log
%script%\reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop\ScreenSaveActive" 	   					>> %COMPUTERNAME%-6-2.log
%script%\reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop\ScreenSaverIsSecure"                        >> %COMPUTERNAME%-6-2.log
%script%\reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop\ScreenSaveTimeOut"                          >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log

echo. > 6-2-GUI.log
for /f "tokens=3" %%a in ('%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaveActive"') do set compare_val=%%a
IF NOT %compare_val% EQU 1 ECHO bad		>> 6-2-GUI.log
for /f "tokens=3" %%a in ('%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaverIsSecure"') do set compare_val=%%a
IF NOT %compare_val% EQU 1 ECHO bad		>> 6-2-GUI.log
for /f "tokens=3" %%a in ('%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaveTimeOut"') do set compare_val=%%a
IF NOT %compare_val% LEQ 600 ECHO bad	>> 6-2-GUI.log

type 6-2-GUI.log | find "bad" > nul
IF NOT ERRORLEVEL 1 goto 6-2-GPO
IF ERRORLEVEL 1 goto 6-2-good

:6-2-GPO
echo. > 6-2-REG.log
for /f "tokens=3" %%a in ('%script%\reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop\ScreenSaveActive"') do set compare_val=%%a
IF NOT %compare_val% EQU 1 ECHO bad		>> 6-2-REG.log
for /f "tokens=3" %%a in ('%script%\reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop\ScreenSaverIsSecure"') do set compare_val=%%a
IF NOT %compare_val% EQU 1 ECHO bad		>> 6-2-REG.log
for /f "tokens=3" %%a in ('%script%\reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop\ScreenSaveTimeOut"') do set compare_val=%%a
IF NOT %compare_val% LEQ 600 ECHO bad	>> 6-2-REG.log

type 6-2-REG.log | find "bad" > nul
IF NOT ERRORLEVEL 1 goto 6-2-bad

:6-2-good
echo. >> %COMPUTERNAME%-6-2.log
echo �� ȭ�麸ȣ�� ����(��ȣ ���, ��� �ð� 10��) �ǰ�			   >> %COMPUTERNAME%-6-2.log
echo. >> %COMPUTERNAME%-6-2.log
echo @ ��ȣ - 6.2 ȭ�� ��ȣ�� ����                                                      		   >> %COMPUTERNAME%-6-2.log 
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
type %COMPUTERNAME%-6-2.log 			                                           		   >> %COMPUTERNAME%-test.log
goto 6-3


:6-2-bad
echo. >> %COMPUTERNAME%-6-2.log
echo �� ȭ�麸ȣ�� ����(��ȣ ���, ��� �ð� 10��) �ǰ�													   >> %COMPUTERNAME%-6-2.log
echo. >> %COMPUTERNAME%-6-2.log
ECHO @ ��� - 6.2 ȭ�� ��ȣ�� ���� >> %COMPUTERNAME%-6-2.log | echo @ ��� - 6.2 ȭ�� ��ȣ�� ���� 			>> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log 
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
type %COMPUTERNAME%-6-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-2.log                                                                >> %COMPUTERNAME%-test.log
goto 6-3




:6-3
echo ### 6.3 �̺�Ʈ ��� ����  ##############################################################
echo END################################################################################   > %COMPUTERNAME%-6-3.log
echo ### 6.3 �̺�Ʈ ��� ����  ###############################################################  >> %COMPUTERNAME%-6-3.log
echo ###################################################################################  >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo START                                                                                 >> %COMPUTERNAME%-6-3.log
echo �� ���� : �ִ� �α� ũ�� 10240KB �̻��̰�, �α� ����� ���� �ɼ��� 0 ���� �����Ǹ� ��ȣ   >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo �� ���� ���α׷� �α�ũ�� - 10485760(�̻�)                                            >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application\MaxSize"   >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo �� ���� �α�ũ�� - 10485760(�̻�)                                                     >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Security\MaxSize"      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo �� �ý��� �α�ũ�� - 10485760(�̻�)                                                   >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\System\MaxSize"        >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log

echo [ HKLM\SYSTEM\CurrentControlSet\Services\Eventlog ]						>> %COMPUTERNAME%-6-3.log
echo �� ���� ���α׷� �α� ����� ���� �ɼ� - 0(�̺�Ʈ �����)                         >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application\Retention" >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo �� ���� �α� ����� ���� �ɼ� - 0(�̺�Ʈ �����)                                  >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Security\Retention"    >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo �� �ý��� �α� ����� ���� �ɼ� - 0(�̺�Ʈ �����)                                >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\System\Retention"      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log

echo [ HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog ]		>> %COMPUTERNAME%-6-3.log
echo �� ���� ���α׷� �α� ����� ���� �ɼ� - 0(�̺�Ʈ �����)                         >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Eventlog\Application\Retention" >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo �� ���� �α� ����� ���� �ɼ� - 0(�̺�Ʈ �����)                                  >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Eventlog\Security\Retention"    >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo �� �ý��� �α� ����� ���� �ɼ� - 0(�̺�Ʈ �����)                                >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Eventlog\System\Retention"      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log



echo. > 6-3-event.log
for /f "tokens=3" %%a in ('%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application\MaxSize"') do set compare_val=%%a
IF NOT %compare_val% GEQ 10485760 echo false >> 6-3-event.log

for /f "tokens=3" %%a in ('%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Security\MaxSize"') do set compare_val=%%a
IF NOT %compare_val% GEQ 10485760 echo false >> 6-3-event.log

for /f "tokens=3" %%a in ('%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\System\MaxSize"') do set compare_val=%%a
IF NOT %compare_val% GEQ 10485760 echo false >> 6-3-event.log

type 6-3-event.log | find "false" > nul
IF NOT ERRORLEVEL 1 goto 6-3-bad

echo. > 6-3-event-gui.log
for /f "tokens=3" %%a in ('%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application\Retention"') do set compare_val=%%a
IF NOT %compare_val% EQU 0 echo false >> 6-3-event-gui.log 

for /f "tokens=3" %%a in ('%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Security\Retention"') do set compare_val=%%a
IF NOT %compare_val% EQU 0 echo false >> 6-3-event-gui.log

for /f "tokens=3" %%a in ('%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\System\Retention"') do set compare_val=%%a
IF NOT %compare_val% EQU 0 echo false >> 6-3-event-gui.log

type 6-3-event-gui.log | find "false" > nul
IF NOT ERRORLEVEL 1 goto 6-3-gpo
IF ERRORLEVEL 1 goto 6-3-good

:6-3-gpo
echo. > 6-3-event-gpo.log
for /f "tokens=3" %%a in ('%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Eventlog\Application\Retention"') do set compare_val=%%a
IF NOT %compare_val% EQU 0 echo false >> 6-3-event-gpo.log 

for /f "tokens=3" %%a in ('%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Eventlog\Security\Retention"') do set compare_val=%%a
IF NOT %compare_val% EQU 0 echo false >> 6-3-event-gpo.log

for /f "tokens=3" %%a in ('%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Eventlog\System\Retention"') do set compare_val=%%a
IF NOT %compare_val% EQU 0 echo false >> 6-3-event-gpo.log

type 6-3-event-gpo.log | find "false" > nul
IF NOT ERRORLEVEL 1 goto 6-3-bad
IF ERRORLEVEL 1 goto 6-3-good

echo.                                                                                      >> %COMPUTERNAME%-6-3.log
::TYPE 6-3-event.log | find "false" > nul
::IF ERRORLEVEL 1 goto 6-3-good
::IF NOT ERRORLEVEL 1 goto 6-3-bad

:6-3-bad
echo. >> %COMPUTERNAME%-6-3.log
echo �� �̺�Ʈ ���(����) ���� ���α׷�, ����, �ý����� �α� ���� �ǰ� >> %COMPUTERNAME%-6-3.log
echo. >> %COMPUTERNAME%-6-3.log
echo @ ��� - 6.3 �̺�Ʈ ��� ���� >> %COMPUTERNAME%-6-3.log | echo @ ��� - 6.3 �̺�Ʈ ��� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log

type %COMPUTERNAME%-6-3.log 								   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-3.log								   >> %COMPUTERNAME%-test.log
goto 6-4

:6-3-good
echo. >> %COMPUTERNAME%-6-3.log
echo �� �̺�Ʈ ���(����) ���� ���α׷�, ����, �ý����� �α� ���� �ǰ� >> %COMPUTERNAME%-6-3.log
echo. >> %COMPUTERNAME%-6-3.log
echo @ ��ȣ - 6.3 �̺�Ʈ ��� ����                                                        >> %COMPUTERNAME%-6-3.log 
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
type %COMPUTERNAME%-6-3.log                                                                >> %COMPUTERNAME%-test.log






:6-4
echo ### 6.4 �α��� �� ��� �޽��� ǥ�� ����  ####################################################
echo END################################################################################   			> %COMPUTERNAME%-6-4.log
echo ### 6.4 �α��� �� ��� �޽��� ǥ�� ����  #####################################################		>> %COMPUTERNAME%-6-4.log
echo ###################################################################################  				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo START                                                                                 >> %COMPUTERNAME%-6-4.log
echo �� ���� : �α��ν� ��� �޽����� ǥ�õǸ� ��ȣ                                        				>> %COMPUTERNAME%-6-4.log
echo          ��� �޽��� ��)  ����   : ���                                              				>> %COMPUTERNAME%-6-4.log
echo.                     ��)  �ؽ�Ʈ : �ҹ����� �ý��� ����� ���ù��� ���� ó���� �޽��ϴ�.  			>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo �� ��Ȳ                                                                               				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo [������Ʈ�� ��ġ]                                                                     				>> %COMPUTERNAME%-6-4.log
echo [HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system]                    				>> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption"  >> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticetext"     >> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo [������Ʈ�� ��ġ]                                                                     				>> %COMPUTERNAME%-6-4.log
echo [HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]                    					>> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeCaption"      >> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeText"         >> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo [�������� - ���ú�����å - ������å - ���ȿɼ�]                                       				>> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption"  > comtype-6-4.log
FOR /F "tokens=3" %%a IN ('type comtype-6-4.log') DO echo %%a											> comtype-6-4.log
echo [��ȭ�� �α׿� : �α׿� �õ��ϴ� ����ڿ� ���� �޼��� ����] 										>> %COMPUTERNAME%-6-4.log
type comtype-6-4.log																					>> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticetext"     > comtype-6-4.log
FOR /F "tokens=3" %%a IN ('type comtype-6-4.log') DO echo %%a											> comtype-6-4.log
echo [��ȭ�� �α׿� : �α׿� �õ��ϴ� ����ڿ� ���� �޼��� �ؽ�Ʈ] 										>> %COMPUTERNAME%-6-4.log
type comtype-6-4.log																					>> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      		    	>> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeCaption"       > 6-4-logonmessage-1.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption"  >> 6-4-logonmessage-1.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeText"          > 6-4-logonmessage.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\LegalNoticeText"     >> 6-4-logonmessage.log
findstr /I "�ҹ� ��� ó�� warning authoriz law" 6-4-logonmessage-1.log > nul
IF NOT ERRORLEVEL 1 goto 6-4-text
IF ERRORLEVEL 1 goto 6-4-bad
:6-4-text
findstr /I "�ҹ� ��� ó�� warning authoriz law" 6-4-logonmessage.log > nul
IF NOT ERRORLEVEL 1 goto 6-4-good

:6-4-bad
echo. >> %COMPUTERNAME%-6-4.log
echo �� ���ΰ����� �ý��� �α��� �� �ҹ����� ����� ����ϴ� �޽��� ���� �ǰ� >> %COMPUTERNAME%-6-4.log
echo. >> %COMPUTERNAME%-6-4.log
echo @ ��� - 6.4 �α׿� �� ��� �޽��� ǥ�� ���� >> %COMPUTERNAME%-6-4.log | echo @ ��� - 6.4 �α׿� �� ��� �޽��� ǥ�� ���� >> result.log 
echo.                                                                                      >> %COMPUTERNAME%-6-4.log
echo.                                                                                      >> %COMPUTERNAME%-6-4.log
type %COMPUTERNAME%-6-4.log 								   							   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-4.log								   	   							   >> %COMPUTERNAME%-test.log
goto 6-5

:6-4-good
echo. >> %COMPUTERNAME%-6-4.log
echo �� ���ΰ����� �ý��� �α��� �� �ҹ����� ����� ����ϴ� �޽��� ���� �ǰ� >> %COMPUTERNAME%-6-4.log
echo. >> %COMPUTERNAME%-6-4.log
echo @ ��ȣ - 6.4 �α׿� �� ��� �޽��� ǥ�� ���� 					   					   >> %COMPUTERNAME%-6-4.log
echo.                                                                                      >> %COMPUTERNAME%-6-4.log
echo.                                                                                      >> %COMPUTERNAME%-6-4.log
echo.                                                                                      >> %COMPUTERNAME%-6-4.log
type %COMPUTERNAME%-6-4.log							           							   >> %COMPUTERNAME%-test.log





:6-5
echo ### 6.5 ������ �α׿� ����� ���� ���� ����  #################################################
echo END################################################################################  > %COMPUTERNAME%-6-5.log
echo ### 6.5 ������ �α׿� ����� ���� ���� ����  ##################################################  >> %COMPUTERNAME%-6-5.log
echo ###################################################################################  >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
echo START                                                                                 >> %COMPUTERNAME%-6-5.log
echo �� ���� : �������� �α׿� ����� ���� �������� ����롱���� �����Ǿ� ���� ��� ��ȣ     >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
echo �� ��Ȳ                                                                                 >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\DontDisplayLastUserName"   >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\DontDisplayLastUserName"   >> 6-5-lastlogon.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log

type 6-5-lastlogon.log | find "1" > nul
IF NOT ERRORLEVEL 1 goto 6-5-good
IF ERRORLEVEL 1 goto 6-5-bad

:6-5-bad
echo �� ��DontDisplayLastUserName�� ������Ʈ�� ���� ��1���� ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-6-5.log
echo. >> %COMPUTERNAME%-6-5.log
ECHO @ ��� - 6.5 ������ �α׿� ����� ���� ���� >> %COMPUTERNAME%-6-5.log | echo @ ��� - 6.5 ������ �α׿� ����� ���� ���� >> result.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
type %COMPUTERNAME%-6-5.log                                                                  >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-5.log                                                                  >> %COMPUTERNAME%-test.log
goto 6-6

:6-5-good
echo �� ��DontDisplayLastUserName�� ������Ʈ�� ���� ��1���� ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-6-5.log
echo. >> %COMPUTERNAME%-6-5.log
ECHO @ ��ȣ - 6.5 ������ �α׿� ����� ���� ����                                              >> %COMPUTERNAME%-6-5.log 
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
type %COMPUTERNAME%-6-5.log                                                                  >> %COMPUTERNAME%-test.log



:6-6
echo ### 6.6 �α׿� ���� ���� ����� �ý��� ���� ����  ##############################################
echo END################################################################################   > %COMPUTERNAME%-6-6.log
echo ### 6.6 �α׿� ���� ���� ����� �ý��� ���� ����  ###############################################  >> %COMPUTERNAME%-6-6.log
echo ###################################################################################  >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo START                                                                                 >> %COMPUTERNAME%-6-6.log
echo �� ���� : '�α׿����� �ʰ� �ý��� ���� ���'�� '������'���� �����Ǿ� ���� ���       >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon" >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon" | find /v "ShutdownWithoutLogon	0" > nul
IF ERRORLEVEL 1 goto 6-6-good
IF NOT ERRORLEVEL 1 goto 6-6-bad

:6-6-bad
echo. >> %COMPUTERNAME%-6-6.log
echo �� ��ShutdownWithoutLogon�� ������Ʈ�� ���� ��0���� ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-6-5.log
echo. >> %COMPUTERNAME%-6-6.log
ECHO @ ��� - 6.6 �α׿����� ���� ����� �ý������� ���� >> %COMPUTERNAME%-6-6.log | echo @ ��� - 6.6 �α׿����� ���� ����� �ý������� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log                                                                                          

type %COMPUTERNAME%-6-6.log							           >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-6.log 								   >> %COMPUTERNAME%-test.log
goto 6-7

:6-6-good 	
echo. >> %COMPUTERNAME%-6-6.log
echo �� ��ShutdownWithoutLogon�� ������Ʈ�� ���� ��0���� ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo @ ��ȣ - 6.6 �α׿� ���� ���� ����� �ý������� ����			           >> %COMPUTERNAME%-6-6.log 
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
type %COMPUTERNAME%-6-6.log								   >> %COMPUTERNAME%-test.log





:6-7
echo ### 6.7 ���� ���� ������å ����  ##########################################################
echo END################################################################################   > %COMPUTERNAME%-6-7.log
echo ### 6.7 ���� ���� ������å ����  ###########################################################  >> %COMPUTERNAME%-6-7.log
echo ###################################################################################  >> %COMPUTERNAME%-6-7.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
echo START                                                                                 >> %COMPUTERNAME%-6-7.log
echo �� ���� : �̺�Ʈ ���� �׸� ���ؼ� �ݵ�� '����'�� '����' ���簡 �����Ǿ� ������ ��ȣ    >> %COMPUTERNAME%-6-7.log
echo ( �ʼ����밨����å : �������� ����, �����α׿��̺�Ʈ ����, ���ѻ�� ����, �α׿� �̺�Ʈ ���� )    >> %COMPUTERNAME%-6-7.log
echo �ѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤ�       >> %COMPUTERNAME%-6-7.log
echo ��ü �׼��� ����        (Logon)                                                        >> %COMPUTERNAME%-6-7.log
echo ���� ���� ����          (Object Access)                                                >> %COMPUTERNAME%-6-7.log
echo ���� �α׿� �̺�Ʈ ���� (Account Logon)                                                >> %COMPUTERNAME%-6-7.log
echo ���� ��� ����          (Account Management)                                           >> %COMPUTERNAME%-6-7.log
echo �α׿� �̺�Ʈ ����      (Privilege Use)                                                >> %COMPUTERNAME%-6-7.log
echo �ѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤѤ�   	>> %COMPUTERNAME%-6-7.log

echo.                                                                                       >> %COMPUTERNAME%-6-7.log
echo �� ��Ȳ                                                                                 >> %COMPUTERNAME%-6-7.log
echo.                                                                                       >> %COMPUTERNAME%-6-7.log
%script%\auditpol                                                                           >> %COMPUTERNAME%-6-7.log
%script%\auditpol                                                                           > 6-7-securitylog.log
type 6-7-securitylog.log | find "Logon"                                            > 6-7-auditpol.log
::type 6-7-securitylog.log | find "Object Access"                                   >> 6-7-auditpol.log
type 6-7-securitylog.log | find "Account Logon"                                   >> 6-7-auditpol.log
type 6-7-securitylog.log | find "Account Management"                              >> 6-7-auditpol.log
type 6-7-securitylog.log | find "Privilege Use"                                   >> 6-7-auditpol.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log

type 6-7-auditpol.log | find /v "Success and Failure" >nul
IF ERRORLEVEL 1 goto 6-7-good


IF NOT ERRORLEVEL 1 goto 6-7-bad

:6-7-bad
echo. >> %COMPUTERNAME%-6-7.log
echo �� ��ü������ ����, �������� ����, �����α׿��̺�Ʈ ����, ���ѻ�� ����, �α׿� �̺�Ʈ ����  >> %COMPUTERNAME%-6-7.log
echo �� ���ؼ��� �ݵ�� ������ ���� ���� ������ �ǰ�     										  >> %COMPUTERNAME%-6-7.log
echo. >> %COMPUTERNAME%-6-7.log
ECHO @ ��� - 6.7 ���� ������å ���� >> %COMPUTERNAME%-6-7.log | echo @ ��� - 6.7 ���� ������å ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
type %COMPUTERNAME%-6-7.log								   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-7.log 								   >> %COMPUTERNAME%-test.log
goto 6-8


:6-7-good
echo. >> %COMPUTERNAME%-6-7.log
echo �� ��ü������ ����, �������� ����, �����α׿��̺�Ʈ ����, ���ѻ�� ����, �α׿� �̺�Ʈ ����  >> %COMPUTERNAME%-6-7.log
echo �� ���ؼ��� �ݵ�� ������ ���� ���� ������ �ǰ�     										  >> %COMPUTERNAME%-6-7.log
echo. >> %COMPUTERNAME%-6-7.log
echo @ ��ȣ - 6.7 ���� ������å ����                                                       >> %COMPUTERNAME%-6-7.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
type %COMPUTERNAME%-6-7.log 								   							   >> %COMPUTERNAME%-test.log



:6-8
echo ### 6.8 ���� �޸� ������ ���� ���� ����  ###################################################
echo END################################################################################  > %COMPUTERNAME%-6-8.log
echo ### 6.8 ���� �޸� ������ ���� ���� ����  #################################################### >> %COMPUTERNAME%-6-8.log
echo ################################################################################### >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
echo START                                                                                 >> %COMPUTERNAME%-6-8.log
echo �� ���� : '�ý����� ������ �� ���� �޸� ������ ���� ����' �׸��� '���'���� �����Ǿ� ������ ��ȣ   >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\ClearPageFileAtShutdown"   >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\ClearPageFileAtShutdown" | find /I "1" > nul
IF NOT ERRORLEVEL 1 goto 6-8-good
IF ERRORLEVEL 1 goto 6-8-bad

:6-8-bad
echo. >> %COMPUTERNAME%-6-8.log
echo �� "ClearPageFileAtShutdown" ������Ʈ�� ���� ��1���� ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-6-8.log
echo. >> %COMPUTERNAME%-6-8.log
ECHO @ ��� - 6.8 ���� �޸� ������ ���� ���� ���� >> %COMPUTERNAME%-6-8.log | echo @ ��� - 6.8 ���� �޸� ������ ���� ���� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
type %COMPUTERNAME%-6-8.log 		                                                   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-8.log 		                                                   >> %COMPUTERNAME%-test.log
goto 6-9

:6-8-good
echo. >> %COMPUTERNAME%-6-8.log
echo �� "ClearPageFileAtShutdown" ������Ʈ�� ���� ��1���� ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-6-8.log
echo. >> %COMPUTERNAME%-6-8.log
echo @ ��ȣ - 6.8 ���� �޸� ������ ���� ���� ����	                                   >> %COMPUTERNAME%-6-8.log 
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
type %COMPUTERNAME%-6-8.log 		                                                   >> %COMPUTERNAME%-test.log

:6-9
echo ### 6.9 ������ ����̹� ��ġ ����  ######################################################### 
echo END#################################################################################  > %COMPUTERNAME%-6-9.log
echo ### 6.9 ������ ����̹� ��ġ ����  ########################################################## >> %COMPUTERNAME%-6-9.log
echo #################################################################################### >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
echo START                                                                                 >> %COMPUTERNAME%-6-9.log
echo �� ���� : '����ڰ� ������ ����̹��� ��ġ �� �� ���� ��' �׸��� '���'���� �����Ǿ� ������ ��ȣ   >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers\AddPrinterDrivers"   	>> %COMPUTERNAME%-6-9.log
echo.                                                                                      						>> %COMPUTERNAME%-6-9.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers\AddPrinterDrivers" | find /I "1" > nul
IF NOT ERRORLEVEL 1 goto 6-9-good
IF ERRORLEVEL 1 goto 6-9-bad

:6-9-bad
echo. >> %COMPUTERNAME%-6-9.log
echo �� "AddPrinterDrivers" ������Ʈ�� ���� ��1���� ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-6-9.log
echo. >> %COMPUTERNAME%-6-9.log
ECHO @ ��� - 6.9 ������ ����̹� ��ġ ���� >> %COMPUTERNAME%-6-9.log | echo @ ��� - 6.9 ������ ����̹� ��ġ ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
type %COMPUTERNAME%-6-9.log 		                                                   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-9.log 		                                                   >> %COMPUTERNAME%-test.log
goto 7-1

:6-9-good
echo. >> %COMPUTERNAME%-6-9.log
echo �� "AddPrinterDrivers" ������Ʈ�� ���� ��1���� ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-6-9.log
echo. >> %COMPUTERNAME%-6-9.log
echo @ ��ȣ - 6.9 ������ ����̹� ��ġ ����	                                   			   >> %COMPUTERNAME%-6-9.log 
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
type %COMPUTERNAME%-6-9.log 		                                                       >> %COMPUTERNAME%-test.log





:7-1
echo ### 7.1 ��� ���α׷� ��ġ  ##############################################################
echo END#################################################################################   > %COMPUTERNAME%-7-1.log
echo ### 7.1 ��� ���α׷� ��ġ  ###############################################################  >> %COMPUTERNAME%-7-1.log
echo ####################################################################################  >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
echo START                                                                                 >> %COMPUTERNAME%-7-1.log
echo �� ���� : ��� ��� ���α׷��� ��ġ�ϰ� �ǽð� ���� ����� Ȱ��ȭ�ϰ� ������ ��ȣ       >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
echo �� ��Ȳ                                                                                 >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log 
::net start | find /I "AhnLab Application Service" > nul
::IF ERRORLEVEL 1 ECHO �� ���̷��� ��� ���α׷�(V3 Windows Server)�� ��ġ�Ǿ� ���� �ʽ��ϴ�.                >> %COMPUTERNAME%-7-1.log 
::IF NOT ERRORLEVEL 1 ECHO �� ���̷��� ��� ���α׷�(V3 Windows Server)�� ��ġ�Ǿ� �ֽ��ϴ�.                 >> %COMPUTERNAME%-7-1.log
::echo.                                                                                       >> %COMPUTERNAME%-7-1.log 
net start | find /I "Symantec Endpoint Protection" > nul
IF ERRORLEVEL 1 ECHO �� ���̷��� ��� ���α׷�(Symantec Endpoint Protection) ��ġ�Ǿ� ���� �ʽ��ϴ�.                >> %COMPUTERNAME%-7-1.log 
IF NOT ERRORLEVEL 1 ECHO �� ���̷��� ��� ���α׷�(Symantec Endpoint Protection) ��ġ�Ǿ� �ֽ��ϴ�.                 >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log 
net start | find /I "eset" > nul
IF ERRORLEVEL 1 ECHO �� ���̷��� ��� ���α׷�(ESET) ��ġ�Ǿ� ���� �ʽ��ϴ�.                >> %COMPUTERNAME%-7-1.log 
IF NOT ERRORLEVEL 1 ECHO �� ���̷��� ��� ���α׷�(ESET) ��ġ�Ǿ� �ֽ��ϴ�.                 >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log 
net start | find /I "eset"					                       							> 7-1-vaccine.log
IF NOT ERRORLEVEL 1 goto 7-1-good
::net start | find /I "AhnLab V3 Service"                       								>> 7-1-vaccine.log
::IF NOT ERRORLEVEL 1 goto 7-1-good
net start | find /I "Symantec Endpoint Protection"										    >> 7-1-vaccine.log
IF ERRORLEVEL 1 goto 7-1-bad
IF NOT ERRORLEVEL 1 goto 7-1-good
echo.                                                                                       >> %COMPUTERNAME%-7-1.log

:7-1-bad
echo. >> %COMPUTERNAME%-7-1.log
echo �� ��� ��� ���α׷��� ��ġ�ϰ� �ǽð� ���� ����� Ȱ��ȭ �ǰ� >> %COMPUTERNAME%-7-1.log
echo. >> %COMPUTERNAME%-7-1.log
ECHO @ ��� - 7.1 ��� ���α׷� ��ġ >> %COMPUTERNAME%-7-1.log | echo @ ��� - 7.1 ��� ���α׷� ��ġ >> result.log 
echo.                                                                                       >> %COMPUTERNAME%-7-1.log 
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
type %COMPUTERNAME%-7-1.log 								    >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-7-1.log 								    >> %COMPUTERNAME%-test.log
goto 7-2

:7-1-good
echo. >> %COMPUTERNAME%-7-1.log
echo �� ��� ��� ���α׷��� ��ġ�ϰ� �ǽð� ���� ����� Ȱ��ȭ �ǰ� >> %COMPUTERNAME%-7-1.log
echo. >> %COMPUTERNAME%-7-1.log
echo @ ��ȣ - 7.1 ��� ���α׷� ��ġ                                                       >> %COMPUTERNAME%-7-1.log 
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
type %COMPUTERNAME%-7-1.log								    >> %COMPUTERNAME%-test.log


:7-2
echo ### 7.2 �ֽ� ���� ������Ʈ  ##############################################################
echo END#################################################################################  > %COMPUTERNAME%-7-2.log
echo ### 7.2 �ֽ� ���� ������Ʈ  ############################################################### >> %COMPUTERNAME%-7-2.log
echo #################################################################################### >> %COMPUTERNAME%-7-2.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
echo START                                                                                 >> %COMPUTERNAME%-7-2.log
echo �� ���� : ��� ��� ���α׷��� ��ġ�Ǿ� �ְų� �ֽ� ���� ������Ʈ�� ��ġ�Ǿ� ������ ��ȣ  >> %COMPUTERNAME%-7-2.log                
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-7-2.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log 
for /f %%i in ('cscript //nologo %script%\OldDateCode3.vbs') do set cu_date=%%i

::net start | find /i "Symantec Endpoint Protection WSC Service" > nul
::net start | find /I "Symantec Endpoint Protection"                                  >> %COMPUTERNAME%-7-2.log 
::net start | find /I "eset"                              						    >> %COMPUTERNAME%-7-2.log 
::IF ERRORLEVEL 1 ECHO �� APC(AhnLab Policy Agent)�� ��ġ�Ǿ� ���� �ʽ��ϴ�.                 >> %COMPUTERNAME%-7-2.log 
::IF NOT ERRORLEVEL 1 ECHO �� APC(AhnLab Policy Agent)�� ��ġ�Ǿ� �ֽ��ϴ�.                  >> %COMPUTERNAME%-7-2.log
::IF ERRORLEVEL 1 goto 7-2-SEP
::IF NOT ERRORLEVEL 1 goto 7-2-V3
::echo.                                                                                      >> %COMPUTERNAME%-7-2.log 

:::7-2-V3
::echo.                                                                                      >> %COMPUTERNAME%-7-2.log 
::echo �� [ V3 ���� ������Ʈ ��¥ ]                                                              >> %COMPUTERNAME%-7-2.log
::reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Ahnlab\V3Net70" /v "V3EngineDate" | findstr "V3EngineDate"                  >> %COMPUTERNAME%-7-2.log
::reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Ahnlab\V3Net70" /v "V3EngineDate" | findstr "V3EngineDate"                  >> V3.log
::FOR /F "TOKENS=3" %%i IN ('type V3.log') DO echo %%i >> V3-1.log
::FOR /F "TOKENS=1,2,3 delims=." %%i IN ('type V3-1.log') DO set v3date=%%i%%j%%k
::if not %cu_date% LSS %v3date% goto V3NSU
::goto 7-2-SEP
:::V3NSU
::echo   ��ſ����� ������Ʈ ���� �ʾҽ��ϴ�.  >> %COMPUTERNAME%-7-2.log
::set enginebad=0
::GOTO 7-2-SEP

:7-2-SEP
::net start | find /i "Endpoint Protection WSC Service" > nul
net start | find /I "Symantec Endpoint Protection"  > nul
IF ERRORLEVEL 1 ECHO �� Endpoint Protection Service ��ġ�Ǿ� ���� �ʽ��ϴ�.               			  >> %COMPUTERNAME%-7-2.log 
IF NOT ERRORLEVEL 1 ECHO �� Endpoint Protection Service �ֽ� ������Ʈ ��ġ�Ǿ� �ֽ��ϴ�.                 >> %COMPUTERNAME%-7-2.log
echo.                                                                                       >> %COMPUTERNAME%-7-2.log 
net start | find /I "eset"   > nul
IF ERRORLEVEL 1 ECHO �� ���̷��� ��� ���α׷�(ESET) ��ġ�Ǿ� ���� �ʽ��ϴ�.             			   >> %COMPUTERNAME%-7-2.log 
IF NOT ERRORLEVEL 1 ECHO �� ���̷��� ��� ���α׷�(ESET) �ֽ� ������Ʈ ��ġ�Ǿ� �ֽ��ϴ�.                 >> %COMPUTERNAME%-7-2.log
echo. 																							>> %COMPUTERNAME%-7-2.log 
net start | find /I "eset" > nul
IF NOT ERRORLEVEL 1 goto 7-2-good
net start | find /I "Symantec Endpoint Protection"	
IF ERRORLEVEL 1 goto 7-2-bad
IF NOT ERRORLEVEL 1 goto 7-2-good


::net start | find /I "Symantec Endpoint Protection" > nul
::echo.                                                                                                                                        >> %COMPUTERNAME%-7-2.log 
::IF NOT ERRORLEVEL 1 ECHO �� Endpoint Protection Service �ֽ� ������Ʈ ��ġ�Ǿ� �ֽ��ϴ�.                                                   >> %COMPUTERNAME%-7-2.log
::IF ERRORLEVEL 1 ECHO �� Endpoint Protection Service ��ġ�Ǿ� ���� �ʽ��ϴ�.                                                  >> %COMPUTERNAME%-7-2.log
::IF NOT ERRORLEVEL 1 GOTO 7-2-good
::IF ERRORLEVEL 1 GOTO :7-2-bad
::echo.                                                                                                                                        >> %COMPUTERNAME%-7-2.log 


:::7-2-SEP1
::echo.                                                                                                                                        >> %COMPUTERNAME%-7-2.log 
::echo �� [ SEP ���� ������Ʈ ��¥ ]                                                                                                               >> %COMPUTERNAME%-7-2.log
::systeminfo | findstr /i "X86" > nul
::IF ERRORLEVEL 1 goto x64
::reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion\public-opstate" /v "LatestVirusDefsDate" | findstr "LatestVirusDefsDate"        >> %COMPUTERNAME%-7-2.log
::reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Symantec\Symantec Endpoint Protection\CurrentVersion\public-opstate" /v "LatestVirusDefsDate" | findstr "LatestVirusDefsDate"         >> sep86.log
::FOR /F "TOKENS=3" %%i IN ('type sep86.log') DO echo %%i >> sep86-1.log
::FOR /F "TOKENS=1" %%i IN ('type sep86-1.log') DO set sepdate=%%i
::set sepdate=%sepdate:-=%
::if not %cu_date% LSS %sepdate% goto NSU
::goto 7-2-END

:::x64
::reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432\Symantec\Symantec Endpoint Protection\CurrentVersion\public-opstate" /v LatestVirusDefsDate"  >> %COMPUTERNAME%-7-2.log
::reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432\Symantec\Symantec Endpoint Protection\CurrentVersion\public-opstate" /v LatestVirusDefsDate"  >> sep64.log
::FOR /F "TOKENS=3" %%i IN ('type sep64.log') DO echo %%i >> sep64-1.log
::FOR /F "TOKENS=1" %%i IN ('type sep64-1.log') DO set sepdate=%%i
::set sepdate=%sepdate:-=%
::if not %cu_date% LSS %sepdate% goto NSU
::goto 7-2-END

:::NSU
::ECHO   ��� ������ ������Ʈ ���� �ʾҽ��ϴ�.  >> %COMPUTERNAME%-7-2.log
::goto 7-2-bad

:::7-2-END
::echo %enginebad% | findstr "0" >nul
::IF ERRORLEVEL 1 goto 7-2-1
::IF %enginebad% EQU 0 goto 7-2-bad
:::7-2-1
::net start | find /i "Policy Agent Service" > nul                                               
::IF NOT ERRORLEVEL 1 goto 7-2-good
::net start | find /i "Symantec Management Client" > nul
::IF ERRORLEVEL 1 goto 7-2-bad
::IF NOT ERRORLEVEL 1 goto 7-2-good


:7-2-bad
echo. >> %COMPUTERNAME%-7-2.log
echo �� ��� ���α׷� �ֽ� ���� ������Ʈ ��ġ �ǰ� 				   >> %COMPUTERNAME%-7-2.log
echo. 																					   >> %COMPUTERNAME%-7-2.log
ECHO @ ��� - 7.2 �ֽ� ���� ������Ʈ >> %COMPUTERNAME%-7-2.log | echo @ ��� - 7.2 �ֽ� ���� ������Ʈ >> result.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log 
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
type %COMPUTERNAME%-7-2.log 								   							   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-7-2.log								   								   >> %COMPUTERNAME%-test.log
goto 8-2

:7-2-good
echo. >> %COMPUTERNAME%-7-2.log
echo �� ��� ���α׷��� �ֽ� ���� ������Ʈ ��ġ �ǰ� 				   >> %COMPUTERNAME%-7-2.log
echo. 																					   >> %COMPUTERNAME%-7-2.log
echo @ ��ȣ - 7.2 �ֽ� ���� ������Ʈ                                                       >> %COMPUTERNAME%-7-2.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
type %COMPUTERNAME%-7-2.log 								   							   >> %COMPUTERNAME%-test.log

                                                    
:::8-1
::echo ### 8.1 SAM ���� ���� ����  ############################################################
::echo END#################################################################################  > %COMPUTERNAME%-8-1.log
::echo ### 8.1 SAM ���� ���� ����  ############################################################# >> %COMPUTERNAME%-8-1.log
::echo #################################################################################### >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo START                                                                                 >> %COMPUTERNAME%-8-1.log
::echo �� ���� : �ش� ������Ʈ�� ���� Everyone �� ���� ���缳���� �Ǿ� ������ ��ȣ            >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo �� ��Ȳ                                                                                >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo �� SAM ������Ʈ�� ���� Everyone ���� ���� Ȱ��ȭ                                             >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo @ ��ȣ - 8.1 SAM ���� ���� ���� 															   >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::type %COMPUTERNAME%-8-1.log 								   							   >> %COMPUTERNAME%-list.log
::type %COMPUTERNAME%-8-1.log								                                   >> %COMPUTERNAME%-test.log



:8-2
echo ### 8.1 Null Session ����  ##########################################################
echo END#################################################################################  > %COMPUTERNAME%-8-2.log
echo ### 8.1 Null Session ����  ########################################################### >> %COMPUTERNAME%-8-2.log
echo #################################################################################### >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
echo START                                                                                 >> %COMPUTERNAME%-8-2.log
echo �� ���� : �ش� ������Ʈ���� "RestrictAnonymous"���� 2�� �����Ǿ� ������ ��ȣ                                   >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
echo �� ��Ȳ                                                                               >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\LSA\restrictanonymous"           >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\LSA\restrictanonymous" | find /I "2" > nul
IF NOT ERRORLEVEL 1 goto 8-2-good
IF ERRORLEVEL 1 goto 8-2-bad

:8-2-bad
echo. >> %COMPUTERNAME%-8-2.log
echo �� "RestrictAnonymous" ������Ʈ�� ���� ��2���� ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-8-2.log
echo. >> %COMPUTERNAME%-8-2.log
ECHO @ ��� - 8.1 Null Session ���� >> %COMPUTERNAME%-8-2.log | echo @ ��� - 8.1 Null Session ����  >> result.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
type %COMPUTERNAME%-8-2.log 								   							   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-8-2.log 								   							   >> %COMPUTERNAME%-test.log
goto 8-3

:8-2-good
echo. >> %COMPUTERNAME%-8-2.log
echo �� "RestrictAnonymous" ������Ʈ�� ���� ��2���� ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-8-2.log
echo. >> %COMPUTERNAME%-8-2.log
echo @ ��ȣ - 8.1 Null Session ����						   								   >> %COMPUTERNAME%-8-2.log 
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
type %COMPUTERNAME%-8-2.log 								   							   >> %COMPUTERNAME%-test.log



:8-3
echo ### 8.2 Remote Registry ���� ����  ##################################################
echo END################################################################################  > %COMPUTERNAME%-8-3.log
echo ### 8.2 Remote Registry ���� ����  ################################################### >> %COMPUTERNAME%-8-3.log
echo ################################################################################### >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
echo START                                                                                 >> %COMPUTERNAME%-8-3.log
echo �� ���� : Remote Registry Service �� �����Ǿ� ������ ��ȣ                          			   >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
echo �� ��Ȳ                                                                                  >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
net start | find "Remote Registry" > nul
IF ERRORLEVEL 1 GOTO 8-3-good
IF NOT ERRORLEVEL 1 GOTO 8-3-bad


:8-3-bad
ECHO �� Remote Registry Service�� ������Դϴ�.                                       			   >> %COMPUTERNAME%-8-3.log
echo.																					   >> %COMPUTERNAME%-8-3.log
echo �� ���ʿ��� ��� Remote Registry ���� ���� �ǰ� 										  	 >> %COMPUTERNAME%-8-3.log
echo    Remote Registry Service ��� ��/���θ� ��ȣ/����� �Ǻ��մϴ�                     			 >> %COMPUTERNAME%-8-3.log
echo. 																					   >> %COMPUTERNAME%-8-3.log
ECHO @ ��� - 8.2 Remote Registry ���� ���� >> %COMPUTERNAME%-8-3.log | echo @ ��� - 8.2 Remote Registry ���� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
type %COMPUTERNAME%-8-3.log 								   							   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-8-3.log 								                               >> %COMPUTERNAME%-test.log
GOTO 8-4

:8-3-good
echo �� Remote Registry Service�� ��������� �ʽ��ϴ�.                                   		   >> %COMPUTERNAME%-8-3.log
echo.																					   >> %COMPUTERNAME%-8-3.log
echo �� ���ʿ��� ��� Remote Registry ���� ���� �ǰ� 											   >> %COMPUTERNAME%-8-3.log
echo    Remote Registry Service ��� ��/���θ� ��ȣ/����� �Ǻ��մϴ�                    			   >> %COMPUTERNAME%-8-3.log
echo. 																					   >> %COMPUTERNAME%-8-3.log
echo @ ��ȣ - 8.2 Remote Registry ���� ����                                     		       >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
type %COMPUTERNAME%-8-3.log                                                                >> %COMPUTERNAME%-test.log




:8-4
echo ### 8.3 AutoLogon ���� ����  #########################################################
echo END################################################################################  > %COMPUTERNAME%-8-4.log
echo ### 8.3 AutoLogon ���� ����  ########################################################## >> %COMPUTERNAME%-8-4.log
echo ################################################################################### >> %COMPUTERNAME%-8-4.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo START                                                                                 >> %COMPUTERNAME%-8-4.log
echo �� ���� : �ش� ������Ʈ AutoAdminLogon ���� ���ų� 0���� �����Ǿ� ������ ��ȣ                       >> %COMPUTERNAME%-8-4.log

echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo �� ��Ȳ                                                                               >> %COMPUTERNAME%-8-4.log

echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo �� AutoAdminLogon                                                                     >> %COMPUTERNAME%-8-4.log
::%script%\reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" | find /I "AutoAdminLogon" >> %COMPUTERNAME%-8-4.log
%script%\reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" | find /I "AutoAdminLogon" >> %COMPUTERNAME%-8-4.log

::echo.                                                                                      >> %COMPUTERNAME%-8-4.log
::echo �� DefaultUserName                                                                     >> %COMPUTERNAME%-8-4.log
::%script%\reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultUserName" | find /I "DefaultUserName" >> %COMPUTERNAME%-8-4.log
::reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultUserName" | find /I "DefaultUserName" >> %COMPUTERNAME%-8-4.log

echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo �� DefaultPassword                                                                     >> %COMPUTERNAME%-8-4.log
%script%\reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultPassword" | find /I "DefaultPassword"  >> %COMPUTERNAME%-8-4.log

echo.                                                                                      >> %COMPUTERNAME%-8-4.log
%script%\reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" | find /I "AutoAdminLogon" | find "1" > nul
IF ERRORLEVEL 1 goto 8-4-good
IF NOT ERRORLEVEL 1 goto 8-4-bad

:8-4-bad
echo. >> %COMPUTERNAME%-8-4.log
echo �� ��AutoAdminLogon�� ������Ʈ�� ���� ���ų� ��0������ ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-8-4.log
echo. >> %COMPUTERNAME%-8-4.log
ECHO @ ��� - 8.3 AutoLogon ���� ���� >> %COMPUTERNAME%-8-4.log | echo @ ��� - 8.3 AutoLogon ���� ���� >> result.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo END                                                                                   >> %COMPUTERNAME%-8-4.log
type %COMPUTERNAME%-8-4.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-8-4.log                                                                >> %COMPUTERNAME%-test.log
goto IIS start

:8-4-good
echo. >> %COMPUTERNAME%-8-4.log
echo �� ��AutoAdminLogon�� ������Ʈ�� ���� ���ų� ��0������ ����, ������Ʈ�� �߰�/����/���� �� ������Ʈ�� ��� �ǰ� >> %COMPUTERNAME%-8-4.log
echo. >> %COMPUTERNAME%-8-4.log
echo @ ��ȣ - 8.3 AutoLogon ���� ����                                                     >> %COMPUTERNAME%-8-4.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo END                                                                                   >> %COMPUTERNAME%-8-4.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
type %COMPUTERNAME%-8-4.log                                                                >> %COMPUTERNAME%-test.log
goto IIS start




:IIS Start
echo.
echo.
echo.
echo [ IIS ���� ��� ��/�� Ȯ���� ]
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1	GOTO END
IF NOT ERRORLEVEL 1 GOTO IIS


:end-3
	
:IIS

:: IIS Version ���ϱ�
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters" | find /i "version" > iis-version.txt
type iis-version.txt | find /i "major"                                                        > iis-version-major.txt
for /f "tokens=3" %%a in (iis-version-major.txt) do set iis_ver_major=%%a
del iis-version-major.txt 2> nul


:: WebSite List ���ϱ� ( website-list.txt )
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list site | find /i "http"                             > website-list.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs enum W3SVC | find /i "W3SVC" | findstr /i /v "FILTERS APPPOOLS INFO" > website-list.txt
)

:: WebSite Name ���ϱ� ( website-name.txt )
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "tokens=1 delims=(" %%a in (website-list.txt) do (
		for /f "tokens=2-11 delims= " %%b in ("%%a") do (
			echo %%b %%c %%d %%e %%f %%g %%h %%i %%j %%k                                         >> website-name.txt
		)
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	for /f "tokens=1 delims=[]" %%i in (website-list.txt) do (
		cscript %script%\adsutil.vbs enum %%i | findstr /i "ServerComment ServerAutoStart"       >> website-name.txt
		cscript %script%\adsutil.vbs enum %%i/ROOT | find "AppRoot"                              >> website-name.txt
		echo -----------------------------------------------------------------------			 >> website-name.txt
	)
)

:: Web Site physicalpath ���ϱ� ( website-physicalpath.txt )
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list config -section:system.applicationHost/sites | find /i "physicalpath" > website-physicalpath-temp.txt
	for /f "tokens=3 delims= " %%a in (website-physicalpath-temp.txt) do (
		for /f "tokens=2 delims==" %%b in ("%%a") do echo %%~b >> website-physicalpath.txt
	)
	del website-physicalpath-temp.txt 2> nul
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	for /f "tokens=1 delims=[]" %%i in (website-list.txt) do (
		cscript %script%\adsutil.vbs enum %%i/root | find /i "path" | find /i /v "AspEnableParentPaths" >> website-physicalpath-temp.txt
	)
	for /f "tokens=4-8 delims= " %%i in (website-physicalpath-temp.txt) do (
		echo %%i %%j %%k %%l %%m                                                              >> website-physicalpath.txt
	)
	del website-physicalpath-temp.txt 2> nul
)


echo �� IIS ���� ��������� ���� ����
echo.	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo ***************************************************************************************	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo �� IIS ���񽺸� ����ϰ� ����	  >> %COMPUTERNAME%-w.log
echo �� IIS IIS Version %IISV%	>> %COMPUTERNAME%-w.log

::set CODE=W-00
::echo #######################################################################################	>> %COMPUTERNAME%-w.log
::echo IIS ���� ���� ����	>> %COMPUTERNAME%-w.log
::echo #######################################################################################	>> %COMPUTERNAME%-w.log
::net start | find "World Wide Web Publishing" > nul
::IF ERRORLEVEL 1 echo ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
::IF NOT ERRORLEVEL 1 (
::	echo ��� : IIS ���񽺸� ����ϰ� ����	>> %COMPUTERNAME%-w.log
::	echo IIS ���񽺸� ����ϰ� ����
::	echo.	>> %COMPUTERNAME%-w.log
::	net start | find "World Wide Web Publishing"	>> %COMPUTERNAME%-w.log
::)
::echo.	>> %COMPUTERNAME%-w.log
::echo �� ���� : IIS ���񽺰� �ʿ����� ������ ���� ���� ���	>> %COMPUTERNAME%-w.log
::echo.	>> %COMPUTERNAME%-w.log
::echo [%CODE%]
::net start | find "World Wide Web Publishing" > nul
::IF ERRORLEVEL 1 echo [@ ��ȣ	>> %COMPUTERNAME%-w.log
::IF NOT ERRORLEVEL 1 echo [%CODE%] : ����	>> %COMPUTERNAME%-w.log
::echo.	>> %COMPUTERNAME%-w.log

::set windir=C:\Windows

echo.	>> %COMPUTERNAME%-w.log
echo ***************************************************************************************	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-01
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS ���丮 ������ ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : �����丮 �˻����� üũ�Ǿ� ���� ���� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
)

echo. > httpid.txt
echo. > ftpid.txt
echo. > rpath.txt
echo. > httppath.txt
echo. > ftppath.txt
echo. > httpname.txt
echo. > hname.txt
echo. > ftpname.txt
echo. > fname.txt
echo. > hpath.txt
echo. > fpath.txt


echo �� ���� : �����丮 �˻����� üũ�Ǿ� ���� ���� ���	>> %COMPUTERNAME%-w.log
echo.									    	>> %COMPUTERNAME%-w.log

echo [��� ����Ʈ]                                                                           >> %COMPUTERNAME%-w.log
echo -----------------------------------------------------                                   >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %COMPUTERNAME%-w.log
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %COMPUTERNAME%-w.log
)
echo.                                                                                        >> %COMPUTERNAME%-w.log

echo [�⺻ ����]                                                                          >> %COMPUTERNAME%-w.log
echo -----------------------------------------------------                                  >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list config | find /i "directoryBrowse"             >> %COMPUTERNAME%-w.log
	%systemroot%\System32\inetsrv\appcmd list config | find /i "directoryBrowse"             > iis-result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs get W3SVC/EnableDirBrowsing  | find /i /v "Microsoft"      >> %COMPUTERNAME%-w.log
	cscript %script%\adsutil.vbs get W3SVC/EnableDirBrowsing  | find /i /v "Microsoft"      > iis-result.txt
	)
echo.                                                                                        >> %COMPUTERNAME%-w.log

echo.                                                                                        >> %COMPUTERNAME%-w.log
echo *** ����Ʈ�� ���� Ȯ��                                                                  >> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "delims=" %%i in (website-name.txt) do (
		echo [WebSite Name] %%i                                                           >> %COMPUTERNAME%-w.log
		echo -----------------------------------------------------                           >> %COMPUTERNAME%-w.log
		%systemroot%\System32\inetsrv\appcmd list config %%i | find /i "directoryBrowse"       >> %COMPUTERNAME%-w.log
		%systemroot%\System32\inetsrv\appcmd list config %%i | find /i "directoryBrowse"       >> iis-result.txt
		echo.                                                                                >> %COMPUTERNAME%-w.log
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	for /f "tokens=1 delims=[]" %%i in (website-list.txt) do (
		echo [WebSite AppRoot] %%i                                                           >> %COMPUTERNAME%-w.log
		echo -----------------------------------------------------                           >> %COMPUTERNAME%-w.log
		cscript %script%\adsutil.vbs enum %%i/root | find /i "EnableDirBrowsing" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i/root | find /i "EnableDirBrowsing"         >> %COMPUTERNAME%-w.log
			cscript %script%\adsutil.vbs enum %%i/root | find /i "EnableDirBrowsing"         >> iis-result.txt
			echo.                                                                            >> %COMPUTERNAME%-w.log
		) else (
			echo * �⺻ ������ ����Ǿ� ����.                                                >> %COMPUTERNAME%-w.log
			echo.                                                                            >> %COMPUTERNAME%-w.log
		)
	)
)
echo [%CODE%]

type iis-result.txt | find /i "true" > nul
if %errorlevel% equ 0 (
echo.                                                                            >> %COMPUTERNAME%-w.log
echo @ ��ȣ												>> %COMPUTERNAME%-w.log
) else (
echo.                                                                            >> %COMPUTERNAME%-w.log
echo @ ���												>> %COMPUTERNAME%-w.log
)

echo.	>> %COMPUTERNAME%-w.log

::����Ʈ ����Ʈ �̱�
%windir%\system32\inetsrv\appcmd.exe list site	> site_list.txt
%windir%\system32\inetsrv\appcmd.exe list site |find "http"	> http_list.txt
%windir%\system32\inetsrv\appcmd.exe list site |find "ftp"	> ftp_list.txt

:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-02
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS CGI ���� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : CGI ���� ����� �����ϰ� �ִ� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)

echo �� ���� : �ش� ���丮 Everyone�� ��� ����, ���� ����, ���� ������ �ο����� ���� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

echo. > temp.txt 

IF EXIST C:\inetpub\scripts (
	cacls C:\inetpub\scripts >> temp.txt
) ELSE (
	echo C:\inetpub\scripts ���丮�� �������� ���� >> temp.txt
)

IF EXIST C:\inetpub\cgi-bin (
	cacls C:\inetpub\cgi-bin >> temp.txt
) ELSE (
	echo C:\inetpub\cgi-bin ���丮�� �������� ���� >> temp.txt
)

type temp.txt | findstr /i "everyone" > nul
IF NOT ERRORLEVEL 1 (
	echo �� ��� : �ش� ���丮 Everyone�� ��� ����, ���� ����, ���� ������ �ο��Ǿ� ����	>> %COMPUTERNAME%-w.log
	type temp.txt	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	::echo �� ���� : �ش� ���丮 Everyone�� ��� ����, ���� ����, ���� ������ �ο����� ���� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo [%CODE%] : ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
)
IF ERRORLEVEL 1 (
	echo �� ��� : �ش� ���丮 Everyone�� ��� ����, ���� ����, ���� ������ �ο����� ����	>> %COMPUTERNAME%-w.log
	type temp.txt	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	::echo �� ���� : �ش� ���丮 Everyone�� ��� ����, ���� ����, ���� ������ �ο����� ���� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
)


del temp.txt


:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-03
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS ���� ���丮 ���� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : ���� �н� ����� ������ ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)


echo �� ���� : ���� �н� ����� ������ ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

echo [��� ����Ʈ]                                                                           >> %COMPUTERNAME%-w.log
echo -----------------------------------------------------                                   >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %COMPUTERNAME%-w.log
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %COMPUTERNAME%-w.log
)
echo.                                                                                        >> %COMPUTERNAME%-w.log

echo [�⺻ ����]                                                                             >> %COMPUTERNAME%-w.log
echo -----------------------------------------------------                                   >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list config /section:asp | find /i "enableParentPaths" > nul
	IF NOT ERRORLEVEL 1 (
		%systemroot%\System32\inetsrv\appcmd list config /section:asp | find /i "enableParentPaths" >> %COMPUTERNAME%-w.log
		%systemroot%\System32\inetsrv\appcmd list config /section:asp | find /i "enableParentPaths" > iis-result.txt
	) ELSE (
		echo * ������ ���� * �⺻���� : enableParentPaths=false                              >> %COMPUTERNAME%-w.log
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs get W3SVC/AspEnableParentPaths  | find /i /v "Microsoft"    >> %COMPUTERNAME%-w.log
	cscript %script%\adsutil.vbs get W3SVC/AspEnableParentPaths  | find /i /v "Microsoft"    > iis-result.txt
)
echo.                                                                                        >> %COMPUTERNAME%-w.log

echo.                                                                                        >> %COMPUTERNAME%-w.log
echo *** ����Ʈ�� ���� Ȯ��                                                                  >> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "delims=" %%i in (website-name.txt) do (
		%systemroot%\System32\inetsrv\appcmd list config %%i /section:asp | find /i "enableParentPaths" > nul
		echo [WebSite Name] %%i                                                            >> %COMPUTERNAME%-w.log
		echo -----------------------------------------------------                            >> %COMPUTERNAME%-w.log
		if not errorlevel 1 (
			%systemroot%\System32\inetsrv\appcmd list config %%i /section:asp | find /i "enableParentPaths" >> %COMPUTERNAME%-w.log
			%systemroot%\System32\inetsrv\appcmd list config %%i /section:asp | find /i "enableParentPaths" >> iis-result.txt
			echo.                                                                             >> %COMPUTERNAME%-w.log
		) else (
			echo * ������ ���� * �⺻���� : enableParentPaths=false                          >> %COMPUTERNAME%-w.log
			echo.                                                                            >> %COMPUTERNAME%-w.log
		)
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	for /f "tokens=1 delims=[]" %%i in (website-list.txt) do (
		echo [WebSite AppRoot] %%i                                                          >> %COMPUTERNAME%-w.log
		echo -----------------------------------------------------                          >> %COMPUTERNAME%-w.log
		cscript %script%\adsutil.vbs enum %%i/root | find /i "AspEnableParentPaths" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i/root | find /i "AspEnableParentPaths"     >> %COMPUTERNAME%-w.log
			cscript %script%\adsutil.vbs enum %%i/root | find /i "AspEnableParentPaths"     >> iis-result.txt
			echo.                                                                           >> %COMPUTERNAME%-w.log
		) else (
			echo AspEnableParentPaths : * �⺻ ������ ����Ǿ� ����.                         >> %COMPUTERNAME%-w.log
			echo.                                                                            >> %COMPUTERNAME%-w.log
		)
	)
)

echo [%CODE%]

type iis-result.txt | find /i "true" > nul
if %errorlevel% equ 0 (
echo.                                                                            >> %COMPUTERNAME%-w.log
echo @ ��ȣ											   	>> %COMPUTERNAME%-w.log
) else (
echo.                                                                            >> %COMPUTERNAME%-w.log
echo @ ���												>> %COMPUTERNAME%-w.log
)





:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-04
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS �����μ��� ���� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : �� ���μ����� �� ���� ��� �ʿ��� �ּ��� �������� �����Ǿ� �ִ� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)
echo �� ���� : �� ���μ����� �� ���� ��� �ʿ��� �ּ��� �������� �����Ǿ� �ִ� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

echo [IISADMIN] > temp.txt
%script%\reg query HKLM\SYSTEM\ControlSet001\services\IISADMIN\ObjectName >> temp.txt
echo. >> temp.txt
echo [World Wide Web Publishing] >> temp.txt
%script%\reg query HKLM\SYSTEM\ControlSet001\services\W3SVC\ObjectName >> temp.txt
type temp.txt | findstr /i "LocalSystem" > nul
IF NOT ERRORLEVEL 1 echo �� ��� : LocalSystem(�⺻����)���� �۵��ϰ� ����	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo �� ��� : IIS�� ������ �̿��Ͽ� �۵��ϰ� ����	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
type temp.txt	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
::echo �� ���� : �� ���μ����� �� ���� ��� �ʿ��� �ּ��� �������� �����Ǿ� �ִ� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
type temp.txt | findstr /i "LocalSystem" > nul
IF NOT ERRORLEVEL 1 echo @ ���	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo @ ��ȣ	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
del temp.txt
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-05
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS ��ũ ��� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : �ɺ��� ��ũ, aliases, �ٷΰ��� ���� ����� ������� �ʴ� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)

echo �� ���� : �ɺ��� ��ũ, aliases, �ٷΰ��� ���� ����� ������� �ʴ� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

echo. > link.txt
for /F "tokens=1" %%i in (hpath.txt) do DIR /s %%i	>> link.txt
type link.txt | findstr "SYMLINK" > link.txt
type link.txt | findstr "SYMLINK" > nul
IF ERRORLEVEL 1 echo �� ��� : �ɺ��� ��ũ, aliases, �ٷΰ��� ���� ������ �������� ����	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 (
	echo �� ��� : �ɺ��� ��ũ, aliases, �ٷΰ��� ���� ������ �����ϰ� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	type link.txt	>> %COMPUTERNAME%-w.log
)
type link.txt	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
::echo �� ���� : �ɺ��� ��ũ, aliases, �ٷΰ��� ���� ����� ������� �ʴ� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
type link.txt | findstr ".lnk" > nul
IF ERRORLEVEL 1 echo @ ��ȣ	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 echo @ ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
del link.txt
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-06
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS ���� ���ε� �� �ٿ�ε� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : �� ���μ����� ���� �ڿ� ������ ���� ���ε� �� �ٿ�ε� �뷮�� �����ϴ� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
)

echo �� ���� : �� ���μ����� ���� �ڿ� ������ ���� ���ε� �� �ٿ�ε� �뷮�� �����ϴ� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

echo [��� ����Ʈ]                                                                        >> %COMPUTERNAME%-w.log
echo -----------------------------------------------------                                    >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %COMPUTERNAME%-w.log
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %COMPUTERNAME%-w.log
)
echo.                                                                                        >> %COMPUTERNAME%-w.log

echo [�⺻ ����]                                                                          >> %COMPUTERNAME%-w.log
echo -----------------------------------------------------                                  >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list config | findstr /i "maxAllowedContentLength maxRequestEntityAllowed bufferingLimit" >> %COMPUTERNAME%-w.log
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs enum W3SVC | findstr /i "AspMaxRequestEntityAllowed AspBufferingLimit" >> %COMPUTERNAME%-w.log
)
echo * ���� ���� ��� �⺻ ������ ����Ǿ� ����.                                             >> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log

echo.                                                                                        >> %COMPUTERNAME%-w.log
echo *** ����Ʈ�� ���� Ȯ��                                                                  >> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "delims=" %%a in (website-name.txt) do (
		echo [WebSite Name] %%a                                                              >> %COMPUTERNAME%-w.log
		echo -----------------------------------------------------                            >> %COMPUTERNAME%-w.log
		%systemroot%\System32\inetsrv\appcmd list config %%a | findstr /i "maxAllowedContentLength maxRequestEntityAllowed bufferingLimit" >> %COMPUTERNAME%-w.log
		echo * ���� ���� ��� �⺻ ������ ����Ǿ� ����.                                     >> %COMPUTERNAME%-w.log
		echo.                                                                                >> %COMPUTERNAME%-w.log
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	for /f "tokens=1 delims=[]" %%i in (website-list.txt) do (
		echo [WebSite AppRoot] %%i                                                           >> %COMPUTERNAME%-w.log
		echo -----------------------------------------------------                           >> %COMPUTERNAME%-w.log
		cscript %script%\adsutil.vbs enum %%i | find /i "AspMaxRequestEntityAllowed" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i | find /i "AspMaxRequestEntityAllowed"  >> %COMPUTERNAME%-w.log
		) else (
			echo AspMaxRequestEntityAllowed : * �⺻ ������ ����Ǿ� ����.                  >> %COMPUTERNAME%-w.log
		)
		cscript %script%\adsutil.vbs enum %%i | find /i "AspBufferingLimit" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i | find /i "AspBufferingLimit"           >> %COMPUTERNAME%-w.log
			echo.                                                                            >> %COMPUTERNAME%-w.log
		) else (
			echo AspBufferingLimit          : * �⺻ ������ ����Ǿ� ����.                  >> %COMPUTERNAME%-w.log
			echo.                                                                            >> %COMPUTERNAME%-w.log
		)
	)
)

echo [%CODE%]

echo.                                                                                   >> %COMPUTERNAME%-w.log
echo @ ��ȣ												>> %COMPUTERNAME%-w.log

::del flag.txt
::del updown.txt
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-07
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS DB ���� ����� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ���� : .asa ������ �����ϴ� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
)

echo. > flag.txt
echo. > flag2.txt
echo. > id.txt
echo. > id2.txt

echo �� ���� : .asa ������ �����ϴ� ���	>> %COMPUTERNAME%-w.log
echo TIP : �Ʒ��� 2���� �׸��� �Ѱ����� ������ �Ǿ����� ��� ��ȣ	>> %COMPUTERNAME%-w.log
echo 1. ��û���͸��� �ش� Ȯ���� false ���� >> %COMPUTERNAME%-w.log
echo 2. ó���� ���ο� �ش� Ȯ���� ��ϵ��� ����	>> %COMPUTERNAME%-w.log
echo �ɼ��� �����Ǿ� ���� ���� ��� ����Ʈ�� ��µ�	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log


%windir%\system32\inetsrv\appcmd list config /section:requestFiltering | findstr -i ".asa""" | findstr -i "false"	> nul
IF NOT ERRORLEVEL 1 %windir%\system32\inetsrv\appcmd list config /section:requestFiltering | findstr -i ".asax""" | findstr -i "false"	> nul
IF NOT ERRORLEVEL 1 echo true > flag2.txt
IF ERRORLEVEL 1 echo root > id.txt

%windir%\system32\inetsrv\appcmd list config /section:handlers | findstr -i ".asa" > nul
IF NOT ERRORLEVEL 1 echo root > id2.txt
IF ERRORLEVEL 1 echo true >> flag2.txt

type flag2.txt | findstr -i "true" > nul
IF ERRORLEVEL 1 echo false >> flag.txt


for /F "tokens=1 delims=) skip=1" %%i in (hname.txt) do (
	echo. > flag2.txt
	%windir%\system32\inetsrv\appcmd list config %%i /section:requestFiltering | findstr -i ".asa""" | findstr -i "false"	> nul
	IF ERRORLEVEL 1 echo %%i >> id.txt
	IF NOT ERRORLEVEL 1 (
		%windir%\system32\inetsrv\appcmd list config %%i /section:requestFiltering | findstr -i ".asax" | findstr -i "false"	> nul
		IF NOT ERRORLEVEL 1 echo true > flag2.txt
		IF ERRORLEVEL 1 echo %%i >> id.txt
	)
	

	%windir%\system32\inetsrv\appcmd list config %%i /section:handlers | findstr -i ".asa" > nul
	IF ERRORLEVEL 1 echo true > flag2.txt
	IF NOT ERRORLEVEL 1 echo %%i >> id2.txt
	

	type flag2.txt | findstr -i "true" > nul
	IF ERRORLEVEL 1 echo false >> flag.txt
)




type flag.txt | findstr /i "false" > NUL
IF ERRORLEVEL 1 (
	echo �� ��� : .asa ������ �������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [�⺻ ����] >> %COMPUTERNAME%-w.log
	echo --��û���͸�--	>> %COMPUTERNAME%-w.log
	%windir%\system32\inetsrv\appcmd list config /section:requestFiltering | findstr -i ".asa"""  >> %COMPUTERNAME%-w.log
	%windir%\system32\inetsrv\appcmd list config /section:requestFiltering | findstr -i ".asax"""  >> %COMPUTERNAME%-w.log
	echo --ó���� ����--	>> %COMPUTERNAME%-w.log
	%windir%\system32\inetsrv\appcmd list config /section:handlers | findstr -i ".asa" >> %COMPUTERNAME%-w.log
	
	echo.	>> %COMPUTERNAME%-w.log
	echo [����Ʈ�� ����]  >> %COMPUTERNAME%-w.log
	echo --��û���͸�--	>> %COMPUTERNAME%-w.log
	::for /F "tokens=1 delims=) skip=1" %%i in (hname.txt) do (
	for /F "tokens=1 delims=) skip=1" %%i in (website-name.txt) do (
		echo ����Ʈ�� : %%i  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:requestFiltering | findstr -i ".asa"""  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:requestFiltering | findstr -i ".asax"""  >> %COMPUTERNAME%-w.log
	)
	echo --ó���� ����--	>> %COMPUTERNAME%-w.log
	::for /F "tokens=1 delims=) skip=1" %%i in (hname.txt) do (
	for /F "tokens=1 delims=) skip=1" %%i in (website-name.txt) do (
		echo ����Ʈ�� : %%i  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config /section:handlers | findstr -i ".asa"	>> %COMPUTERNAME%-w.log
	)
	
	echo.	>> %COMPUTERNAME%-w.log
	::echo �� ���� : .asa ������ �����ϴ� ���	>> %COMPUTERNAME%-w.log
	::echo TIP : �Ʒ��� 2���� �׸��� �Ѱ����� ������ �Ǿ����� ��� ��ȣ	>> %COMPUTERNAME%-w.log
	::echo 1. ��û���͸��� �ش� Ȯ���� false ���� >> %COMPUTERNAME%-w.log
	::echo 2. ó���� ���ο� �ش� Ȯ���� ��ϵ��� ����	>> %COMPUTERNAME%-w.log
	::echo �ɼ��� �����Ǿ� ���� ���� ��� ����Ʈ�� ��µ�	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
)
type flag.txt | findstr /i "false" > NUL
IF NOT ERRORLEVEL 1 (
	echo �� ��� : .asa ������ �����ϰ� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ��� ����Ʈ	>> %COMPUTERNAME%-w.log
	type id.txt | findstr "root" > nul
	IF ERRORLEVEL 1 type id2.txt | findstr "root" > nul
	IF NOT ERRORLEVEL 1 (
		echo [�⺻ ����] >> %COMPUTERNAME%-w.log
		type id.txt | findstr "root" > nul
		IF NOT ERRORLEVEL 1 (
			echo --��û���͸�--	>> %COMPUTERNAME%-w.log
			%windir%\system32\inetsrv\appcmd list config /section:requestFiltering | findstr -i ".asa"""	>> %COMPUTERNAME%-w.log
			%windir%\system32\inetsrv\appcmd list config /section:requestFiltering | findstr -i ".asax"""	>> %COMPUTERNAME%-w.log
		)
		type id2.txt | findstr "root" > nul
		IF NOT ERRORLEVEL 1 (
			echo --ó���� ����--	>> %COMPUTERNAME%-w.log
			%windir%\system32\inetsrv\appcmd list config /section:handlers | findstr -i ".asa"	>> %COMPUTERNAME%-w.log
		)
	)
	echo.	>> %COMPUTERNAME%-w.log
	echo [����Ʈ�� ����] >> %COMPUTERNAME%-w.log
	echo --��û���͸� ������ ����Ʈ--	>> %COMPUTERNAME%-w.log
	for /F "tokens=1 skip=1" %%i in (id.txt) do (
		echo ����Ʈ�� : %%i  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:requestFiltering | findstr -i ".asa"""  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:requestFiltering | findstr -i ".asax"""  >> %COMPUTERNAME%-w.log
	)
	echo --ó���� ���� ��ϵ� ����Ʈ--	>> %COMPUTERNAME%-w.log
	for /F "tokens=1 skip=1" %%i in (id2.txt) do (
		echo ����Ʈ�� : %%i  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:handlers | findstr -i ".asa"	>> %COMPUTERNAME%-w.log
	)
	echo.	>> %COMPUTERNAME%-w.log
	::echo �� ���� : .asa ������ �����ϴ� ���	>> %COMPUTERNAME%-w.log
	::echo TIP : �Ʒ��� 2���� �׸��� �Ѱ����� ������ �Ǿ����� ��� ��ȣ	>> %COMPUTERNAME%-w.log
	::echo 1. ��û���͸��� �ش� Ȯ���� false ���� >> %COMPUTERNAME%-w.log
	::echo 2. ó���� ���ο� �ش� Ȯ���� ��ϵ��� ����	>> %COMPUTERNAME%-w.log
	::echo �ɼ��� �����Ǿ� ���� ���� ��� ����Ʈ�� ��µ�	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
)


del flag.txt
del flag2.txt
del id.txt
del id2.txt

:noIIS

echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-08
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS ���������� ACL ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : Ȩ ���丮 ���� �ִ� ���� ���ϵ鿡 ���� Everyone ������ �������� �ʴ� ��� >> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
)

echo �� ���� : Ȩ ���丮 ���� �ִ� ���� ���ϵ鿡 ���� Everyone ������ �������� �ʴ� ��� >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

::��Ʈ���� �� ���������� �ش�Ȯ���� ���� ��� ����
echo. > abc.txt
for /F "tokens=1 skip=1" %%a in (hpath.txt) do (
	echo %%a >> abc.txt
	dir %%a /s/b | findstr ".exe .dll .cmd .pl .asp" >> abc.txt
)
::������ Ȯ���������� ��ȯ Ȯ��
echo. > acl.txt
for /F "tokens=1 skip=1" %%b in (abc.txt) do (
	cacls %%b | findstr /i "everyone" > nul
	if not errorlevel 1 (
		echo %%b >> acl.txt
		cacls %%b | findstr /i "everyone" >> acl.txt
	)
)

type acl.txt | findstr /i "Everyone" > nul
if NOT errorlevel 1 (
	echo �� ��� : Ȩ ���丮 ���� �ִ� ���� ���ϵ鿡 ���� Everyone ������ �����ϰ� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo everyone ���� ������ �ִ� ���	>> %COMPUTERNAME%-w.log
	type acl.txt >> %COMPUTERNAME%-w.log
	echo acl.txt >> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	::echo �� ���� : Ȩ ���丮 ���� �ִ� ���� ���ϵ鿡 ���� Everyone ������ �������� �ʴ� ��� >> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ���	>> %COMPUTERNAME%-w.log	
	echo.	>> %COMPUTERNAME%-w.log
)
if errorlevel 1 (
	ECHO �� ��� : Ȩ ���丮 ���� �ִ� ���� ���ϵ鿡 ���� Everyone ������ �������� ����	>> %COMPUTERNAME%-w.log	
	echo.	>> %COMPUTERNAME%-w.log
	for /F "tokens=1 skip=1" %%a in (hpath.txt) do (
		echo %%a >> %COMPUTERNAME%-w.log 
		cacls %%a >> %COMPUTERNAME%-w.log
	)
	echo.	>> %COMPUTERNAME%-w.log
	::echo �� ���� : Ȩ ���丮 ���� �ִ� ���� ���ϵ鿡 ���� Everyone ������ �������� �ʴ� ��� >> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	ECHO [%CODE%]
	ECHO @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
)

del abc.txt
del acl.txt
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-09
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS �̻�� ��ũ��Ʈ ���� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : ����� ����.htr, .idc, .stm, .shtm, .shtml, .printer, .htw, .ida, .idq�� �����ϴ� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
)

echo �� ���� : ����� ����(.htr, .idc, .stm, .shtm, .shtml, .printer, .htw, .ida, .idq)�� �����ϴ� ���	>> %COMPUTERNAME%-w.log
echo TIP : ����Ʈ �ɼ��ϰ�� ���� ������ �ʰ�, �����	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo. > script.txt
echo. > flag.txt
echo. > id.txt

%script%\adsutil.vbs enum W3SVC | findstr "\.htr \.idc \.stm \.shtm \.shtml \.printer \.htw \.ida \.idq" > nul
IF NOT ERRORLEVEL 1 echo false >> flag.txt

::for /F "tokens=1 delims=) skip=1" %%i in (hname.txt) DO (
for /F "tokens=1 delims=) skip=1" %%i in (website-name.txt) DO (
	%windir%\system32\inetsrv\appcmd list config %%i /section:handlers | findstr /i "\.htr \.idc \.stm \.shtm \.shtml \.printer \.htw \.ida \.idq" > nul
	IF NOT ERRORLEVEL 1 (
		echo false >> flag.txt
		echo %%i >> id.txt
	)
)


type flag.txt | findstr /i "false" > NUL
IF ERRORLEVEL 1 (
	echo �� ��� : ����� ������ �������� ����	>> %COMPUTERNAME%-w.log	
	echo.	>> %COMPUTERNAME%-w.log
	echo [�⺻ ����] 	>> %COMPUTERNAME%-w.log
	%windir%\system32\inetsrv\appcmd list config /section:handlers	>> %COMPUTERNAME%-w.log
	echo [����Ʈ�� ����] 	>> %COMPUTERNAME%-w.log
	::for /F "tokens=1 delims=) skip=1" %%i in (hname.txt) DO (
	for /F "tokens=1 delims=) skip=1" %%i in (website-name.txt) DO (
		echo ����Ʈ�� : %%i	>> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:handlers	>> %COMPUTERNAME%-w.log
	)
) ELSE (
	echo �� ��� : ����� ������ �����ϰ� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ��� ����Ʈ	>> %COMPUTERNAME%-w.log
	cscript %script%\adsutil.vbs enum W3SVC | findstr "\.htr \.idc \.stm \.shtm \.shtml \.printer \.htw \.ida \.idq" > nul
	IF NOT ERRORLEVEL 1 (
		echo [�⺻ ����] >> %COMPUTERNAME%-w.log
		cscript %script%\adsutil.vbs enum W3SVC | findstr "\.htr \.idc \.stm \.shtm \.shtml \.printer \.htw \.ida \.idq" >> %COMPUTERNAME%-w.log
	)
	type id.txt | findstr "0 1 2 3 4 5 6 7 8 9 0 a b c d e f g h i j k l m n o" > nul
	IF NOT ERRORLEVEL 1 (
		echo [����Ʈ�� ����] >> %COMPUTERNAME%-w.log
		for /F "tokens=1  skip=1" %%i in (id.txt) DO (
			echo ����Ʈ�� : %%i	>> %COMPUTERNAME%-w.log
			%windir%\system32\inetsrv\appcmd list config %%i /section:handlers | findstr /i "\.htr \.idc \.stm \.shtm \.shtml \.printer \.htw \.ida \.idq"	>> %COMPUTERNAME%-w.log
		)
	)
)
echo.	>> %COMPUTERNAME%-w.log
::echo �� ���� : ����� ����(.htr, .idc, .stm, .shtm, .shtml, .printer, .htw, .ida, .idq)�� �����ϴ� ���	>> %COMPUTERNAME%-w.log
::echo TIP : ����Ʈ �ɼ��ϰ�� ���� ������ �ʰ�, �����	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
type flag.txt | findstr /i "false" > NUL
IF  ERRORLEVEL 1 echo @ ��ȣ	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 echo @ ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log



del script.txt
del flag.txt
del id.txt
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-10
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] FTP ���� ���� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
echo �� ���� : FTP ���񽺸� ������� �ʴ� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
net start | find "Microsoft FTP Service" > nul      
IF ERRORLEVEL 1 net start | find "FTP Publishing Service" > nul
IF ERRORLEVEL 1 echo �� ��� : FTP ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 (
	echo �� ��� : FTP ���񽺸� ����ϰ� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	net start | find "Microsoft FTP Service"	>> %COMPUTERNAME%-w.log
	net start | find "FTP Publishing Service"	>> %COMPUTERNAME%-w.log
)
echo.	>> %COMPUTERNAME%-w.log
::echo �� ���� : FTP ���񽺸� ������� �ʴ� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
net start | find "Microsoft FTP Service" > nul      
IF ERRORLEVEL 1 net start | find "FTP Publishing Service" > nul   
IF ERRORLEVEL 1 echo @ ��ȣ	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 echo @ ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-11
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] FTP ���丮 ���� ���� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "Microsoft FTP Service" > nul
IF ERRORLEVEL 1 net start | find "FTP Publishing Service" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : FTP Ȩ ���丮�� Everyone ������ ���� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : FTP ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noFTP	
)
echo �� ���� : FTP Ȩ ���丮�� Everyone ������ ���� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo. > ftpdir.txt
for /F "tokens=1 skip=1" %%i in (fpath.txt) do cacls %%i	>> ftpdir.txt
type ftpdir.txt | find /I "Everyone" > nul
if NOT errorlevel 1 (
	echo �� ��� : Ȩ ���丮�� Everyone ������ �����ϰ� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo everyone ���� ������ �ִ� ���	>> %COMPUTERNAME%-w.log
	for /F "tokens=1 skip=1" %%i in (fpath.txt) do (
		cacls %%i 	> test.txt
		type test.txt | find "Everyone"
		echo %%i	>> %COMPUTERNAME%-w.log
	)
	del test.txt
	echo.	>> %COMPUTERNAME%-w.log
	::echo �� ���� : FTP Ȩ ���丮�� Everyone ������ ���� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ���	>> %COMPUTERNAME%-w.log	
	echo.	>> %COMPUTERNAME%-w.log	
	GOTO  W-38-END
)	


ECHO �� ��� : Ȩ ���丮�� Everyone ������ �������� ����	>> %COMPUTERNAME%-w.log	
echo.	>> %COMPUTERNAME%-w.log
type ftpdir.txt	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
::echo �� ���� : FTP Ȩ ���丮�� Everyone ������ ���� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
ECHO [%CODE%]
ECHO @ ��ȣ	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

:W-38-END
del ftpdir.txt
:noFTP

:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-12
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] Anonymous FTP ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "Microsoft FTP Service" > nul
IF ERRORLEVEL 1 net start | find "FTP Publishing Service" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : FTP ���񽺸� ������� �ʰų�, ���͸� ���� ��롱�� üũ���� ���� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : FTP ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noFTP	
)
echo �� ���� : FTP ���񽺸� ������� �ʰų�, ���͸� ���� ��롱�� üũ���� ���� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
%windir%\system32\inetsrv\appcmd list config | findstr "anony" | findstr -v "userName" | find "false" > nul
IF ERRORLEVEL 1 echo �� ��� : �͸� ������ ������ ��� �ϰ� ����	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 echo �� ��� : �͸� ������ ������ ��� ���� ����	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
%windir%\system32\inetsrv\appcmd list config | findstr "anony" | findstr -v "userName"	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
::echo �� ���� : FTP ���񽺸� ������� �ʰų�, ���͸� ���� ��롱�� üũ���� ���� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
%windir%\system32\inetsrv\appcmd list config | findstr "anony" | findstr -v "userName" | find "false" > nul
IF ERRORLEVEL 1 echo @ ���	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 echo @ ��ȣ	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

:noFTP
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-13
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] FTP ���� ���� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "Microsoft FTP Service" > nul
IF ERRORLEVEL 1 net start | find "FTP Publishing Service" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : Ư�� IP �ּҿ����� FTP ������ �����ϵ��� �������� ������ ������ ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : FTP ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noFTP	
)
echo �� ���� : Ư�� IP �ּҿ����� FTP ������ �����ϵ��� �������� ������ ������ ���	>> %COMPUTERNAME%-w.log
echo TIP : allowUnlisted="false" �ϰ�� ��� IP �̿��� ��� IP ���� "true"�ϰ�� ��� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo. > ftpsecurity.txt
for /F "tokens=1 skip=1" %%i in (fname.txt) do %windir%\system32\inetsrv\appcmd list config %%i /section:ipSecurity	| find /i "allowunlisted" >> ftpsecurity.txt
type ftpsecurity.txt | find "false" > nul
IF NOT ERRORLEVEL 1 echo �� ��� : Ư�� IP �ּҿ����� FTP ������ �����ϵ��� �������� ������ �����ϰ� ����	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo �� ��� : Ư�� IP �ּҿ����� FTP ������ �����ϵ��� �������� ������ �������� ����	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
type ftpsecurity.txt | find "false" > nul
IF ERRORLEVEL 1 echo ���� ��� ���� ���� FTP ����	>> %COMPUTERNAME%-w.log
for /F "tokens=1 skip=1" %%i in (fname.txt) do (
	%windir%\system32\inetsrv\appcmd list config %%i /section:ipSecurity > test.txt
	type test.txt | find "false" > nul
	IF ERRORLEVEL 1 echo %%i	>> %COMPUTERNAME%-w.log
	type test.txt | find /i "allowUnlisted"	>> %COMPUTERNAME%-w.log
	del test.txt
	echo.	>> %COMPUTERNAME%-w.log
)

::echo �� ���� : Ư�� IP �ּҿ����� FTP ������ �����ϵ��� �������� ������ ������ ���	>> %COMPUTERNAME%-w.log
::echo TIP : allowUnlisted="false" �ϰ�� ��� IP �̿��� ��� IP ���� "true"�ϰ�� ��� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
type ftpsecurity.txt | find "false" > nul
IF NOT ERRORLEVEL 1 echo @ ��ȣ	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo @ ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

del ftpsecurity.txt

:noFTP
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-14
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS �� ���� ���� ����	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : �� ���� ���� �������� ������ �����Ǿ� �ִ� ���	>> %COMPUTERNAME%-w.log
	echo TIP : %SystemDrive%\inetpub\custerr ����Ʈ ����̿��� ������ ���ð�� ��ȣ �׿ܿ��� ���ͺ� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)

::echo. [IIS ��� Ȯ��]                                                                      >> %COMPUTERNAME%-w.log
::IF NOT ERRORLEVEL 1 (
::	echo ---------------------------------HTTP Banner-------------------------------------       >> %COMPUTERNAME%-w.log
::	cscript %script%\http_banner.vbs > http_banner.txt
::	type http_banner.txt								>> %COMPUTERNAME%-w.log 2>nul
::	echo ---------------------------------------------------------------------------------       >> %COMPUTERNAME%-w.log
::	del http_banner.txt 2>nul
::)	ELSE (
::	ECHO �� IIS Service Disable                                                                >> %COMPUTERNAME%-w.log
::)
echo �� ���� : �� ���� ���� �������� ������ �����Ǿ� �ִ� ���										>> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log
echo [��� ����Ʈ]                                                                        	>> %COMPUTERNAME%-w.log
echo -----------------------------------------------------                                    >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %COMPUTERNAME%-w.log
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %COMPUTERNAME%-w.log
)
echo.                                                                                        >> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log
echo [�⺻ ����]                                                                            >> %COMPUTERNAME%-w.log
echo -----------------------------------------------------                                    >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	::%systemroot%\System32\inetsrv\APPCMD list config | findstr "<error"                          >> %COMPUTERNAME%-w.log
	%windir%\system32\inetsrv\appcmd list config /section:httperrors						>> %COMPUTERNAME%-w.log
)

:: iis ver <= 6
if %iis_ver_major% leq 6 (
cscript %script%\adsutil.vbs enum W3SVC | findstr "400, 401, 403, 404, 500,"                 >> %COMPUTERNAME%-w.log
)
echo.                                                                                        >> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log
echo. > iis-result.txt
echo *** ����Ʈ�� ���� Ȯ��                                                                  >> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "delims=" %%i in (website-name.txt) do (
			echo [WebSite Name] %%i                                          						>> %COMPUTERNAME%-w.log
			echo ---------------------------------------------------------------                     >> %COMPUTERNAME%-w.log
			::%systemroot%\System32\inetsrv\appcmd list config %%i | findstr "<error" 				>> %COMPUTERNAME%-w.log
			%windir%\system32\inetsrv\appcmd list config %%i /section:httperrors 				>> %COMPUTERNAME%-w.log
			%windir%\system32\inetsrv\appcmd list config %%i /section:httperrors				>> iis-result.txt
			echo.                                                                                    >> %COMPUTERNAME%-w.log
	)
)

:: iis ver <= 6
if %iis_ver_major% leq 6 (
	FOR /F "tokens=1 delims=[]" %%i in (website-list.txt) do (
		echo [WebSite AppRoot] %%i                                                                 >> %COMPUTERNAME%-w.log
		echo -----------------------------------------------------------------------               >> %COMPUTERNAME%-w.log
		cscript %script%\adsutil.vbs enum %%i/root | findstr "400, 401, 403, 404, 500," > nul
		IF NOT ERRORLEVEL 1 (
			cscript %script%\adsutil.vbs enum %%i/root | findstr "400, 401, 403, 404, 500,"          >> %COMPUTERNAME%-w.log
			echo.                                                                                    >> %COMPUTERNAME%-w.log
		) ELSE (
			echo �⺻ ������ ����Ǿ� ����.                                                          >> %COMPUTERNAME%-w.log
			echo.                                                                                    >> %COMPUTERNAME%-w.log
		)
	)
)
echo.                                                                                    >> %COMPUTERNAME%-w.log
type iis-result.txt | find /i "inetpub\custerr" > nul
IF NOT ERRORLEVEL 1 echo @ ���	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo @ ��ȣ	>> %COMPUTERNAME%-w.log

:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-21
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS WebDAV ��Ȱ��ȭ	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo �� ���� : WebDAV�� ���� �Ǿ� �ִ� ���	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo �� ��� : IIS ���񽺸� ������� ����	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ ��ȣ	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)
echo �� ���� : WebDAV�� ���� �Ǿ� �ִ� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
type %systemroot%\system32\inetsrv\config\applicationHost.config | findstr "add path" | findstr -i "WebDAV" | findstr "allowed" > dav.txt
type dav.txt | find "true" > nul
IF NOT ERRORLEVEL 1 echo �� ��� : WebDAV�� �������� ����	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo �� ��� : WebDAV�� �����Ǿ� ����	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
type dav.txt	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
::echo �� ���� : WebDAV�� ���� �Ǿ� �ִ� ���	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
type dav.txt | find "true" > nul
IF NOT ERRORLEVEL 1 echo @ ���	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo @ ��ȣ	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

del dav.txt

:noIIS
type %COMPUTERNAME%-w.log                                                                >> %COMPUTERNAME%-test.log
goto end



:END
echo END_RESULT							    											>> %COMPUTERNAME%-test.log
echo.							    											>> %COMPUTERNAME%-test.log
echo �� End Time                                                                           >> %COMPUTERNAME%-test.log
date /t                                                                                    >> %COMPUTERNAME%-test.log
time /t                                                                                    >> %COMPUTERNAME%-test.log
echo.
echo.
type %JOYSEC%\result.log
for /f "tokens=3 delims= " %%a in ('find /c "@" %JOYSEC%\not-apply.log') do set na=%%a
for /f "tokens=3 delims= " %%a in ('find /c "@" %JOYSEC%\result.log') do set bad=%%a
set /a sum=30-%na%
set /a good=%sum%-%bad%
set /a good=%good%*100
set /a score=%good%/%sum%
set percent=%%%
echo.
echo.
echo ###################################################################################
echo ########################################################### ���� �ؼ��� : %score% �� ##
echo ###################################################################################
echo.

echo ###################################################################################
echo ##                           ���� ������ �Ϸ�Ǿ����ϴ� !!                       ##
echo ###################################################################################
echo.
echo. 	>> %COMPUTERNAME%-test.log
echo ################################################################################### 	>> %COMPUTERNAME%-test.log
echo ############################################################ ���� �ؼ��� : %score% �� ## 	>> %COMPUTERNAME%-test.log
echo ################################################################################### 	>> %COMPUTERNAME%-test.log

@echo off
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
type %JOYSEC%\result.log                                                                   > %COMPUTERNAME%.log
echo.                                                                                   
type %JOYSEC%\not-apply.log                                                               >> %COMPUTERNAME%.log
echo.
::type %COMPUTERNAME%-list.log                                                               >> %COMPUTERNAME%.log
echo.
type %COMPUTERNAME%-test.log                                                               >> %COMPUTERNAME%.log

::echo %date% | findstr /I "�� ȭ �� �� �� �� �� Mon Tue Wed Thu Fri Sat Sun" > nul
::IF NOT ERRORLEVEL 1 SET /a date1=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
::IF NOT ERRORLEVEL 1 SET date1=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
::IF ERRORLEVEL 1 set date1=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%


::�ѱ� (ex) 2020-03-31
date /t | findstr /I "[-]" | findstr /I "^[0-9]" > nul
IF NOT ERRORLEVEL 1 goto KRDATE

::���� (ex) Tue 03/31/2020
date /t | findstr /I "[/]" | findstr /I "^[A-Z]" > nul
IF NOT ERRORLEVEL 1 goto EN1DATE

::���� (ex) 03/31/2020 Tue 
date /t | findstr /I "[/]" | findstr /I "^[0-9]" > nul
IF NOT ERRORLEVEL 1 goto EN2DATE
IF ERRORLEVEL 1 goto NODATE

:KRDATE
set date=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%
goto iischeck

:EN1DATE
set date=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
goto iischeck

:EN2DATE
set date=%DATE:~6,4%%DATE:~0,2%%DATE:~3,2%
goto iischeck

:NODATE
set date=2020XXXX
goto iischeck



:iischeck
chcp | find "949" > nul

net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 GOTO winFile
IF NOT ERRORLEVEL 1 GOTO iisFile

:iisFile
type %COMPUTERNAME%.log > %COMPUTERNAME%_%date%_%WinVer%-IIS-%score%%percent%.log
goto filedel

:winFile
type %COMPUTERNAME%.log > %COMPUTERNAME%_%date%_%WinVer%-%score%%percent%.log
goto filedel



:filedel
::IF NOT ERRORLEVEL 1 type %COMPUTERNAME%.log > %COMPUTERNAME%_%date1%_%WinVer%-%score%%percent%.log
::IF ERRORLEVEL 1 type %COMPUTERNAME%.log > %COMPUTERNAME%_2015-XX-XX_%WinVer%-%score%%percent%.log

del %JOYSEC%\%COMPUTERNAME%.log 2>nul 
del %JOYSEC%\%COMPUTERNAME%-1-1.log
del %JOYSEC%\%COMPUTERNAME%-1-2.log
del %JOYSEC%\%COMPUTERNAME%-1-3.log
::del %JOYSEC%\%COMPUTERNAME%-1-4.log
::del %JOYSEC%\%COMPUTERNAME%-2-1.log
del %JOYSEC%\%COMPUTERNAME%-2-2.log
del %JOYSEC%\%COMPUTERNAME%-2-3.log
del %JOYSEC%\%COMPUTERNAME%-2-4.log
del %JOYSEC%\%COMPUTERNAME%-3-1.log
del %JOYSEC%\%COMPUTERNAME%-3-2.log
del %JOYSEC%\%COMPUTERNAME%-4-1.log
del %JOYSEC%\%COMPUTERNAME%-4-2.log
del %JOYSEC%\%COMPUTERNAME%-4-3.log
del %JOYSEC%\%COMPUTERNAME%-5-1.log
del %JOYSEC%\%COMPUTERNAME%-5-2.log           
del %JOYSEC%\%COMPUTERNAME%-6-1.log
del %JOYSEC%\%COMPUTERNAME%-6-2.log
del %JOYSEC%\%COMPUTERNAME%-6-3.log
del %JOYSEC%\%COMPUTERNAME%-6-4.log
del %JOYSEC%\%COMPUTERNAME%-6-5.log
del %JOYSEC%\%COMPUTERNAME%-6-6.log
del %JOYSEC%\%COMPUTERNAME%-6-7.log
del %JOYSEC%\%COMPUTERNAME%-6-8.log
del %JOYSEC%\%COMPUTERNAME%-6-9.log
del %JOYSEC%\%COMPUTERNAME%-7-1.log
del %JOYSEC%\%COMPUTERNAME%-7-2.log
::del %JOYSEC%\%COMPUTERNAME%-8-1.log
del %JOYSEC%\%COMPUTERNAME%-8-2.log
del %JOYSEC%\%COMPUTERNAME%-8-3.log
del %JOYSEC%\%COMPUTERNAME%-8-4.log


del %JOYSEC%\%COMPUTERNAME%-list.log
del %JOYSEC%\%COMPUTERNAME%-test.log
del %JOYSEC%\result.log 2>nul
del %JOYSEC%\not-apply.log 2>nul

del %JOYSEC%\Local_Security_Policy.txt
del %JOYSEC%\1-1-userlist.log 2>nul
::del %JOYSEC%\1-1-accounts.log
::del %JOYSEC%\1-1-Activation.log
::del %JOYSEC%\1-1-Yesnum.log
del %JOYSEC%\1-1-result.log 2>nul
del %JOYSEC%\1-2-PASSWORD_POL.log
::del %JOYSEC%\1-4-IIS_STATUS.log
del %JOYSEC%\1-6-telnet.log 2>nul
del %JOYSEC%\2-1-admin-management.log 2>nul
del %JOYSEC%\1-2-lock.log 2>nul
del %JOYSEC%\1-3-PASSWORD_POL.log 2>nul
del %JOYSEC%\2-1.log 2>nul
del %JOYSEC%\2-2-user-access.log 2>nul
del %JOYSEC%\2-2-result.log 2>nul
del %JOYSEC%\2-3-harddirsk-netshare.log 2>nul
del %JOYSEC%\2-3-harddisk-reg.log 2>nul 
del %JOYSEC%\2-3-harddisk-reg1.log 2>nul
del %JOYSEC%\2-3-netshare.log 2>nul 
del %JOYSEC%\2-3-netsharelist.log 2>nul 
del %JOYSEC%\3-1-remote.log 2>nul 
del %JOYSEC%\3-1-terminal.log 2>nul
del %JOYSEC%\5-2-hotfix.log 2>nul
del %JOYSEC%\4-1-telnet.log 2>nul
del %JOYSEC%\dnslist.log 2>nul
del %JOYSEC%\4-3-snmp.log 2>nul
del %JOYSEC%\5-1-sp.log 2>nul
del %JOYSEC%\5-2-sp.log 2>nul
del %JOYSEC%\6-1-Users_pum.log 2>nul 
del %JOYSEC%\6-2-GUI.log 2>nul   
del %JOYSEC%\6-2-REG.log 2>nul 
del %JOYSEC%\6-3-event.log 2>nul   
del %JOYSEC%\6-3-event-gpo.log 2>nul   
del %JOYSEC%\6-3-event-gui.log 2>nul   
del %JOYSEC%\6-4-logonmessage.log 2>nul
del %JOYSEC%\6-5-lastlogon.log 2>nul
del %JOYSEC%\6-7-securitylog.log 2>nul
del %JOYSEC%\6-7-auditpol.log 2>nul
del %JOYSEC%\7-1-vaccine.log 2>nul
del %JOYSEC%\7-2-eupdate.log 2>nul
del %JOYSEC%\8-3-remote-registry.log 2>nul

del %JOYSEC%\Hotfix_list.log 2>nul
del %JOYSEC%\comtype-6-4.log 2>nul
del %JOYSEC%\6-4-logonmessage-1.log 2>nul
del %JOYSEC%\4-3-1-snmp.log 2>nul
del %JOYSEC%\4-3-2-snmp.log 2>nul

del %JOYSEC%\1-3-pch.log 2>nul
del %JOYSEC%\1-3-pch1.log 2>nul
del %JOYSEC%\1-3-pch2.log 2>nul
del %JOYSEC%\1-3-pch3.log 2>nul
del %JOYSEC%\1-3-pch4.log 2>nul
del %JOYSEC%\HotfixBaseday.log 2>nul
del %JOYSEC%\HotFixL.log 2>nul
del %JOYSEC%\pw2.log 2>nul
del %JOYSEC%\pw3.log 2>nul
del %JOYSEC%\pw4.log 2>nul
del %JOYSEC%\V3.log 2>nul
del %JOYSEC%\V3-1.log 2>nul
del %JOYSEC%\pw4.log 2>nul

del %JOYSEC%\sep86.log 2>nul
del %JOYSEC%\sep86-1.log 2>nul
del %JOYSEC%\sep64.log 2>nul
del %JOYSEC%\sep64-1.log 2>nul
del %JOYSEC%\1-1-comp.log 2>nul
del %JOYSEC%\1-1-explain.log 2>nul
del %JOYSEC%\1-1-explain2.log 2>nul

del %JOYSEC%\HotFixCh.log 2>nul
del %JOYSEC%\HotFixCh1.log 2>nul
del %JOYSEC%\HotFixCh2.log 2>nul
del %JOYSEC%\HotFixCh2.log 2>nul
del %JOYSEC%\folderper.log 2>nul
del %JOYSEC%\3-1-el.log 2>nul
del %JOYSEC%\3-1-terminaldrive.log 2>nul

del %JOYSEC%\fname.txt 2>nul
del %JOYSEC%\fpath.txt 2>nul
del %JOYSEC%\ftp_list.txt 2>nul
del %JOYSEC%\ftpid.txt 2>nul
del %JOYSEC%\ftpname.txt 2>nul
del %JOYSEC%\ftppath.txt 2>nul
del %JOYSEC%\hname.txt 2>nul
del %JOYSEC%\hpath.txt 2>nul
del %JOYSEC%\http_list.txt 2>nul
del %JOYSEC%\httpid.txt 2>nul
del %JOYSEC%\httpname.txt 2>nul
del %JOYSEC%\httppath.txt 2>nul
del %JOYSEC%\rpath.txt 2>nul
del %JOYSEC%\site_list.txt 2>nul
del %JOYSEC%\iis-result.txt 2>nul
del %JOYSEC%\iis-version.txt 2>nul
del %JOYSEC%\website-list.txt 2>nul
del %JOYSEC%\website-name.txt 2>nul
del %JOYSEC%\website-physicalpath.txt 2>nul
del %JOYSEC%\%COMPUTERNAME%-w.log 2>nul




echo.
echo.
pause
EXIT



:END-1
echo       ####################################################################
echo       ##                                                                ##
echo       ##        ��ũ��Ʈ ���� ��� Ȯ�� �� ������ ��û�帳�ϴ�          ##
echo       ##        ��ũ��Ʈ ������C:\joycity                        ##
echo       ##                                                                ##
echo       ####################################################################
echo.
pause
EXIT

:END
pause
EXIT
