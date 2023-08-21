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
::bcdedit > nul || (echo. & echo. & echo ※ 관리자 권한으로 실행해 주세요!! & echo. & echo. & echo. & pause & exit)

REM :Q
TITLE 2023 Windows Security Check v1.6.8
@echo off

echo.                                                                           
@REM echo ####               보안 진단을 시작하겠습니까(Y/N)                   ####  
echo.                                                                           

:: set/p "cho=※ Windows 보안 진단을 시작하겠습니까? (Y/N) : "
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

@REM 윈도우 버전 식별
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

bcdedit > nul || (echo. & echo. & echo ※ 관리자 권한으로 실행해 주세요!! & echo. & echo. & echo. & pause & exit)



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


@REM IIS 버전 확인
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
echo ※ 본 스크립트의 '기준'에 대한 내용은 보안가이드라인 문서에서 요약한 내용입니다.               >> result.log
echo    진단항목별로 구체적인 진단 기준과 조치방법은 '보안가이드라인' 문서를 참고하시기 바랍니다.   >> result.log
echo ※ 특이한 설정이나 정의되어 있지 않은 패턴에 대해서는 오탐이 있을 수 있으며,                   >> result.log
echo    정확한 진단을 위해서는 실제 설정 현황과 보안가이드라인 문서를 바탕으로 판단하시기 바랍니다. >> result.log
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





@REM 취약한 항목리스트를 나타나내기위해 파일생성
echo ##################################################################################### >> result.log
echo ################################## 취약 항목 리스트 ################################# >> result.log
echo ##################################################################################### >> result.log

                                                                 
@REM N/A 항목리스트를 나타나내기위해 파일생성
echo.                                                                                       > not-apply.log
echo.                                                                                      >> not-apply.log   

echo ##################################################################################### >> not-apply.log
echo ################################### N/A 항목 리스트 ################################# >> not-apply.log
echo ##################################################################################### >> not-apply.log
                                                       


@REM 취약, N/A 항목내용을 나타내기위해 파일생성
::echo.                                                                                       > %COMPUTERNAME%-list.log
::echo.                                                                                      >> %COMPUTERNAME%-list.log
::echo ##################################################################################### >> %COMPUTERNAME%-list.log
::echo ######################## 취약 및 N/A 항목에 대한 상세 진단결과 ###################### >> %COMPUTERNAME%-list.log
::echo ##################################################################################### >> %COMPUTERNAME%-list.log
::echo.                                                                                      >> %COMPUTERNAME%-list.log                                                          
::echo.                                                                                       > %COMPUTERNAME%-test.log
::echo.                                                                                      >> %COMPUTERNAME%-test.log

echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo ##################################################################################### >> %COMPUTERNAME%-test.log
echo ######################### 전체 항목에 대한  상세 진단결과 ########################### >> %COMPUTERNAME%-test.log
echo ##################################################################################### >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo ☞ Start Time                                                                         >> %COMPUTERNAME%-test.log
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
net start | findstr /I /v "명령을 completed"                                               >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log
echo.                                                                                      >> %COMPUTERNAME%-test.log


echo ★ 전체 진단 결과                                                                     >> %COMPUTERNAME%-test.log
echo ★ 전체 진단 시작   
echo ### 1.1 로컬 계정 사용 설정   #############################################################  
echo #####################################################################################  > %COMPUTERNAME%-1-1.log
echo ### 1.1 로컬 계정 사용 설정   ############################################################## >> %COMPUTERNAME%-1-1.log
echo ##################################################################################### >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo START                                                                                      >> %COMPUTERNAME%-1-1.log
echo □ 기준1 : 관리자 계정인 Administrator 계정명을 변경하여 사용.                         >> %COMPUTERNAME%-1-1.log
echo □ 기준2 : Guest 계정이 비활성화                                                       >> %COMPUTERNAME%-1-1.log
echo □ 기준3 : 불필요한 계정은 삭제. 사용하는 계정은 [설명] 부분에 사용용도 기입           >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo ① 관리자 계정 Administrator 계정명 현황                                              >> %COMPUTERNAME%-1-1.log
net localgroup Administrators | findstr /I /v "명령을 completed"                       	   >> %COMPUTERNAME%-1-1.log
echo - Administrator 계정 현황                                                             >> %COMPUTERNAME%-1-1.log
net user Administrator  > nul
IF NOT ERRORLEVEL 1 net user Administrator | findstr /I "활성 active"                                  >> %COMPUTERNAME%-1-1.log
net user Administrator | findstr /I "활성 active" | findstr /I "예 Yes" > nul
IF NOT ERRORLEVEL 1 ECHO bad								   >> 1-1-result.log
net user Administrator | findstr /I "활성 active" | findstr /I "잠금" > nul
IF NOT ERRORLEVEL 1 ECHO bad								   >> 1-1-result.log

echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo ② Guest 계정 현황                                                                    >> %COMPUTERNAME%-1-1.log
net user Guest | findstr /I "활성 active"                                        >> %COMPUTERNAME%-1-1.log
net user Guest | findstr /I "활성 active" | findstr /I "예 Yes" > nul
IF NOT ERRORLEVEL 1 ECHO bad								   >> 1-1-result.log
net user Guest | findstr /I "활성 active" | find "잠금" > nul
IF NOT ERRORLEVEL 1 ECHO bad								   >> 1-1-result.log

echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
::echo ③ 불필요한 계정 확인 필요                                                            >> %COMPUTERNAME%-1-1.log
::net user | findstr /I /v "계정 accounts" | find /v "----" | findstr /I /v "명령을 completed"                                >> 1-1-userlist.log
::FOR /F "TOKENS=1" %%i IN ('type 1-1-userlist.log') DO ECHO %%i | find /v "Administrator" | find /v "Guest"           	  >> 1-1-accounts.log
::FOR /F "TOKENS=2" %%i IN ('type 1-1-userlist.log') DO ECHO %%i | find /v "Administrator" | find /v "Guest"           	  >> 1-1-accounts.log
::FOR /F "TOKENS=3" %%i IN ('type 1-1-userlist.log') DO ECHO %%i | find /v "Administrator" | find /v "Guest"           	  >> 1-1-accounts.log


::dir 1-1-accounts.log | find " 0 바이트" > nul
::IF NOT ERRORLEVEL 1 goto 1-1-check
::dir 1-1-accounts.log | find " 0 bytes" > nul
::IF NOT ERRORLEVEL 1 goto 1-1-check

::FOR /F "TOKENS=1" %%i IN ('type 1-1-accounts.log') DO (
::net user %%i | findstr /I "활성 active" | findstr /I " 예 Yes" > nul
::IF NOT ERRORLEVEL 1 echo %%i >> 1-1-explain.log
::)

::FOR /F "USEBACKQ DELIMS=" %%i IN ("1-1-explain.log") DO (
::net user %%i | findstr /I "이름 활성 설명 name active comment"	| find /I /V "사용자 설명" | find /I /V "전체 이름" 	  		>> %COMPUTERNAME%-1-1.log
::echo. >> %COMPUTERNAME%-1-1.log
::)
::FOR /F "USEBACKQ DELIMS=" %%i IN ("1-1-accounts.log") DO net user %%i | findstr /I "활성 active"     >> 1-1-Activation.log
::
::type 1-1-Activation.log | find /c "예"								    > 1-1-Yesnum.log
::FOR /F "USEBACKQ DELIMS=" %%i IN ("1-1-Yesnum.log") DO set compare_val=%%i
::IF %compare_val% GTR 1 ECHO bad 								>> 1-1-result.log
::type 1-1-Activation.log | find /c "Yes"								    > 1-1-Yesnum.log
::FOR /F "USEBACKQ DELIMS=" %%i IN ("1-1-Yesnum.log") DO set compare_val=%%i
::IF %compare_val% GTR 1 ECHO bad 								>> 1-1-result.log

::echo 설명                               >> 1-1-comp.log
::FOR /F "TOKENS=1" %%i IN ('type 1-1-explain.log') DO (
::net user %%i | findstr /I "설명 explain" | findstr /I /v "사용자 user" > 1-1-explain2.log
::echo n | comp 1-1-comp.log 1-1-explain2.log 2>nul | findstr /I "같습니다 SAME" > NUL
::IF NOT ERRORLEVEL 1 ECHO bad >> 1-1-result.log
::)

:1-1-check
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
type 1-1-result.log | find "bad" > nul
IF NOT ERRORLEVEL 1 goto 1-1-bad
echo ※ 관리자 계정인 Administrator 계정명을 변경하고, GUEST 계정 비활성화, 불필요한 계정 삭제 권고 >> %COMPUTERNAME%-1-1.log
echo. >> %COMPUTERNAME%-1-1.log
echo @ 양호 - 1.1 로컬 계정 사용 설정  		                                   >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
type %COMPUTERNAME%-1-1.log                                                                >> %COMPUTERNAME%-test.log
GOTO 1-2

:1-1-bad
echo. >> %COMPUTERNAME%-1-1.log
echo ※ 관리자 계정인 Administrator 계정명을 변경하고, GUEST 계정 비활성화, 불필요한 계정 삭제 권고 >> %COMPUTERNAME%-1-1.log
echo. >> %COMPUTERNAME%-1-1.log
echo @ 취약 - 1.1 로컬 계정 사용 설정  >> %COMPUTERNAME%-1-1.log | echo @ 취약 - 1.1 로컬 계정 사용 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
echo.                                                                                      >> %COMPUTERNAME%-1-1.log
type %COMPUTERNAME%-1-1.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-1-1.log                                                                >> %COMPUTERNAME%-test.log




:1-2
echo ### 1.2 계정 잠금 정책 설정  ##############################################################
echo END##################################################################################  > %COMPUTERNAME%-1-2.log
echo ### 1.2 계정 잠금 정책 설정  ############################################################### >> %COMPUTERNAME%-1-2.log
echo ##################################################################################### >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo START                                                                                      >> %COMPUTERNAME%-1-2.log
echo □ 기준 : 계정 잠금 기간이 '10분 이상', 계정 잠금수를 원래대로 설정이 '10분 이상' 계정 잠금       >> %COMPUTERNAME%-1-2.log
echo          임계값 '10번 이하'로 설정되어 있거나 AMS(계정관리시스템)이 연동되어 있으면 양호  		  >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo ■ 현황                                                                               >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log 
net start | find "OmniWorker" > NUL
IF ERRORLEVEL 1 GOTO AMS-DISABLE
IF NOT ERRORLEVEL 1 GOTO AMS-ACTIVE



:AMS-ACTIVE
echo ☞ AMS(계정관리시스템)이 연동되어 있습니다.                                           >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo @ 양호 - 1.2 계정 잠금 정책 설정                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
type %COMPUTERNAME%-1-2.log                                                                >> %COMPUTERNAME%-test.log  
GOTO 1-3

:AMS-DISABLE
secedit /EXPORT /CFG Local_Security_Policy.txt 	 > NUL					   					 
type Local_Security_Policy.txt | findstr /I "LockoutDuration LockoutBadCount ResetLockoutCount"                    > 1-2-PASSWORD_POL.log
echo ☞ 설정된 계정 잠금 정책															                           >> %COMPUTERNAME%-1-2.log
echo.                                                                                                              >> %COMPUTERNAME%-1-2.log
echo [계정 잠금 기간 - 10분(이상)]														                                       >> %COMPUTERNAME%-1-2.log
type Local_Security_Policy.txt | findstr /I "LockoutDuration"    		                                           >> %COMPUTERNAME%-1-2.log
IF ERRORLEVEL 1 ECHO '계정 잠금 기간 설정' 없음											                           >> %COMPUTERNAME%-1-2.log
echo.                                                                                                              >> %COMPUTERNAME%-1-2.log 
echo [계정 잠금 임계값 - 10번(이하)]													                                           >> %COMPUTERNAME%-1-2.log
type Local_Security_Policy.txt | findstr /I "LockoutBadCount"    		                                           >> %COMPUTERNAME%-1-2.log
echo.                                                                                                              >> %COMPUTERNAME%-1-2.log 
echo [계정 잠금 기간 원래대로 설정 - 10분(이상]													                               >> %COMPUTERNAME%-1-2.log
type Local_Security_Policy.txt | findstr /I "ResetLockoutCount"    		                                           >> %COMPUTERNAME%-1-2.log
IF ERRORLEVEL 1 ECHO '계정 잠금 기간 원래대로 설정' 없음									                       >> %COMPUTERNAME%-1-2.log
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
echo ※ 계정 잠금 기간 '10분 이상', 계정 잠금 임계값 '10번 이하', 계정 잠금 기간 원래대로 설정 '10분 이상'으로 설정 권고  >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo @ 양호 - 1.2 계정 잠금 정책 설정                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
type %COMPUTERNAME%-1-2.log                                                                >> %COMPUTERNAME%-test.log
GOTO 1-3

:1-2-3
:1-2-bad
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo ※ 계정 잠금 기간 '10분 이상', 계정 잠금 임계값 '10번 이하', 계정 잠금 기간 원래대로 설정 '10분 이상'으로 설정 권고  >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo @ 취약 - 1.2 계정 잠금 정책 설정  >> %COMPUTERNAME%-1-2.log | echo @ 취약 - 1.2 계정 잠금 정책 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
echo.                                                                                      >> %COMPUTERNAME%-1-2.log
type %COMPUTERNAME%-1-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-1-2.log                                                                >> %COMPUTERNAME%-test.log





:1-3
echo ### 1.3 암호 정책 설정  #################################################################
echo END#################################################################################  > %COMPUTERNAME%-1-3.log
echo ### 1.3 암호 정책 설정  ################################################################## >> %COMPUTERNAME%-1-3.log
echo #################################################################################### >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo START                                                                                  >> %COMPUTERNAME%-1-3.log
echo □ 기준 : 최대 암호 사용 기간 '90일 이하' AND 암호는 복잡성을 만족해야 함 '사용' >> %COMPUTERNAME%-1-3.log
echo           AND 최소 암호 길이 '9문자 이상' AND 최근 암호 기억 '12개' AND  >> %COMPUTERNAME%-1-3.log
echo         해독 가능한 암호화를 사용하여 암호저장 '사용안함'로 설정되어 있으면 양호      >> %COMPUTERNAME%-1-3.log
::echo □ 기준2: 안전한 패스워드 적용. 3종류 이상의 조합으로 8자 이상의 패스워드로 설정해야 함      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo ■ 현황                                                                               >> %COMPUTERNAME%-1-3.log
echo.                                                                 						 >> %COMPUTERNAME%-1-3.log 
net start | find "OmniWorker" > NUL
IF ERRORLEVEL 1 GOTO AMS-DISABLE
IF NOT ERRORLEVEL 1 GOTO AMS-ACTIVE

:AMS-ACTIVE
echo ☞ AMS(계정관리시스템)에 연동되어 있습니다.                                           >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo @ 양호 - 1.3 암호 정책 설정                                                           >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
type %COMPUTERNAME%-1-3.log                                                                >> %COMPUTERNAME%-test.log  
goto 2-1

:AMS-DISABLE
type Local_Security_Policy.txt | findstr /I "PasswordComplexity PasswordHistorySize MaximumPasswordAge MinimumPasswordLength MinimumPasswordAge ClearTextPassword"                              > 1-3-PASSWORD_POL.log
echo ☞ 설정된 암호정책  															   >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
echo [암호 복잡성을 만족해야 함 - 1(사용)]  													   >> %COMPUTERNAME%-1-3.log
type Local_Security_Policy.txt | findstr /I "PasswordComplexity"		               >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
echo [최근 암호 기억 - 4]														           >> %COMPUTERNAME%-1-3.log
type Local_Security_Policy.txt | findstr /I "PasswordHistorySize"		               >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
echo [최대 암호 사용 기간 - 90일(이하)]													           >> %COMPUTERNAME%-1-3.log
type Local_Security_Policy.txt | findstr /I "MaximumPasswordAge" | findstr /I /v "Services"	               >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
echo [최소 암호 길이 - 9문자(이상)]													   			   >> %COMPUTERNAME%-1-3.log
type Local_Security_Policy.txt | findstr /I "MinimumPasswordLength"		   			   >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
::echo [최소 암호 사용 시간 - 1일(이상)]												   			   >> %COMPUTERNAME%-1-3.log
::type Local_Security_Policy.txt | findstr /I "MinimumPasswordAge"		   			   >> %COMPUTERNAME%-1-3.log
::echo.                                                                                  >> %COMPUTERNAME%-1-3.log
echo [해독 가능한 암호화를 사용하여 암호 저장 - 0(사용안함)]										   >> %COMPUTERNAME%-1-3.log
type Local_Security_Policy.txt | findstr /I "ClearTextPassword"		   				   >> %COMPUTERNAME%-1-3.log
echo.                                                                                  >> %COMPUTERNAME%-1-3.log
::echo ☞ 시스템 날짜 정보    			                       							>> %COMPUTERNAME%-1-3.log
::echo.                                                                                       >> %COMPUTERNAME%-1-3.log 
::echo %date% 																				>> %COMPUTERNAME%-1-3.log
::for /f %%d in ('cscript //nologo %script%\OldDateCode.vbs') do set cu_date=%%d
::echo.                                                                                       >> %COMPUTERNAME%-1-3.log 
::echo ☞ 마지막 패스워드 변경일 확인          	 												>> %COMPUTERNAME%-1-3.log
::echo.                                                                                       >> %COMPUTERNAME%-1-3.log 
::net user | findstr /I /v "계정 accounts" | find /v "----" | findstr /I /v "명령을 completed"                                >> 1-3-pch.log
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch.log') DO ECHO %%i            	  >> 1-3-pch1.log
::FOR /F "TOKENS=2" %%i IN ('type 1-3-pch.log') DO ECHO %%i            	  >> 1-3-pch1.log
::FOR /F "TOKENS=3" %%i IN ('type 1-3-pch.log') DO ECHO %%i            	  >> 1-3-pch1.log
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch1.log') do (
::net user %%i | findstr /I "활성 active" | findstr /I "예 Yes" > nul
::IF NOT ERRORLEVEL 1 echo %%i >> 1-3-pch2.log
::)
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch2.log') DO net user %%i | findstr /I "%%i 마지막 last" | findstr /V /I "전체 이름" | findstr /V /I "로컬 그룹 구성원"		        >> %COMPUTERNAME%-1-3.log
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch2.log') DO net user %%i | findstr /I "%%i 마지막 last" | findstr /V /I "전체 이름" | findstr /V /I "로컬 그룹 구성원 사용자 이름" 	>> 1-3-pch3.log
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch2.log') DO net user %%i | findstr /I "%%i 마지막 set" | findstr /V /I "전체 이름" | findstr /V /I "로컬 그룹 구성원"		        >> %COMPUTERNAME%-1-3.log
::FOR /F "TOKENS=1" %%i IN ('type 1-3-pch2.log') DO net user %%i | findstr /I "%%i 마지막 set" | findstr /V /I "전체 이름" | findstr /V /I "로컬 그룹 구성원 사용자 이름"	>> 1-3-pch3.log


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
::echo ☞ 패스워드 변경기한이 90일을 초과하였습니다 >> %COMPUTERNAME%-1-3.log
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
echo ※ 암호정책 설정 및 3종류 이상의 조합으로 9자 이상 사용 권고                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo @ 양호 - 1.3 암호 정책 설정                                                          >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
type %COMPUTERNAME%-1-3.log                                                                >> %COMPUTERNAME%-test.log
goto 2-2


:1-3-bad
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo ※ 암호정책 설정 및 3종류 이상의 조합으로 9자 이상 사용 권고                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
ECHO @ 취약 - 1.3 암호 정책 설정 >> %COMPUTERNAME%-1-3.log | echo @ 취약 - 1.3 암호 정책 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
echo.                                                                                      >> %COMPUTERNAME%-1-3.log
type %COMPUTERNAME%-1-3.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-1-3.log                                                                >> %COMPUTERNAME%-test.log
goto 2-2


:2-2
echo ### 2.1 사용자 홈 디렉터리 접근제한  #########################################################
echo END##################################################################################  > %COMPUTERNAME%-2-2.log
echo ### 2.1 사용자 홈 디렉터리 접근제한  ########################################################## >> %COMPUTERNAME%-2-2.log
echo ##################################################################################### >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo START                                                                                 >> %COMPUTERNAME%-2-2.log
echo □ 기준 : 홈디렉터리 권한중 Users:F 또는 Everyone:F 가 없으면 양호                     >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-2-2.log
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
IF ERRORLEVEL 1 echo ☞ User:F 또는 Everyone:F 가 존재하지 않습니다						   >> %COMPUTERNAME%-2-2.log 
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo ※ 홈디렉토리 권한중 Users:F 또는 Everyone:F  설정 제거 권고  >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo @ 양호 - 2.1 사용자 홈 디렉터리 접근제한				                               >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-test.log
goto 2-3

:yes-user-F
type 2-2-user-access.log | find  "Everyone:(OI)(CI)F" >nul
IF ERRORLEVEL 1 goto yes-user-no-everyone-F
IF NOT ERRORLEVEL 1 goto yes-user-yes-everyone-F

:yes-user-no-everyone-F
echo ☞ Users:(OI)(CI)F 가 존재합니다. 불필요할 경우 삭제하시기 바랍니다.                  >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo. 																					   >> %COMPUTERNAME%-2-2.log
echo ※ 홈디렉토리 권한중 Users:F 또는 Everyone:F  설정 제거 권고  						>> %COMPUTERNAME%-2-2.log
echo. >> %COMPUTERNAME%-2-2.log
echo @ 취약 - 2.1 사용자 홈 디렉터리 접근제한 >> %COMPUTERNAME%-2-2.log | echo @ 취약 - 2.1 사용자 홈 디렉터리 접근제한 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log


type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-test.log
goto 2-3

:no-user-yes-everyone-F
echo ☞ Everyone:(OI)(CI)F 가 존재합니다. 불필요할 경우 삭제하시기 바랍니다.               >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo. >> %COMPUTERNAME%-2-2.log
echo ※ 홈디렉토리 권한중 Users:F 또는 Everyone:F  설정 제거 권고  >> %COMPUTERNAME%-2-2.log
echo. >> %COMPUTERNAME%-2-2.log
echo @ 취약 - 2.1 사용자 홈 디렉터리 접근제한 >> %COMPUTERNAME%-2-2.log | echo @ 취약 - 2.1 사용자 홈 디렉터리 접근제한 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log


type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-test.log
goto 2-3

:yes-user-yes-everyone-F
echo ☞ Users:(OI)(CI)F 와 Everyone:(OI)(CI)F 가 존재합니다. 불필요할 경우 삭제하시기 바랍니다. >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo. >> %COMPUTERNAME%-2-2.log
echo ※ 홈디렉토리 권한중 Users:F 또는 Everyone:F  설정 제거 권고  >> %COMPUTERNAME%-2-2.log
echo. >> %COMPUTERNAME%-2-2.log
echo @ 취약 - 2.1 사용자 홈 디렉터리 접근제한 >> %COMPUTERNAME%-2-2.log | echo @ 취약 - 2.1 사용자 홈 디렉터리 접근제한 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log
echo.                                                                                      >> %COMPUTERNAME%-2-2.log


type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-2-2.log                                                                >> %COMPUTERNAME%-test.log
goto 2-3





:2-3
echo ### 2.2 공유 폴더 설정  #################################################################
echo END##################################################################################  > %COMPUTERNAME%-2-3.log
echo ### 2.2 공유 폴더 설정  ################################################################### >> %COMPUTERNAME%-2-3.log
echo ##################################################################################### >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo START                                                                                 >> %COMPUTERNAME%-2-3.log
echo □ 기준1 : C$, D$, Admin$ (IPC$ 제외)등의 기본 공유폴더 제거 및 AutoShareServer 레지스트리값을 0으로 설정 >> %COMPUTERNAME%-2-3.log
echo □ 기준2 : 공유 폴더 사용 시 공유 폴더 접근 권한에 Everyone 제거 및 암호로 보호된 공유 설정               >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo [ 공유폴더 현황 ]                                                                     >> %COMPUTERNAME%-2-3.log
net share | find /V "IPC$" | findstr /I /v "명령을 completed"                     		   >> %COMPUTERNAME%-2-3.log
::echo.                                                                                      >> %COMPUTERNAME%-2-3.log
::echo ☞ OS 종류 현황                                                                       >> %COMPUTERNAME%-2-3.log
::%script%\psinfo | find "Product type"	  				                                   >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo 1) AutoShareServer 레지스트리 설정값                                                  >> %COMPUTERNAME%-2-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareServer" >> %COMPUTERNAME%-2-3.log
IF ERRORLEVEL 1 ECHO AutoShareServer 레지스트리 값이 등록되어 있지 않습니다.(AutoShareServer 생성 필요)	   >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo 2) 사용중인 공유폴더 접근권한 현황                                                                 >> %COMPUTERNAME%-2-3.log
::echo.                                                                                      >> %COMPUTERNAME%-2-3.log
::net share | find /V "IPC$" | findstr /I /v "명령을 completed" | findstr /I "기본 원격 Default Remote"		>> %COMPUTERNAME%-2-3.log
::net share | find /V "IPC$" | findstr /I /v "명령을 completed" | find /v "The command completed successfully"                         > 2-3-netsharelist.log
echo > 2-2-result.log
net share | find /V "IPC$" | findstr /I /v "명령을 completed" | findstr /I "기본 원격 Default Remote" > NUL	
IF NOT ERRORLEVEL 1 echo 2-3-1-bad  >> 2-2-result.log

echo > 2-3-netsharelist.log
net share | find /V "IPC$" | findstr /I /v "명령을 completed" | findstr /I /v "기본 원격 Default Remote"		>> 2-3-netsharelist.log
FOR /F "tokens=2 skip=4" %%j IN ('type 2-3-netsharelist.log') DO cacls %%j        		   >> folderper.log 2>&1
::net share | findstr /I /v /R ^[a-z][\\][a-z] | find /V "IPC$" | findstr /I /v "명령을 completed" | find /v "The command completed successfully"	> 2-3-netsharelist.log
::FOR /F "tokens=2 skip=4" %%j IN ('type 2-3-netsharelist.log') DO cacls %%j        		   >> folderper.log 2>&1
type folderper.log 																		   >> %COMPUTERNAME%-2-3.log	
::echo.                                                                                      >> %COMPUTERNAME%-2-3.log
::FOR /F "tokens=1,2,3 skip=4" %%a IN ('net share') DO echo %%a %%b %%c             		   >> 2-3-harddirsk-netshare.log
::TYPE 2-3-harddirsk-netshare.log | find /V "IPC$" | findstr /I /v "기본 원격 Default Remote 명령을 completed" > NUL	
::TYPE 2-3-harddirsk-netshare.log | findstr /I /v /R ^[a-z][\\][a-z] | find /V "IPC$" | findstr /I /v "명령을 completed" > NUL	
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
IF NOT ERRORLEVEL 1 echo ☞ 공유 폴더 Everyone 권한 필요(방화벽 및 SG를 통해 접근 통제)  >> %COMPUTERNAME%-2-3.log


type 2-2-result.log | find "bad" > nul
IF NOT ERRORLEVEL 1 goto 2-3-bad


::echo ☞ 공유폴더가 존재하지 않으며, 레지스트리 값이 양호합니다                             >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo. >> %COMPUTERNAME%-2-3.log
echo ※ 시스템 공유폴더 제거 및 공유 폴더 권한을 적절히 설정 권고 >> %COMPUTERNAME%-2-3.log
echo. 																					   >> %COMPUTERNAME%-2-3.log
echo @ 양호 - 2.2. 공유 폴더 설정                                                          >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
type %COMPUTERNAME%-2-3.log                                                                >> %COMPUTERNAME%-test.log
goto 2-4

:2-3-bad
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo. 																					   >> %COMPUTERNAME%-2-3.log
echo ※ 시스템 공유폴더 제거 및 공유 폴더 권한을 적절히 설정 권고 >> %COMPUTERNAME%-2-3.log
echo. 																					   >> %COMPUTERNAME%-2-3.log
ECHO @ 취약 - 2.2 공유 폴더 설정 >> %COMPUTERNAME%-2-3.log | echo @ 취약 - 2.2 공유 폴더 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
echo.                                                                                      >> %COMPUTERNAME%-2-3.log
type %COMPUTERNAME%-2-3.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-2-3.log                                                                >> %COMPUTERNAME%-test.log




:2-4
echo ### 2.3 SAM 파일 권한 설정  #############################################################
echo END##################################################################################  > %COMPUTERNAME%-2-4.log
echo ### 2.3 SAM 파일 권한 설정  ###############################################################  >> %COMPUTERNAME%-2-4.log
echo ##################################################################################### >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo START                                                                                 >> %COMPUTERNAME%-2-4.log
echo □ 기준 : SAM파일 접근권한이 Administrator, System 그룹만 모든 권한으로 등록되어 있는 경우 >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
cacls %systemroot%\system32\config\SAM				                   					   >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
cacls %systemroot%\system32\config\SAM | find /I "ER" > NUL
IF ERRORLEVEL 1 goto 2-4-good
IF NOT ERRORLEVEL 1 goto 2-4-bad

:2-4-bad
echo. >> %COMPUTERNAME%-2-4.log
echo ※ SAM 파일 접근권한이 Administrators, System 그룹만 모든 권한 설정 권고  >> %COMPUTERNAME%-2-4.log
echo. >> %COMPUTERNAME%-2-4.log
ECHO @ 취약 - 2.3 SAM 파일 권한 설정 >> %COMPUTERNAME%-2-4.log | echo @ 취약 - 2.4 SAM 파일 권한 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
type %COMPUTERNAME%-2-4.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-2-4.log                                                                >> %COMPUTERNAME%-test.log
goto 3-1

:2-4-good
echo. >> %COMPUTERNAME%-2-4.log
echo ※ SAM 파일 접근권한이 Administrators, System 그룹만 모든 권한 설정 권고  >> %COMPUTERNAME%-2-4.log
echo. >> %COMPUTERNAME%-2-4.log
ECHO @ 양호 - 2.3 SAM 파일 권한 설정                             >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
echo.                                                                                      >> %COMPUTERNAME%-2-4.log
type %COMPUTERNAME%-2-4.log                                                                >> %COMPUTERNAME%-test.log



:3-1
echo ### 3.1 터미널 서비스 암호화 수준 설정  #######################################################
echo END##################################################################################  > %COMPUTERNAME%-3-1.log
echo ### 3.1 터미널 서비스 암호화 수준 설정  ####################################################### >> %COMPUTERNAME%-3-1.log
echo ##################################################################################### >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo START                                                                                 >> %COMPUTERNAME%-3-1.log
echo □ 기준 : 불필요시 터미널 서비스를 사용하지 않거나 사용시 암호화 수준을 		   >> %COMPUTERNAME%-3-1.log
echo           "클라이언트 호환 가능" 이상 및 네트워크 수준 인증 사용	   >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo ■ 현황                                                                               >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo 1) Terminal 서비스 구동상태                                                           >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
sc query TermService | findstr /I "RUNNING STOPPED"					    > 3-1-terminal.log
TYPE 3-1-terminal.log																	   >> %COMPUTERNAME%-3-1.log
net start | find "Remote Desktop Services" | find /v "Remote Desktop Services UserMode Port Redirector" > nul
IF NOT ERRORLEVEL 1 GOTO TERMINAL-ACTIV                                                    >> %COMPUTERNAME%-3-1.log
net start | find /i "Terminal Services" > nul
IF NOT ERRORLEVEL 1 GOTO TERMINAL-ACTIV                                                    >> %COMPUTERNAME%-3-1.log


IF ERRORLEVEL 1 ECHO ☞ 터미널서비스를 사용중이지 않습니다.                                   >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo @ 양호 - 3.1 터미널 서비스 암호화 수준 설정                                           >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
type %COMPUTERNAME%-3-1.log                                                                >> %COMPUTERNAME%-test.log
goto 3-2

:TERMINAL-ACTIV
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo ☞ 터미널 서비스를 사용중입니다.                                                         >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo 2) 클라리언트 연결 암호화 수준(2 이상 양호)												           >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\MinEncryptionLevel"  >> %COMPUTERNAME%-3-1.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\MinEncryptionLevel"  >> 3-1-el.log
type 3-1-el.log | find /i "unable"
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
IF NOT ERRORLEVEL 1 ECHO ☞ 클라이언트 연결 암호화 수준이 설정되어 있지 않습니다.             >> %COMPUTERNAME%-3-1.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\MinEncryptionLevel" | findstr "2 3 4" > NUL
IF ERRORLEVEL 1 set terminalbad=1
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo 3) 네트워크 수준 인증 사용 설정(1:사용, 0:미사용)										       >> %COMPUTERNAME%-3-1.log
echo ☞ 패스워드 90일 만료 이후 사용자가 직접 패스워드 변경을 위해 미사용                              >> %COMPUTERNAME%-3-1.log
::%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\UserAuthentication"  >> %COMPUTERNAME%-3-1.log
::%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\UserAuthentication"  >> 3-1-terminaldrive.log
::type 3-1-terminaldrive.log | find /i "unable"
::echo.                                                                                      >> %COMPUTERNAME%-3-1.log
::IF NOT ERRORLEVEL 1 ECHO ☞ 네트워크 수준 인증 사용 설정이 되어 있지 않습니다.              >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
::%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\UserAuthentication" | findstr "1" > NUL
::IF ERRORLEVEL 1 GOTO 3-1-bad
echo %terminalbad% | findstr "1" >nul
IF ERRORLEVEL 1 goto 3-1-good
IF %terminalbad% EQU 1 goto 3-1-bad

:3-1-bad
::echo ☞ 서버 운영 및 점검을 위해 드라이브 리다렉션 기능 필요(방화벽 정책 관리를 통해 추가 접근통제 적용)                   >> %COMPUTERNAME%-3-1.log
echo.                                                                                               >> %COMPUTERNAME%-3-1.log
echo.                                                                                               >> %COMPUTERNAME%-3-1.log
::echo ※ 불필요한 경우 터미널 서비스 중지하거나 사용 시 암호화 수준을 “클라이언트 호환 가능” 이상과  >> %COMPUTERNAME%-3-1.log
::echo    "네트워크 수준 인증 사용" 설정 권고     										>> %COMPUTERNAME%-3-1.log
echo ※ 불필요한 경우 터미널 서비스 중지하거나 사용 시 암호화 수준을 “클라이언트 호환 가능” 이상 설정 권고  >> %COMPUTERNAME%-3-1.log
echo. 																								>> %COMPUTERNAME%-3-1.log
echo @ 취약 - 3.1 터미널 서비스 암호화 수준 설정 >> %COMPUTERNAME%-3-1.log | echo @ 취약 - 3.1 터미널 서비스 암호화 수준 설정 >> result.log
::echo @ 양호 - 3.1 터미널 서비스 암호화 수준 및 리디렉션 설정                                              >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
type %COMPUTERNAME%-3-1.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-3-1.log                                                                >> %COMPUTERNAME%-test.log
goto 3-2

:3-1-good
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
::echo ※ 불필요한 경우 터미널 서비스 중지하거나 사용 시 암호화 수준을 “클라이언트 호환 가능” 이상과  >> %COMPUTERNAME%-3-1.log
::echo    "네트워크 수준 인증 사용" 설정 권고     										>> %COMPUTERNAME%-3-1.log
echo ※ 불필요한 경우 터미널 서비스 중지하거나 사용 시 암호화 수준을 “클라이언트 호환 가능” 이상 설정 권고  >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo @ 양호 - 3.1 터미널 서비스 암호화 수준 및 리디렉션 설정                               >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
echo.                                                                                      >> %COMPUTERNAME%-3-1.log
type %COMPUTERNAME%-3-1.log                                                                >> %COMPUTERNAME%-test.log



:3-2
echo ### 3.2 방화벽 정책 적용  ############################################################### 
echo END#################################################################################  > %COMPUTERNAME%-3-2.log
echo ### 3.2 방화벽 정책 적용  ################################################################ >> %COMPUTERNAME%-3-2.log
echo #################################################################################### >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo START                                                                                 >> %COMPUTERNAME%-3-2.log
echo □ 기준 : 외부 공격 차단을 위한 방화벽 정책 적용                                       >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo ☞ 명시적으로 허용되지 않은 접근 모두 차단 되어 있음  	                                               >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo @ 양호 - 3.2 방화벽 정책 적용 													     	   >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
echo.                                                                                      >> %COMPUTERNAME%-3-2.log
type %COMPUTERNAME%-3-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-3-2.log                                                                >> %COMPUTERNAME%-test.log




:4-1
echo ### 4.1 Telnet 서비스 중지  ###########################################################
echo END################################################################################ > %COMPUTERNAME%-4-1.log
echo ### 4.1 Telnet 서비스 중지  ############################################################ >> %COMPUTERNAME%-4-1.log
echo ################################################################################### >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
echo START                                                                                 >> %COMPUTERNAME%-4-1.log
echo □ 기준 : 불필요한 TELNET 서비스 사용 제거                                               >> %COMPUTERNAME%-4-1.log
echo.																						 >> %COMPUTERNAME%-4-1.log
echo ■ 현황                                                                                  >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
net start | find "Telnet" > NUL
IF ERRORLEVEL 1 GOTO TELNET-DISABLE
IF NOT ERRORLEVEL 1 GOTO TELNET-ACTIVE

:TELNET-ACTIVE
echo ☞ TELNET 서비스가 사용 중 입니다.                                                      >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log

:4-1-bad
echo. >> %COMPUTERNAME%-4-1.log
echo ※ 불필요한 경우 Telnet 서비스 중지를 권고  											 >> %COMPUTERNAME%-4-1.log
echo. >> %COMPUTERNAME%-4-1.log
ECHO @ 취약 - 4.1 Telnet 서비스 보안 설정 >> %COMPUTERNAME%-4-1.log | echo @ 취약 - 4.1 Telnet 서비스 보안 설정 >> result.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
type %COMPUTERNAME%-4-1.log >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-4-1.log >> %COMPUTERNAME%-test.log
goto 4-2

:TELNET-DISABLE
ECHO ☞ TELNET 서비스가 사용 중이지 않습니다.                                                >> %COMPUTERNAME%-4-1.log 
echo.                                                                                        >> %COMPUTERNAME%-4-1.log

:4-1-good
echo. 																						 >> %COMPUTERNAME%-4-1.log
echo ※ 불필요한 경우 Telnet 서비스 중지를 권고  											 >> %COMPUTERNAME%-4-1.log
echo. 																						 >> %COMPUTERNAME%-4-1.log
echo @ 양호 - 4.1 Telnet 서비스 보안 설정                                                    >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
echo.                                                                                        >> %COMPUTERNAME%-4-1.log
type %COMPUTERNAME%-4-1.log 															     >> %COMPUTERNAME%-test.log  




:4-2
echo ### 4.2 DNS 보안 설정  ###############################################################
echo END################################################################################  > %COMPUTERNAME%-4-2.log
echo ### 4.2 DNS 보안 설정  ################################################################ >> %COMPUTERNAME%-4-2.log
echo ################################################################################### >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
echo START                                                                                 >> %COMPUTERNAME%-4-2.log
echo □ 기준 : DNS서비스를 사용 않거나 영역전송이 '아무 서버로' 설정되어 있지 않으면 양호 >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
echo ■ 현황                                                                               >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
net start | find "DNS Server" > NUL
IF ERRORLEVEL 1 GOTO DNS-DISABLE
IF NOT ERRORLEVEL 1 GOTO DNS-ACTIVE

:DNS-ACTIVE
ECHO ☞ DNS 서비스가 사용 중입니다.                                                        >> %COMPUTERNAME%-4-2.log
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
echo ※ 불필요한 경우 DNS 서비스를 중지하거나, 사용할 경우 영역 전송을 “아무 서버로” 설정하지 않는 것을 권고 >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
ECHO @ 취약 - 4.2 DNS(Domain Name Service) 보안 설정 >> %COMPUTERNAME%-4-2.log | echo @ 취약 - 4.2 DNS(Domain Name Service) 보안 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log

type %COMPUTERNAME%-4-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-4-2.log                                                                >> %COMPUTERNAME%-test.log
goto 4-3

:4-2-good
echo. >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo ※ 불필요한 경우 DNS 서비스를 중지하거나, 사용할 경우 영역 전송을 “아무 서버로” 설정하지 않는 것을 권고 >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo @ 양호 - 4.2 DNS(Domain Name Service) 보안 설정                                      >> %COMPUTERNAME%-4-2.log
type %COMPUTERNAME%-4-2.log                                                                >> %COMPUTERNAME%-test.log
goto 4-3

:DNS-DISABLE
ECHO ☞ DNS 서비스가 사용 중이지 않습니다.                                                 >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo ※ 불필요한 경우 DNS 서비스를 중지하거나, 사용할 경우 영역 전송을 “아무 서버로” 설정하지 않는 것을 권고 >> %COMPUTERNAME%-4-2.log
echo. >> %COMPUTERNAME%-4-2.log
echo @ 양호 - 4.2 DNS(Domain Name Service) 보안 설정                                      >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
echo.                                                                                      >> %COMPUTERNAME%-4-2.log
type %COMPUTERNAME%-4-2.log                                                                >> %COMPUTERNAME%-test.log




:4-3
echo ### 4.3 SNMP 서비스 보안 설정  ######################################################### 
echo END################################################################################  > %COMPUTERNAME%-4-3.log
echo ### 4.3 SNMP 서비스 보안 설정  ########################################################## >> %COMPUTERNAME%-4-3.log
echo ################################################################################### >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo START                                                                                 >> %COMPUTERNAME%-4-3.log
echo □ 기준 : SNMP 서비스를 사용하지 않거나 Community String을 사용하지 않거나 public, private이 아닌 >> %COMPUTERNAME%-4-3.log
echo          9자리 이상의 자릿수와 숫자, 기호를 혼합하여 사용 또는 NULL 값이 설정되어 있으면 양호    >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo ■ 현황                                                                               >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
net start | find /i "SNMP Service" >nul                 
IF ERRORLEVEL 1 GOTO 4-3-SNMP-DISABLE                                                      >> %COMPUTERNAME%-4-3.log
IF NOT ERRORLEVEL 1 GOTO 4-3-SNMP-ACTIVE                                                   >> %COMPUTERNAME%-4-3.log

:4-3-SNMP-DISABLE
echo ☞ SNMP 서비스가 사용중이지 않습니다.                                                 >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo @ 양호 - 4.3 SNMP(Simple Network Management Protocol) 서비스 보안 설정               >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
type %COMPUTERNAME%-4-3.log                                                                >> %COMPUTERNAME%-test.log
goto 5-1

:4-3-SNMP-ACTIVE
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo ☞ SNMP 서비스가 사용중입니다.                                                        >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log

echo ************************  Community String(커뮤니티 이름)  ************************** >> %COMPUTERNAME%-4-3.log
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
IF ERRORLEVEL 1 echo @ 양호 - 4.3 SNMP(Simple Network Management Protocol) 서비스 보안 설정  >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
type %COMPUTERNAME%-4-3.log                                                                >> %COMPUTERNAME%-test.log
goto 5-1


:4-3-bad
echo. >> %COMPUTERNAME%-4-3.log
echo ※ 불필요한 경우 SNMP 서비스를 중지 하거나, Community String을 사용하지 않거나 >> %COMPUTERNAME%-4-3.log
echo    public, private이 아닌 9자리 이상으로 복잡하게 설정 권고 					>> %COMPUTERNAME%-4-3.log
echo. 																				>> %COMPUTERNAME%-4-3.log
ECHO @ 취약 - 4.3 SNMP(Simple Network Management Protocol) 서비스 보안 설정 >> %COMPUTERNAME%-4-3.log | echo @ 취약 - 4.3 SNMP(Simple Network Management Protocol) 서비스 보안 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.
type %COMPUTERNAME%-4-3.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-4-3.log                                                                >> %COMPUTERNAME%-test.log
goto 5-1


:4-3-good
ECHO ☞ SNMP 서비스가 실행중이나, 커뮤니티 스트링 설정 값 없음                                              >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo ※ 불필요한 경우 SNMP 서비스를 중지 하거나, Community String을 사용하지 않거나 >> %COMPUTERNAME%-4-3.log
echo    public, private이 아닌 9자리 이상으로 복잡하게 설정 권고 					>> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo @ 양호 - 4.3 SNMP(Simple Network Management Protocol) 서비스 보안 설정                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
echo.                                                                                      >> %COMPUTERNAME%-4-3.log
type %COMPUTERNAME%-4-3.log                                                                >> %COMPUTERNAME%-test.log

:5-1

echo ### 5.1 최신 서비스 팩 적용 확인  ########################################################
echo END################################################################################  > %COMPUTERNAME%-5-1.log
echo ### 5.1 최신 서비스 팩 적용 확인  ######################################################### >> %COMPUTERNAME%-5-1.log
echo ################################################################################### >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo START                                                                                 >> %COMPUTERNAME%-5-1.log
echo □ 기준 : 최신서비스팩을 사용하고 있으면 양호           							   >> %COMPUTERNAME%-5-1.log
echo          Windows2008-SP2, Windows2008R2-SP1, Windows2012 이상 SP0                   >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo 사용중인 OS는 %WinVer% 입니다.                                                        >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
%script%\psinfo | find "pack"                                                              >> 5-1-sp.log
%script%\psinfo | find "Kernel build number"                                               >> 5-2-sp.log
type 5-1-sp.log                           													>> %COMPUTERNAME%-5-1.log
type 5-2-sp.log                           													>> %COMPUTERNAME%-5-1.log
::%script%\psinfo | find "pack"                                                              >> %COMPUTERNAME%-5-1.log
::%script%\psinfo | find "Kernel build number"                                               >> %COMPUTERNAME%-5-1.log
systeminfo | findstr /i "버전 Version" | find /v "BIOS"									   >> %COMPUTERNAME%-5-1.log
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
echo ☞ 최신 서비스 팩이 설치되어 있지 않습니다.                                           >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo. >> %COMPUTERNAME%-5-1.log
echo ※ 최신 서비스팩 설치를 권고							   >> %COMPUTERNAME%-5-1.log

echo. >> %COMPUTERNAME%-5-1.log
echo @ 취약 - 5.1 최신 서비스 팩 적용 >> %COMPUTERNAME%-5-1.log | echo @ 취약 - 5.1 최신 서비스 팩 적용 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log

type %COMPUTERNAME%-5-1.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-5-1.log                                                                >> %COMPUTERNAME%-test.log
goto 5-2

:5-1-yes-sp
echo ☞ 최신 서비스 팩이 설치되어 있습니다.                                                >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo ※ 최신 서비스팩 설치를 권고							   >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo @ 양호 - 5.1 최신 서비스 팩 적용                                                     >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
echo.                                                                                      >> %COMPUTERNAME%-5-1.log
type %COMPUTERNAME%-5-1.log                                                                >> %COMPUTERNAME%-test.log
goto 5-2



:5-2
echo ### 5.2 최신 HOT FIX 적용 확인  #######################################################
echo END################################################################################  > %COMPUTERNAME%-5-2.log
echo ### 5.2 최신 HOT FIX 적용 확인  ######################################################## >> %COMPUTERNAME%-5-2.log
echo ################################################################################### >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo START                                                                                 >> %COMPUTERNAME%-5-2.log
echo □ 기준 : 6개월 이내의 최신 패치가 설치되어 있으면 양호								   				   >> %COMPUTERNAME%-5-2.log
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

echo ■ 현황                                                                                >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo ☞ 업데이트된 HOT FIX 목록 확인                                                       >> %COMPUTERNAME%-5-2.log
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
echo ☞ 기준 날짜                                                                              >> %COMPUTERNAME%-5-2.log
TYPE HotfixBaseday.log                                                                     >> %COMPUTERNAME%-5-2.log


IF %End_Date% LSS %Start_Date% GOTO 5-2-bad
IF %End_Date% GEQ %Start_Date% GOTO 5-2-good

:5-2-good
echo. >> %COMPUTERNAME%-5-2.log
echo ※ "Windows Update - 업데이트 확인" 에서 6개월 이내 최신 패치 설치를 권고             >> %COMPUTERNAME%-5-2.log
echo. 																					   >> %COMPUTERNAME%-5-2.log
echo @ 양호 - 5.2 최신 HOT FIX 적용                                                        >> %COMPUTERNAME%-5-2.log 
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
type %COMPUTERNAME%-5-2.log 			                                           		   >> %COMPUTERNAME%-test.log
goto 6-1


:5-2-bad
echo. >> %COMPUTERNAME%-5-2.log
echo ※ "Windows Update > 업데이트 확인" 에서 6개월 이내 최신 패치 설치를 권고             >> %COMPUTERNAME%-5-2.log
echo. 																					   >> %COMPUTERNAME%-5-2.log
ECHO @ 취약 - 5.2 최신 HOT FIX 적용 확인 >> %COMPUTERNAME%-5-2.log | echo @ 취약 - 5.2 최신 HOT FIX 적용 확인 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log 
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
type %COMPUTERNAME%-5-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-5-2.log                                                                >> %COMPUTERNAME%-test.log
goto 6-1

:5-2-bad1
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo   시스템에 설치된 HotFix 패치를 확인 할 수 없습니다.                                             >> %COMPUTERNAME%-5-2.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
echo ※ "Windows Update > 업데이트 확인" 에서 6개월 이내 최신 패치 설치를 권고             >> %COMPUTERNAME%-5-2.log
echo. 																					   >> %COMPUTERNAME%-5-2.log
ECHO @ 취약 - 5.2 최신 HOT FIX 적용 확인 >> %COMPUTERNAME%-5-2.log | echo @ 취약 - 5.2 최신 HOT FIX 적용 확인 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-5-2.log 
echo.                                                                                      >> %COMPUTERNAME%-5-2.log
type %COMPUTERNAME%-5-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-5-2.log                                                                >> %COMPUTERNAME%-test.log
goto 6-1




:6-1
echo ### 6.1 원격 로그파일 접근 진단  #########################################################
echo END###############################################################################  > %COMPUTERNAME%-6-1.log
echo ### 6.1 원격 로그파일 접근 진단  ########################################################## >> %COMPUTERNAME%-6-1.log
echo ################################################################################## >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
echo START                                                                                 >> %COMPUTERNAME%-6-1.log
echo □ 기준 : 로그 디렉터리 접근 권한에 Users/Everyone에 대해서 모든권한, 수정 및 쓰기 권한이 없으면 양호      >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-6-1.log
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
echo ※ 시스템 로그파일 디렉토리의 접근권한에 Users/Everyone 모든 권한, 수정, 쓰기 권한 제한 설정 권고 >> %COMPUTERNAME%-6-1.log
echo. >> %COMPUTERNAME%-6-1.log
ECHO @ 취약 - 6.1 원격 로그파일 접근 진단 >> %COMPUTERNAME%-6-1.log | echo @ 취약 - 6.1 원격 로그파일 접근 진단 >> result.log 
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log

type %COMPUTERNAME%-6-1.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-1.log                                                                >> %COMPUTERNAME%-test.log
goto 6-2

:6-1-good
echo. >> %COMPUTERNAME%-6-1.log
echo ※ 시스템 로그파일 디렉토리의 접근권한에 Users/Everyone 모든 권한, 수정, 쓰기 권한 제한 설정 권고 >> %COMPUTERNAME%-6-1.log
echo. >> %COMPUTERNAME%-6-1.log
echo @ 양호 - 6.1 원격 로그파일 접근 진단                                                  >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
echo.                                                                                      >> %COMPUTERNAME%-6-1.log
type %COMPUTERNAME%-6-1.log                                                                >> %COMPUTERNAME%-test.log
goto 6-2



:6-2
echo ### 6.2 화면 보호기 설정  ##############################################################
echo END################################################################################   > %COMPUTERNAME%-6-2.log
echo ### 6.2 화면 보호기 설정  ###############################################################  >> %COMPUTERNAME%-6-2.log
echo ###################################################################################  >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
echo START                                                                                 >> %COMPUTERNAME%-6-2.log
echo □ 기준 : 화면보호기를 설정하고 암호를 사용하며 대기 시간이 10분이면 양호             						  >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-6-2.log
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
echo ※ 화면보호기 설정(암호 사용, 대기 시간 10분) 권고			   >> %COMPUTERNAME%-6-2.log
echo. >> %COMPUTERNAME%-6-2.log
echo @ 양호 - 6.2 화면 보호기 설정                                                      		   >> %COMPUTERNAME%-6-2.log 
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
type %COMPUTERNAME%-6-2.log 			                                           		   >> %COMPUTERNAME%-test.log
goto 6-3


:6-2-bad
echo. >> %COMPUTERNAME%-6-2.log
echo ※ 화면보호기 설정(암호 사용, 대기 시간 10분) 권고													   >> %COMPUTERNAME%-6-2.log
echo. >> %COMPUTERNAME%-6-2.log
ECHO @ 취약 - 6.2 화면 보호기 설정 >> %COMPUTERNAME%-6-2.log | echo @ 취약 - 6.2 화면 보호기 설정 			>> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-2.log 
echo.                                                                                      >> %COMPUTERNAME%-6-2.log
type %COMPUTERNAME%-6-2.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-2.log                                                                >> %COMPUTERNAME%-test.log
goto 6-3




:6-3
echo ### 6.3 이벤트 뷰어 설정  ##############################################################
echo END################################################################################   > %COMPUTERNAME%-6-3.log
echo ### 6.3 이벤트 뷰어 설정  ###############################################################  >> %COMPUTERNAME%-6-3.log
echo ###################################################################################  >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo START                                                                                 >> %COMPUTERNAME%-6-3.log
echo □ 기준 : 최대 로그 크기 10240KB 이상이고, 로그 덮어쓰기 설정 옵션이 0 으로 설정되면 양호   >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo ☞ 응용 프로그램 로그크기 - 10485760(이상)                                            >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application\MaxSize"   >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo ☞ 보안 로그크기 - 10485760(이상)                                                     >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Security\MaxSize"      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo ☞ 시스템 로그크기 - 10485760(이상)                                                   >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\System\MaxSize"        >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log

echo [ HKLM\SYSTEM\CurrentControlSet\Services\Eventlog ]						>> %COMPUTERNAME%-6-3.log
echo ☞ 응용 프로그램 로그 덮어쓰기 설정 옵션 - 0(이벤트 덮어쓰기)                         >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application\Retention" >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo ☞ 보안 로그 덮어쓰기 설정 옵션 - 0(이벤트 덮어쓰기)                                  >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Security\Retention"    >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo ☞ 시스템 로그 덮어쓰기 설정 옵션 - 0(이벤트 덮어쓰기)                                >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\System\Retention"      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log

echo [ HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog ]		>> %COMPUTERNAME%-6-3.log
echo ☞ 응용 프로그램 로그 덮어쓰기 설정 옵션 - 0(이벤트 덮어쓰기)                         >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Eventlog\Application\Retention" >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo ☞ 보안 로그 덮어쓰기 설정 옵션 - 0(이벤트 덮어쓰기)                                  >> %COMPUTERNAME%-6-3.log
%script%\reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Eventlog\Security\Retention"    >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo ☞ 시스템 로그 덮어쓰기 설정 옵션 - 0(이벤트 덮어쓰기)                                >> %COMPUTERNAME%-6-3.log
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
echo ※ 이벤트 뷰어(로컬) 응용 프로그램, 보안, 시스템의 로그 설정 권고 >> %COMPUTERNAME%-6-3.log
echo. >> %COMPUTERNAME%-6-3.log
echo @ 취약 - 6.3 이벤트 뷰어 설정 >> %COMPUTERNAME%-6-3.log | echo @ 취약 - 6.3 이벤트 뷰어 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log

type %COMPUTERNAME%-6-3.log 								   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-3.log								   >> %COMPUTERNAME%-test.log
goto 6-4

:6-3-good
echo. >> %COMPUTERNAME%-6-3.log
echo ※ 이벤트 뷰어(로컬) 응용 프로그램, 보안, 시스템의 로그 설정 권고 >> %COMPUTERNAME%-6-3.log
echo. >> %COMPUTERNAME%-6-3.log
echo @ 양호 - 6.3 이벤트 뷰어 설정                                                        >> %COMPUTERNAME%-6-3.log 
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
echo.                                                                                      >> %COMPUTERNAME%-6-3.log
type %COMPUTERNAME%-6-3.log                                                                >> %COMPUTERNAME%-test.log






:6-4
echo ### 6.4 로그인 시 경고 메시지 표시 설정  ####################################################
echo END################################################################################   			> %COMPUTERNAME%-6-4.log
echo ### 6.4 로그인 시 경고 메시지 표시 설정  #####################################################		>> %COMPUTERNAME%-6-4.log
echo ###################################################################################  				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo START                                                                                 >> %COMPUTERNAME%-6-4.log
echo □ 기준 : 로그인시 경고 메시지가 표시되면 양호                                        				>> %COMPUTERNAME%-6-4.log
echo          경고 메시지 예)  제목   : 경고                                              				>> %COMPUTERNAME%-6-4.log
echo.                     예)  텍스트 : 불법적인 시스템 사용은 관련법에 의해 처벌을 받습니다.  			>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo ■ 현황                                                                               				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo [레지스트리 위치]                                                                     				>> %COMPUTERNAME%-6-4.log
echo [HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system]                    				>> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption"  >> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticetext"     >> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo [레지스트리 위치]                                                                     				>> %COMPUTERNAME%-6-4.log
echo [HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]                    					>> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeCaption"      >> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeText"         >> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo [관리도구 - 로컬보안정책 - 로컬정책 - 보안옵션]                                       				>> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption"  > comtype-6-4.log
FOR /F "tokens=3" %%a IN ('type comtype-6-4.log') DO echo %%a											> comtype-6-4.log
echo [대화형 로그온 : 로그온 시도하는 사용자에 대한 메세지 제목] 										>> %COMPUTERNAME%-6-4.log
type comtype-6-4.log																					>> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticetext"     > comtype-6-4.log
FOR /F "tokens=3" %%a IN ('type comtype-6-4.log') DO echo %%a											> comtype-6-4.log
echo [대화형 로그온 : 로그온 시도하는 사용자에 대한 메세지 텍스트] 										>> %COMPUTERNAME%-6-4.log
type comtype-6-4.log																					>> %COMPUTERNAME%-6-4.log
echo ------------------------------------------------------------------------------------				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      				>> %COMPUTERNAME%-6-4.log
echo.                                                                                      		    	>> %COMPUTERNAME%-6-4.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeCaption"       > 6-4-logonmessage-1.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption"  >> 6-4-logonmessage-1.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeText"          > 6-4-logonmessage.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\LegalNoticeText"     >> 6-4-logonmessage.log
findstr /I "불법 경고 처벌 warning authoriz law" 6-4-logonmessage-1.log > nul
IF NOT ERRORLEVEL 1 goto 6-4-text
IF ERRORLEVEL 1 goto 6-4-bad
:6-4-text
findstr /I "불법 경고 처벌 warning authoriz law" 6-4-logonmessage.log > nul
IF NOT ERRORLEVEL 1 goto 6-4-good

:6-4-bad
echo. >> %COMPUTERNAME%-6-4.log
echo ※ 비인가자의 시스템 로그인 시 불법적인 사용을 경고하는 메시지 설정 권고 >> %COMPUTERNAME%-6-4.log
echo. >> %COMPUTERNAME%-6-4.log
echo @ 취약 - 6.4 로그온 시 경고 메시지 표시 설정 >> %COMPUTERNAME%-6-4.log | echo @ 취약 - 6.4 로그온 시 경고 메시지 표시 설정 >> result.log 
echo.                                                                                      >> %COMPUTERNAME%-6-4.log
echo.                                                                                      >> %COMPUTERNAME%-6-4.log
type %COMPUTERNAME%-6-4.log 								   							   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-4.log								   	   							   >> %COMPUTERNAME%-test.log
goto 6-5

:6-4-good
echo. >> %COMPUTERNAME%-6-4.log
echo ※ 비인가자의 시스템 로그인 시 불법적인 사용을 경고하는 메시지 설정 권고 >> %COMPUTERNAME%-6-4.log
echo. >> %COMPUTERNAME%-6-4.log
echo @ 양호 - 6.4 로그온 시 경고 메시지 표시 설정 					   					   >> %COMPUTERNAME%-6-4.log
echo.                                                                                      >> %COMPUTERNAME%-6-4.log
echo.                                                                                      >> %COMPUTERNAME%-6-4.log
echo.                                                                                      >> %COMPUTERNAME%-6-4.log
type %COMPUTERNAME%-6-4.log							           							   >> %COMPUTERNAME%-test.log





:6-5
echo ### 6.5 마지막 로그온 사용자 계정 숨김 설정  #################################################
echo END################################################################################  > %COMPUTERNAME%-6-5.log
echo ### 6.5 마지막 로그온 사용자 계정 숨김 설정  ##################################################  >> %COMPUTERNAME%-6-5.log
echo ###################################################################################  >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
echo START                                                                                 >> %COMPUTERNAME%-6-5.log
echo □ 기준 : “마지막 로그온 사용자 숨김 설정”이 “사용”으로 설정되어 있을 경우 양호     >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
echo ■ 현황                                                                                 >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\DontDisplayLastUserName"   >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\DontDisplayLastUserName"   >> 6-5-lastlogon.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log

type 6-5-lastlogon.log | find "1" > nul
IF NOT ERRORLEVEL 1 goto 6-5-good
IF ERRORLEVEL 1 goto 6-5-bad

:6-5-bad
echo ※ “DontDisplayLastUserName” 레지스트리 값을 “1”로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-6-5.log
echo. >> %COMPUTERNAME%-6-5.log
ECHO @ 취약 - 6.5 마지막 로그온 사용자 계정 숨김 >> %COMPUTERNAME%-6-5.log | echo @ 취약 - 6.5 마지막 로그온 사용자 계정 숨김 >> result.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
type %COMPUTERNAME%-6-5.log                                                                  >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-5.log                                                                  >> %COMPUTERNAME%-test.log
goto 6-6

:6-5-good
echo ※ “DontDisplayLastUserName” 레지스트리 값을 “1”로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-6-5.log
echo. >> %COMPUTERNAME%-6-5.log
ECHO @ 양호 - 6.5 마지막 로그온 사용자 계정 숨김                                              >> %COMPUTERNAME%-6-5.log 
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
echo.                                                                                        >> %COMPUTERNAME%-6-5.log
type %COMPUTERNAME%-6-5.log                                                                  >> %COMPUTERNAME%-test.log



:6-6
echo ### 6.6 로그온 하지 않은 사용자 시스템 종료 방지  ##############################################
echo END################################################################################   > %COMPUTERNAME%-6-6.log
echo ### 6.6 로그온 하지 않은 사용자 시스템 종료 방지  ###############################################  >> %COMPUTERNAME%-6-6.log
echo ###################################################################################  >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo START                                                                                 >> %COMPUTERNAME%-6-6.log
echo □ 기준 : '로그온하지 않고 시스템 종료 허용'이 '사용안함'으로 설정되어 있을 경우       >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon" >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon" | find /v "ShutdownWithoutLogon	0" > nul
IF ERRORLEVEL 1 goto 6-6-good
IF NOT ERRORLEVEL 1 goto 6-6-bad

:6-6-bad
echo. >> %COMPUTERNAME%-6-6.log
echo ※ “ShutdownWithoutLogon” 레지스트리 값을 “0”로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-6-5.log
echo. >> %COMPUTERNAME%-6-6.log
ECHO @ 취약 - 6.6 로그온하지 않은 사용자 시스템종료 방지 >> %COMPUTERNAME%-6-6.log | echo @ 취약 - 6.6 로그온하지 않은 사용자 시스템종료 방지 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log                                                                                          

type %COMPUTERNAME%-6-6.log							           >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-6.log 								   >> %COMPUTERNAME%-test.log
goto 6-7

:6-6-good 	
echo. >> %COMPUTERNAME%-6-6.log
echo ※ “ShutdownWithoutLogon” 레지스트리 값을 “0”로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo @ 양호 - 6.6 로그온 하지 않은 사용자 시스템종료 방지			           >> %COMPUTERNAME%-6-6.log 
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
echo.                                                                                      >> %COMPUTERNAME%-6-6.log
type %COMPUTERNAME%-6-6.log								   >> %COMPUTERNAME%-test.log





:6-7
echo ### 6.7 로컬 보안 감사정책 설정  ##########################################################
echo END################################################################################   > %COMPUTERNAME%-6-7.log
echo ### 6.7 로컬 보안 감사정책 설정  ###########################################################  >> %COMPUTERNAME%-6-7.log
echo ###################################################################################  >> %COMPUTERNAME%-6-7.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
echo START                                                                                 >> %COMPUTERNAME%-6-7.log
echo □ 기준 : 이벤트 감사 항목에 대해서 반드시 '성공'과 '실패' 감사가 설정되어 있으면 양호    >> %COMPUTERNAME%-6-7.log
echo ( 필수적용감사정책 : 계정관리 감사, 계정로그온이벤트 감사, 권한사용 감사, 로그온 이벤트 감사 )    >> %COMPUTERNAME%-6-7.log
echo ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ       >> %COMPUTERNAME%-6-7.log
echo 개체 액세스 감사        (Logon)                                                        >> %COMPUTERNAME%-6-7.log
echo 계정 관리 감사          (Object Access)                                                >> %COMPUTERNAME%-6-7.log
echo 계정 로그온 이벤트 감사 (Account Logon)                                                >> %COMPUTERNAME%-6-7.log
echo 권한 사용 감사          (Account Management)                                           >> %COMPUTERNAME%-6-7.log
echo 로그온 이벤트 감사      (Privilege Use)                                                >> %COMPUTERNAME%-6-7.log
echo ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ   	>> %COMPUTERNAME%-6-7.log

echo.                                                                                       >> %COMPUTERNAME%-6-7.log
echo ■ 현황                                                                                 >> %COMPUTERNAME%-6-7.log
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
echo ※ 개체엑세스 감사, 계정관리 감사, 계정로그온이벤트 감사, 권한사용 감사, 로그온 이벤트 감사  >> %COMPUTERNAME%-6-7.log
echo 에 대해서는 반드시 성공과 실패 감사 설정을 권고     										  >> %COMPUTERNAME%-6-7.log
echo. >> %COMPUTERNAME%-6-7.log
ECHO @ 취약 - 6.7 로컬 감사정책 설정 >> %COMPUTERNAME%-6-7.log | echo @ 취약 - 6.7 로컬 감사정책 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
type %COMPUTERNAME%-6-7.log								   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-7.log 								   >> %COMPUTERNAME%-test.log
goto 6-8


:6-7-good
echo. >> %COMPUTERNAME%-6-7.log
echo ※ 개체엑세스 감사, 계정관리 감사, 계정로그온이벤트 감사, 권한사용 감사, 로그온 이벤트 감사  >> %COMPUTERNAME%-6-7.log
echo 에 대해서는 반드시 성공과 실패 감사 설정을 권고     										  >> %COMPUTERNAME%-6-7.log
echo. >> %COMPUTERNAME%-6-7.log
echo @ 양호 - 6.7 로컬 감사정책 설정                                                       >> %COMPUTERNAME%-6-7.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
echo.                                                                                      >> %COMPUTERNAME%-6-7.log
type %COMPUTERNAME%-6-7.log 								   							   >> %COMPUTERNAME%-test.log



:6-8
echo ### 6.8 가상 메모리 페이지 파일 삭제 설정  ###################################################
echo END################################################################################  > %COMPUTERNAME%-6-8.log
echo ### 6.8 가상 메모리 페이지 파일 삭제 설정  #################################################### >> %COMPUTERNAME%-6-8.log
echo ################################################################################### >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
echo START                                                                                 >> %COMPUTERNAME%-6-8.log
echo □ 기준 : '시스템이 종료할 때 가상 메모리 페이지 파일 지움' 항목이 '사용'으로 설정되어 있으면 양호   >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\ClearPageFileAtShutdown"   >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\ClearPageFileAtShutdown" | find /I "1" > nul
IF NOT ERRORLEVEL 1 goto 6-8-good
IF ERRORLEVEL 1 goto 6-8-bad

:6-8-bad
echo. >> %COMPUTERNAME%-6-8.log
echo ※ "ClearPageFileAtShutdown" 레지스트리 값을 “1”로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-6-8.log
echo. >> %COMPUTERNAME%-6-8.log
ECHO @ 취약 - 6.8 가상 메모리 페이지 파일 삭제 설정 >> %COMPUTERNAME%-6-8.log | echo @ 취약 - 6.8 가상 메모리 페이지 파일 삭제 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
type %COMPUTERNAME%-6-8.log 		                                                   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-8.log 		                                                   >> %COMPUTERNAME%-test.log
goto 6-9

:6-8-good
echo. >> %COMPUTERNAME%-6-8.log
echo ※ "ClearPageFileAtShutdown" 레지스트리 값을 “1”로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-6-8.log
echo. >> %COMPUTERNAME%-6-8.log
echo @ 양호 - 6.8 가상 메모리 페이지 파일 삭제 설정	                                   >> %COMPUTERNAME%-6-8.log 
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
echo.                                                                                      >> %COMPUTERNAME%-6-8.log
type %COMPUTERNAME%-6-8.log 		                                                   >> %COMPUTERNAME%-test.log

:6-9
echo ### 6.9 프린터 드라이버 설치 설정  ######################################################### 
echo END#################################################################################  > %COMPUTERNAME%-6-9.log
echo ### 6.9 프린터 드라이버 설치 설정  ########################################################## >> %COMPUTERNAME%-6-9.log
echo #################################################################################### >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
echo START                                                                                 >> %COMPUTERNAME%-6-9.log
echo □ 기준 : '사용자가 프린터 드라이버를 설치 할 수 없게 함' 항목이 '사용'으로 설정되어 있으면 양호   >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers\AddPrinterDrivers"   	>> %COMPUTERNAME%-6-9.log
echo.                                                                                      						>> %COMPUTERNAME%-6-9.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers\AddPrinterDrivers" | find /I "1" > nul
IF NOT ERRORLEVEL 1 goto 6-9-good
IF ERRORLEVEL 1 goto 6-9-bad

:6-9-bad
echo. >> %COMPUTERNAME%-6-9.log
echo ※ "AddPrinterDrivers" 레지스트리 값을 “1”로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-6-9.log
echo. >> %COMPUTERNAME%-6-9.log
ECHO @ 취약 - 6.9 프린터 드라이버 설치 설정 >> %COMPUTERNAME%-6-9.log | echo @ 취약 - 6.9 프린터 드라이버 설치 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
type %COMPUTERNAME%-6-9.log 		                                                   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-6-9.log 		                                                   >> %COMPUTERNAME%-test.log
goto 7-1

:6-9-good
echo. >> %COMPUTERNAME%-6-9.log
echo ※ "AddPrinterDrivers" 레지스트리 값을 “1”로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-6-9.log
echo. >> %COMPUTERNAME%-6-9.log
echo @ 양호 - 6.9 프린터 드라이버 설치 설정	                                   			   >> %COMPUTERNAME%-6-9.log 
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
echo.                                                                                      >> %COMPUTERNAME%-6-9.log
type %COMPUTERNAME%-6-9.log 		                                                       >> %COMPUTERNAME%-test.log





:7-1
echo ### 7.1 백신 프로그램 설치  ##############################################################
echo END#################################################################################   > %COMPUTERNAME%-7-1.log
echo ### 7.1 백신 프로그램 설치  ###############################################################  >> %COMPUTERNAME%-7-1.log
echo ####################################################################################  >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
echo START                                                                                 >> %COMPUTERNAME%-7-1.log
echo □ 기준 : 상용 백신 프로그램을 설치하고 실시간 감시 기능을 활성화하고 있으면 양호       >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
echo ■ 현황                                                                                 >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log 
::net start | find /I "AhnLab Application Service" > nul
::IF ERRORLEVEL 1 ECHO ☞ 바이러스 백신 프로그램(V3 Windows Server)가 설치되어 있지 않습니다.                >> %COMPUTERNAME%-7-1.log 
::IF NOT ERRORLEVEL 1 ECHO ☞ 바이러스 백신 프로그램(V3 Windows Server)가 설치되어 있습니다.                 >> %COMPUTERNAME%-7-1.log
::echo.                                                                                       >> %COMPUTERNAME%-7-1.log 
net start | find /I "Symantec Endpoint Protection" > nul
IF ERRORLEVEL 1 ECHO ☞ 바이러스 백신 프로그램(Symantec Endpoint Protection) 설치되어 있지 않습니다.                >> %COMPUTERNAME%-7-1.log 
IF NOT ERRORLEVEL 1 ECHO ☞ 바이러스 백신 프로그램(Symantec Endpoint Protection) 설치되어 있습니다.                 >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log 
net start | find /I "eset" > nul
IF ERRORLEVEL 1 ECHO ☞ 바이러스 백신 프로그램(ESET) 설치되어 있지 않습니다.                >> %COMPUTERNAME%-7-1.log 
IF NOT ERRORLEVEL 1 ECHO ☞ 바이러스 백신 프로그램(ESET) 설치되어 있습니다.                 >> %COMPUTERNAME%-7-1.log
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
echo ※ 상용 백신 프로그램을 설치하고 실시간 감시 기능을 활성화 권고 >> %COMPUTERNAME%-7-1.log
echo. >> %COMPUTERNAME%-7-1.log
ECHO @ 취약 - 7.1 백신 프로그램 설치 >> %COMPUTERNAME%-7-1.log | echo @ 취약 - 7.1 백신 프로그램 설치 >> result.log 
echo.                                                                                       >> %COMPUTERNAME%-7-1.log 
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
type %COMPUTERNAME%-7-1.log 								    >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-7-1.log 								    >> %COMPUTERNAME%-test.log
goto 7-2

:7-1-good
echo. >> %COMPUTERNAME%-7-1.log
echo ※ 상용 백신 프로그램을 설치하고 실시간 감시 기능을 활성화 권고 >> %COMPUTERNAME%-7-1.log
echo. >> %COMPUTERNAME%-7-1.log
echo @ 양호 - 7.1 백신 프로그램 설치                                                       >> %COMPUTERNAME%-7-1.log 
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
echo.                                                                                       >> %COMPUTERNAME%-7-1.log
type %COMPUTERNAME%-7-1.log								    >> %COMPUTERNAME%-test.log


:7-2
echo ### 7.2 최신 엔진 업데이트  ##############################################################
echo END#################################################################################  > %COMPUTERNAME%-7-2.log
echo ### 7.2 최신 엔진 업데이트  ############################################################### >> %COMPUTERNAME%-7-2.log
echo #################################################################################### >> %COMPUTERNAME%-7-2.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
echo START                                                                                 >> %COMPUTERNAME%-7-2.log
echo □ 기준 : 상용 백신 프로그램이 설치되어 있거나 최신 엔진 업데이트가 설치되어 있으면 양호  >> %COMPUTERNAME%-7-2.log                
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
echo ■ 현황                                                                                >> %COMPUTERNAME%-7-2.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log 
for /f %%i in ('cscript //nologo %script%\OldDateCode3.vbs') do set cu_date=%%i

::net start | find /i "Symantec Endpoint Protection WSC Service" > nul
::net start | find /I "Symantec Endpoint Protection"                                  >> %COMPUTERNAME%-7-2.log 
::net start | find /I "eset"                              						    >> %COMPUTERNAME%-7-2.log 
::IF ERRORLEVEL 1 ECHO ☞ APC(AhnLab Policy Agent)가 설치되어 있지 않습니다.                 >> %COMPUTERNAME%-7-2.log 
::IF NOT ERRORLEVEL 1 ECHO ☞ APC(AhnLab Policy Agent)가 설치되어 있습니다.                  >> %COMPUTERNAME%-7-2.log
::IF ERRORLEVEL 1 goto 7-2-SEP
::IF NOT ERRORLEVEL 1 goto 7-2-V3
::echo.                                                                                      >> %COMPUTERNAME%-7-2.log 

:::7-2-V3
::echo.                                                                                      >> %COMPUTERNAME%-7-2.log 
::echo ☞ [ V3 엔진 업데이트 날짜 ]                                                              >> %COMPUTERNAME%-7-2.log
::reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Ahnlab\V3Net70" /v "V3EngineDate" | findstr "V3EngineDate"                  >> %COMPUTERNAME%-7-2.log
::reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Ahnlab\V3Net70" /v "V3EngineDate" | findstr "V3EngineDate"                  >> V3.log
::FOR /F "TOKENS=3" %%i IN ('type V3.log') DO echo %%i >> V3-1.log
::FOR /F "TOKENS=1,2,3 delims=." %%i IN ('type V3-1.log') DO set v3date=%%i%%j%%k
::if not %cu_date% LSS %v3date% goto V3NSU
::goto 7-2-SEP
:::V3NSU
::echo   백신엔진이 업데이트 되지 않았습니다.  >> %COMPUTERNAME%-7-2.log
::set enginebad=0
::GOTO 7-2-SEP

:7-2-SEP
::net start | find /i "Endpoint Protection WSC Service" > nul
net start | find /I "Symantec Endpoint Protection"  > nul
IF ERRORLEVEL 1 ECHO ☞ Endpoint Protection Service 설치되어 있지 않습니다.               			  >> %COMPUTERNAME%-7-2.log 
IF NOT ERRORLEVEL 1 ECHO ☞ Endpoint Protection Service 최신 업데이트 설치되어 있습니다.                 >> %COMPUTERNAME%-7-2.log
echo.                                                                                       >> %COMPUTERNAME%-7-2.log 
net start | find /I "eset"   > nul
IF ERRORLEVEL 1 ECHO ☞ 바이러스 백신 프로그램(ESET) 설치되어 있지 않습니다.             			   >> %COMPUTERNAME%-7-2.log 
IF NOT ERRORLEVEL 1 ECHO ☞ 바이러스 백신 프로그램(ESET) 최신 업데이트 설치되어 있습니다.                 >> %COMPUTERNAME%-7-2.log
echo. 																							>> %COMPUTERNAME%-7-2.log 
net start | find /I "eset" > nul
IF NOT ERRORLEVEL 1 goto 7-2-good
net start | find /I "Symantec Endpoint Protection"	
IF ERRORLEVEL 1 goto 7-2-bad
IF NOT ERRORLEVEL 1 goto 7-2-good


::net start | find /I "Symantec Endpoint Protection" > nul
::echo.                                                                                                                                        >> %COMPUTERNAME%-7-2.log 
::IF NOT ERRORLEVEL 1 ECHO ☞ Endpoint Protection Service 최신 업데이트 설치되어 있습니다.                                                   >> %COMPUTERNAME%-7-2.log
::IF ERRORLEVEL 1 ECHO ☞ Endpoint Protection Service 설치되어 있지 않습니다.                                                  >> %COMPUTERNAME%-7-2.log
::IF NOT ERRORLEVEL 1 GOTO 7-2-good
::IF ERRORLEVEL 1 GOTO :7-2-bad
::echo.                                                                                                                                        >> %COMPUTERNAME%-7-2.log 


:::7-2-SEP1
::echo.                                                                                                                                        >> %COMPUTERNAME%-7-2.log 
::echo ☞ [ SEP 엔진 업데이트 날짜 ]                                                                                                               >> %COMPUTERNAME%-7-2.log
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
::ECHO   백신 엔진이 업데이트 되지 않았습니다.  >> %COMPUTERNAME%-7-2.log
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
echo ※ 백신 프로그램 최신 엔진 업데이트 설치 권고 				   >> %COMPUTERNAME%-7-2.log
echo. 																					   >> %COMPUTERNAME%-7-2.log
ECHO @ 취약 - 7.2 최신 엔진 업데이트 >> %COMPUTERNAME%-7-2.log | echo @ 취약 - 7.2 최신 엔진 업데이트 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log 
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
type %COMPUTERNAME%-7-2.log 								   							   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-7-2.log								   								   >> %COMPUTERNAME%-test.log
goto 8-2

:7-2-good
echo. >> %COMPUTERNAME%-7-2.log
echo ※ 백신 프로그램이 최신 엔진 업데이트 설치 권고 				   >> %COMPUTERNAME%-7-2.log
echo. 																					   >> %COMPUTERNAME%-7-2.log
echo @ 양호 - 7.2 최신 엔진 업데이트                                                       >> %COMPUTERNAME%-7-2.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
echo.                                                                                      >> %COMPUTERNAME%-7-2.log
type %COMPUTERNAME%-7-2.log 								   							   >> %COMPUTERNAME%-test.log

                                                    
:::8-1
::echo ### 8.1 SAM 보안 감사 설정  ############################################################
::echo END#################################################################################  > %COMPUTERNAME%-8-1.log
::echo ### 8.1 SAM 보안 감사 설정  ############################################################# >> %COMPUTERNAME%-8-1.log
::echo #################################################################################### >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo START                                                                                 >> %COMPUTERNAME%-8-1.log
::echo □ 기준 : 해당 레지스트리 값에 Everyone 에 대한 감사설정이 되어 있으면 양호            >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo ■ 현황                                                                                >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo ☞ SAM 레지스트리 값에 Everyone 감사 설정 활성화                                             >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo @ 양호 - 8.1 SAM 보안 감사 설정 															   >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::echo.                                                                                      >> %COMPUTERNAME%-8-1.log
::type %COMPUTERNAME%-8-1.log 								   							   >> %COMPUTERNAME%-list.log
::type %COMPUTERNAME%-8-1.log								                                   >> %COMPUTERNAME%-test.log



:8-2
echo ### 8.1 Null Session 설정  ##########################################################
echo END#################################################################################  > %COMPUTERNAME%-8-2.log
echo ### 8.1 Null Session 설정  ########################################################### >> %COMPUTERNAME%-8-2.log
echo #################################################################################### >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
echo START                                                                                 >> %COMPUTERNAME%-8-2.log
echo □ 기준 : 해당 레지스트리의 "RestrictAnonymous"값이 2로 설정되어 있으면 양호                                   >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
echo ■ 현황                                                                               >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\LSA\restrictanonymous"           >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\LSA\restrictanonymous" | find /I "2" > nul
IF NOT ERRORLEVEL 1 goto 8-2-good
IF ERRORLEVEL 1 goto 8-2-bad

:8-2-bad
echo. >> %COMPUTERNAME%-8-2.log
echo ※ "RestrictAnonymous" 레지스트리 값을 “2”로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-8-2.log
echo. >> %COMPUTERNAME%-8-2.log
ECHO @ 취약 - 8.1 Null Session 설정 >> %COMPUTERNAME%-8-2.log | echo @ 취약 - 8.1 Null Session 설정  >> result.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
type %COMPUTERNAME%-8-2.log 								   							   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-8-2.log 								   							   >> %COMPUTERNAME%-test.log
goto 8-3

:8-2-good
echo. >> %COMPUTERNAME%-8-2.log
echo ※ "RestrictAnonymous" 레지스트리 값을 “2”로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-8-2.log
echo. >> %COMPUTERNAME%-8-2.log
echo @ 양호 - 8.1 Null Session 설정						   								   >> %COMPUTERNAME%-8-2.log 
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
echo.                                                                                      >> %COMPUTERNAME%-8-2.log
type %COMPUTERNAME%-8-2.log 								   							   >> %COMPUTERNAME%-test.log



:8-3
echo ### 8.2 Remote Registry 서비스 설정  ##################################################
echo END################################################################################  > %COMPUTERNAME%-8-3.log
echo ### 8.2 Remote Registry 서비스 설정  ################################################### >> %COMPUTERNAME%-8-3.log
echo ################################################################################### >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
echo START                                                                                 >> %COMPUTERNAME%-8-3.log
echo □ 기준 : Remote Registry Service 가 중지되어 있으면 양호                          			   >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
echo ■ 현황                                                                                  >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
net start | find "Remote Registry" > nul
IF ERRORLEVEL 1 GOTO 8-3-good
IF NOT ERRORLEVEL 1 GOTO 8-3-bad


:8-3-bad
ECHO ☞ Remote Registry Service를 사용중입니다.                                       			   >> %COMPUTERNAME%-8-3.log
echo.																					   >> %COMPUTERNAME%-8-3.log
echo ※ 불필요한 경우 Remote Registry 서비스 제거 권고 										  	 >> %COMPUTERNAME%-8-3.log
echo    Remote Registry Service 사용 유/무로만 양호/취약을 판별합니다                     			 >> %COMPUTERNAME%-8-3.log
echo. 																					   >> %COMPUTERNAME%-8-3.log
ECHO @ 취약 - 8.2 Remote Registry 서비스 설정 >> %COMPUTERNAME%-8-3.log | echo @ 취약 - 8.2 Remote Registry 서비스 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
type %COMPUTERNAME%-8-3.log 								   							   >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-8-3.log 								                               >> %COMPUTERNAME%-test.log
GOTO 8-4

:8-3-good
echo ☞ Remote Registry Service를 사용중이지 않습니다.                                   		   >> %COMPUTERNAME%-8-3.log
echo.																					   >> %COMPUTERNAME%-8-3.log
echo ※ 불필요한 경우 Remote Registry 서비스 제거 권고 											   >> %COMPUTERNAME%-8-3.log
echo    Remote Registry Service 사용 유/무로만 양호/취약을 판별합니다                    			   >> %COMPUTERNAME%-8-3.log
echo. 																					   >> %COMPUTERNAME%-8-3.log
echo @ 양호 - 8.2 Remote Registry 서비스 설정                                     		       >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
echo.                                                                                      >> %COMPUTERNAME%-8-3.log
type %COMPUTERNAME%-8-3.log                                                                >> %COMPUTERNAME%-test.log




:8-4
echo ### 8.3 AutoLogon 제한 설정  #########################################################
echo END################################################################################  > %COMPUTERNAME%-8-4.log
echo ### 8.3 AutoLogon 제한 설정  ########################################################## >> %COMPUTERNAME%-8-4.log
echo ################################################################################### >> %COMPUTERNAME%-8-4.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo START                                                                                 >> %COMPUTERNAME%-8-4.log
echo □ 기준 : 해당 레지스트 AutoAdminLogon 값이 없거나 0으로 설정되어 있으면 양호                       >> %COMPUTERNAME%-8-4.log

echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo ■ 현황                                                                               >> %COMPUTERNAME%-8-4.log

echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo ☞ AutoAdminLogon                                                                     >> %COMPUTERNAME%-8-4.log
::%script%\reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" | find /I "AutoAdminLogon" >> %COMPUTERNAME%-8-4.log
%script%\reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" | find /I "AutoAdminLogon" >> %COMPUTERNAME%-8-4.log

::echo.                                                                                      >> %COMPUTERNAME%-8-4.log
::echo ☞ DefaultUserName                                                                     >> %COMPUTERNAME%-8-4.log
::%script%\reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultUserName" | find /I "DefaultUserName" >> %COMPUTERNAME%-8-4.log
::reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultUserName" | find /I "DefaultUserName" >> %COMPUTERNAME%-8-4.log

echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo ☞ DefaultPassword                                                                     >> %COMPUTERNAME%-8-4.log
%script%\reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "DefaultPassword" | find /I "DefaultPassword"  >> %COMPUTERNAME%-8-4.log

echo.                                                                                      >> %COMPUTERNAME%-8-4.log
%script%\reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" | find /I "AutoAdminLogon" | find "1" > nul
IF ERRORLEVEL 1 goto 8-4-good
IF NOT ERRORLEVEL 1 goto 8-4-bad

:8-4-bad
echo. >> %COMPUTERNAME%-8-4.log
echo ※ “AutoAdminLogon” 레지스트리 값이 없거나 “0”으로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-8-4.log
echo. >> %COMPUTERNAME%-8-4.log
ECHO @ 취약 - 8.3 AutoLogon 제한 설정 >> %COMPUTERNAME%-8-4.log | echo @ 취약 - 8.3 AutoLogon 제한 설정 >> result.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo.                                                                                      >> %COMPUTERNAME%-8-4.log
echo END                                                                                   >> %COMPUTERNAME%-8-4.log
type %COMPUTERNAME%-8-4.log                                                                >> %COMPUTERNAME%-list.log
type %COMPUTERNAME%-8-4.log                                                                >> %COMPUTERNAME%-test.log
goto IIS start

:8-4-good
echo. >> %COMPUTERNAME%-8-4.log
echo ※ “AutoAdminLogon” 레지스트리 값이 없거나 “0”으로 설정, 레지스트리 추가/변경/삭제 시 레지스트리 백업 권고 >> %COMPUTERNAME%-8-4.log
echo. >> %COMPUTERNAME%-8-4.log
echo @ 양호 - 8.3 AutoLogon 제한 설정                                                     >> %COMPUTERNAME%-8-4.log
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
echo [ IIS 서비스 사용 유/무 확인중 ]
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1	GOTO END
IF NOT ERRORLEVEL 1 GOTO IIS


:end-3
	
:IIS

:: IIS Version 구하기
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters" | find /i "version" > iis-version.txt
type iis-version.txt | find /i "major"                                                        > iis-version-major.txt
for /f "tokens=3" %%a in (iis-version-major.txt) do set iis_ver_major=%%a
del iis-version-major.txt 2> nul


:: WebSite List 구하기 ( website-list.txt )
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list site | find /i "http"                             > website-list.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs enum W3SVC | find /i "W3SVC" | findstr /i /v "FILTERS APPPOOLS INFO" > website-list.txt
)

:: WebSite Name 구하기 ( website-name.txt )
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

:: Web Site physicalpath 구하기 ( website-physicalpath.txt )
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


echo ※ IIS 서비스 사용중으로 진단 시작
echo.	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo ***************************************************************************************	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo ☞ IIS 서비스를 사용하고 있음	  >> %COMPUTERNAME%-w.log
echo ※ IIS IIS Version %IISV%	>> %COMPUTERNAME%-w.log

::set CODE=W-00
::echo #######################################################################################	>> %COMPUTERNAME%-w.log
::echo IIS 서비스 구동 점검	>> %COMPUTERNAME%-w.log
::echo #######################################################################################	>> %COMPUTERNAME%-w.log
::net start | find "World Wide Web Publishing" > nul
::IF ERRORLEVEL 1 echo 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
::IF NOT ERRORLEVEL 1 (
::	echo 결과 : IIS 서비스를 사용하고 있음	>> %COMPUTERNAME%-w.log
::	echo IIS 서비스를 사용하고 있음
::	echo.	>> %COMPUTERNAME%-w.log
::	net start | find "World Wide Web Publishing"	>> %COMPUTERNAME%-w.log
::)
::echo.	>> %COMPUTERNAME%-w.log
::echo □ 기준 : IIS 서비스가 필요하지 않지만 동작 중인 경우	>> %COMPUTERNAME%-w.log
::echo.	>> %COMPUTERNAME%-w.log
::echo [%CODE%]
::net start | find "World Wide Web Publishing" > nul
::IF ERRORLEVEL 1 echo [@ 양호	>> %COMPUTERNAME%-w.log
::IF NOT ERRORLEVEL 1 echo [%CODE%] : 수동	>> %COMPUTERNAME%-w.log
::echo.	>> %COMPUTERNAME%-w.log

::set windir=C:\Windows

echo.	>> %COMPUTERNAME%-w.log
echo ***************************************************************************************	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-01
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS 디렉토리 리스팅 제거	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : “디렉토리 검색”이 체크되어 있지 않은 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
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


echo □ 기준 : “디렉토리 검색”이 체크되어 있지 않은 경우	>> %COMPUTERNAME%-w.log
echo.									    	>> %COMPUTERNAME%-w.log

echo [등록 사이트]                                                                           >> %COMPUTERNAME%-w.log
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

echo [기본 설정]                                                                          >> %COMPUTERNAME%-w.log
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
echo *** 사이트별 설정 확인                                                                  >> %COMPUTERNAME%-w.log
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
			echo * 기본 설정이 적용되어 있음.                                                >> %COMPUTERNAME%-w.log
			echo.                                                                            >> %COMPUTERNAME%-w.log
		)
	)
)
echo [%CODE%]

type iis-result.txt | find /i "true" > nul
if %errorlevel% equ 0 (
echo.                                                                            >> %COMPUTERNAME%-w.log
echo @ 양호												>> %COMPUTERNAME%-w.log
) else (
echo.                                                                            >> %COMPUTERNAME%-w.log
echo @ 취약												>> %COMPUTERNAME%-w.log
)

echo.	>> %COMPUTERNAME%-w.log

::사이트 리스트 뽑기
%windir%\system32\inetsrv\appcmd.exe list site	> site_list.txt
%windir%\system32\inetsrv\appcmd.exe list site |find "http"	> http_list.txt
%windir%\system32\inetsrv\appcmd.exe list site |find "ftp"	> ftp_list.txt

:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-02
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS CGI 실행 제한	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : CGI 실행 기능을 제한하고 있는 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)

echo □ 기준 : 해당 디렉토리 Everyone에 모든 권한, 수정 권한, 쓰기 권한이 부여되지 않은 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

echo. > temp.txt 

IF EXIST C:\inetpub\scripts (
	cacls C:\inetpub\scripts >> temp.txt
) ELSE (
	echo C:\inetpub\scripts 디렉토리가 존재하지 않음 >> temp.txt
)

IF EXIST C:\inetpub\cgi-bin (
	cacls C:\inetpub\cgi-bin >> temp.txt
) ELSE (
	echo C:\inetpub\cgi-bin 디렉토리가 존재하지 않음 >> temp.txt
)

type temp.txt | findstr /i "everyone" > nul
IF NOT ERRORLEVEL 1 (
	echo ☞ 결과 : 해당 디렉토리 Everyone에 모든 권한, 수정 권한, 쓰기 권한이 부여되어 있음	>> %COMPUTERNAME%-w.log
	type temp.txt	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	::echo □ 기준 : 해당 디렉토리 Everyone에 모든 권한, 수정 권한, 쓰기 권한이 부여되지 않은 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo [%CODE%] : 수동	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
)
IF ERRORLEVEL 1 (
	echo ☞ 결과 : 해당 디렉토리 Everyone에 모든 권한, 수정 권한, 쓰기 권한이 부여되지 않음	>> %COMPUTERNAME%-w.log
	type temp.txt	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	::echo □ 기준 : 해당 디렉토리 Everyone에 모든 권한, 수정 권한, 쓰기 권한이 부여되지 않은 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
)


del temp.txt


:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-03
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS 상위 디렉토리 접근 금지	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : 상위 패스 기능을 제거한 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)


echo □ 기준 : 상위 패스 기능을 제거한 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

echo [등록 사이트]                                                                           >> %COMPUTERNAME%-w.log
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

echo [기본 설정]                                                                             >> %COMPUTERNAME%-w.log
echo -----------------------------------------------------                                   >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list config /section:asp | find /i "enableParentPaths" > nul
	IF NOT ERRORLEVEL 1 (
		%systemroot%\System32\inetsrv\appcmd list config /section:asp | find /i "enableParentPaths" >> %COMPUTERNAME%-w.log
		%systemroot%\System32\inetsrv\appcmd list config /section:asp | find /i "enableParentPaths" > iis-result.txt
	) ELSE (
		echo * 설정값 없음 * 기본설정 : enableParentPaths=false                              >> %COMPUTERNAME%-w.log
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs get W3SVC/AspEnableParentPaths  | find /i /v "Microsoft"    >> %COMPUTERNAME%-w.log
	cscript %script%\adsutil.vbs get W3SVC/AspEnableParentPaths  | find /i /v "Microsoft"    > iis-result.txt
)
echo.                                                                                        >> %COMPUTERNAME%-w.log

echo.                                                                                        >> %COMPUTERNAME%-w.log
echo *** 사이트별 설정 확인                                                                  >> %COMPUTERNAME%-w.log
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
			echo * 설정값 없음 * 기본설정 : enableParentPaths=false                          >> %COMPUTERNAME%-w.log
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
			echo AspEnableParentPaths : * 기본 설정이 적용되어 있음.                         >> %COMPUTERNAME%-w.log
			echo.                                                                            >> %COMPUTERNAME%-w.log
		)
	)
)

echo [%CODE%]

type iis-result.txt | find /i "true" > nul
if %errorlevel% equ 0 (
echo.                                                                            >> %COMPUTERNAME%-w.log
echo @ 양호											   	>> %COMPUTERNAME%-w.log
) else (
echo.                                                                            >> %COMPUTERNAME%-w.log
echo @ 취약												>> %COMPUTERNAME%-w.log
)





:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-04
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS 웹프로세스 권한 제한	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : 웹 프로세스가 웹 서비스 운영에 필요한 최소한 권한으로 설정되어 있는 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)
echo □ 기준 : 웹 프로세스가 웹 서비스 운영에 필요한 최소한 권한으로 설정되어 있는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

echo [IISADMIN] > temp.txt
%script%\reg query HKLM\SYSTEM\ControlSet001\services\IISADMIN\ObjectName >> temp.txt
echo. >> temp.txt
echo [World Wide Web Publishing] >> temp.txt
%script%\reg query HKLM\SYSTEM\ControlSet001\services\W3SVC\ObjectName >> temp.txt
type temp.txt | findstr /i "LocalSystem" > nul
IF NOT ERRORLEVEL 1 echo ☞ 결과 : LocalSystem(기본계정)으로 작동하고 있음	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo ☞ 결과 : IIS용 계정을 이용하여 작동하고 있음	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
type temp.txt	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
::echo □ 기준 : 웹 프로세스가 웹 서비스 운영에 필요한 최소한 권한으로 설정되어 있는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
type temp.txt | findstr /i "LocalSystem" > nul
IF NOT ERRORLEVEL 1 echo @ 취약	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo @ 양호	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
del temp.txt
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-05
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS 링크 사용 금지	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : 심볼릭 링크, aliases, 바로가기 등의 사용을 허용하지 않는 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)

echo □ 기준 : 심볼릭 링크, aliases, 바로가기 등의 사용을 허용하지 않는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

echo. > link.txt
for /F "tokens=1" %%i in (hpath.txt) do DIR /s %%i	>> link.txt
type link.txt | findstr "SYMLINK" > link.txt
type link.txt | findstr "SYMLINK" > nul
IF ERRORLEVEL 1 echo ☞ 결과 : 심볼릭 링크, aliases, 바로가기 등의 파일이 존재하지 않음	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 (
	echo ☞ 결과 : 심볼릭 링크, aliases, 바로가기 등의 파일이 존재하고 있음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	type link.txt	>> %COMPUTERNAME%-w.log
)
type link.txt	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
::echo □ 기준 : 심볼릭 링크, aliases, 바로가기 등의 사용을 허용하지 않는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
type link.txt | findstr ".lnk" > nul
IF ERRORLEVEL 1 echo @ 양호	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 echo @ 취약	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
del link.txt
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-06
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS 파일 업로드 및 다운로드 제한	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : 웹 프로세스의 서버 자원 관리를 위해 업로드 및 다운로드 용량을 제한하는 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
)

echo □ 기준 : 웹 프로세스의 서버 자원 관리를 위해 업로드 및 다운로드 용량을 제한하는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

echo [등록 사이트]                                                                        >> %COMPUTERNAME%-w.log
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

echo [기본 설정]                                                                          >> %COMPUTERNAME%-w.log
echo -----------------------------------------------------                                  >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list config | findstr /i "maxAllowedContentLength maxRequestEntityAllowed bufferingLimit" >> %COMPUTERNAME%-w.log
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs enum W3SVC | findstr /i "AspMaxRequestEntityAllowed AspBufferingLimit" >> %COMPUTERNAME%-w.log
)
echo * 값이 없을 경우 기본 설정이 적용되어 있음.                                             >> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log

echo.                                                                                        >> %COMPUTERNAME%-w.log
echo *** 사이트별 설정 확인                                                                  >> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "delims=" %%a in (website-name.txt) do (
		echo [WebSite Name] %%a                                                              >> %COMPUTERNAME%-w.log
		echo -----------------------------------------------------                            >> %COMPUTERNAME%-w.log
		%systemroot%\System32\inetsrv\appcmd list config %%a | findstr /i "maxAllowedContentLength maxRequestEntityAllowed bufferingLimit" >> %COMPUTERNAME%-w.log
		echo * 값이 없을 경우 기본 설정이 적용되어 있음.                                     >> %COMPUTERNAME%-w.log
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
			echo AspMaxRequestEntityAllowed : * 기본 설정이 적용되어 있음.                  >> %COMPUTERNAME%-w.log
		)
		cscript %script%\adsutil.vbs enum %%i | find /i "AspBufferingLimit" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i | find /i "AspBufferingLimit"           >> %COMPUTERNAME%-w.log
			echo.                                                                            >> %COMPUTERNAME%-w.log
		) else (
			echo AspBufferingLimit          : * 기본 설정이 적용되어 있음.                  >> %COMPUTERNAME%-w.log
			echo.                                                                            >> %COMPUTERNAME%-w.log
		)
	)
)

echo [%CODE%]

echo.                                                                                   >> %COMPUTERNAME%-w.log
echo @ 양호												>> %COMPUTERNAME%-w.log

::del flag.txt
::del updown.txt
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-07
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS DB 연결 취약점 점검	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo □ 기준 : .asa 매핑이 존재하는 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
)

echo. > flag.txt
echo. > flag2.txt
echo. > id.txt
echo. > id2.txt

echo □ 기준 : .asa 매핑이 존재하는 경우	>> %COMPUTERNAME%-w.log
echo TIP : 아래의 2가지 항목중 한가지라도 설정이 되어잇을 경우 양호	>> %COMPUTERNAME%-w.log
echo 1. 요청필터링에 해당 확장자 false 설정 >> %COMPUTERNAME%-w.log
echo 2. 처리기 맵핑에 해당 확장자 등록되지 않음	>> %COMPUTERNAME%-w.log
echo 옵션이 설정되어 있지 않을 경우 사이트명만 출력됨	>> %COMPUTERNAME%-w.log
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
	echo ☞ 결과 : .asa 매핑이 존재하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [기본 설정] >> %COMPUTERNAME%-w.log
	echo --요청필터링--	>> %COMPUTERNAME%-w.log
	%windir%\system32\inetsrv\appcmd list config /section:requestFiltering | findstr -i ".asa"""  >> %COMPUTERNAME%-w.log
	%windir%\system32\inetsrv\appcmd list config /section:requestFiltering | findstr -i ".asax"""  >> %COMPUTERNAME%-w.log
	echo --처리기 맵핑--	>> %COMPUTERNAME%-w.log
	%windir%\system32\inetsrv\appcmd list config /section:handlers | findstr -i ".asa" >> %COMPUTERNAME%-w.log
	
	echo.	>> %COMPUTERNAME%-w.log
	echo [사이트별 설정]  >> %COMPUTERNAME%-w.log
	echo --요청필터링--	>> %COMPUTERNAME%-w.log
	::for /F "tokens=1 delims=) skip=1" %%i in (hname.txt) do (
	for /F "tokens=1 delims=) skip=1" %%i in (website-name.txt) do (
		echo 사이트명 : %%i  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:requestFiltering | findstr -i ".asa"""  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:requestFiltering | findstr -i ".asax"""  >> %COMPUTERNAME%-w.log
	)
	echo --처리기 맵핑--	>> %COMPUTERNAME%-w.log
	::for /F "tokens=1 delims=) skip=1" %%i in (hname.txt) do (
	for /F "tokens=1 delims=) skip=1" %%i in (website-name.txt) do (
		echo 사이트명 : %%i  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config /section:handlers | findstr -i ".asa"	>> %COMPUTERNAME%-w.log
	)
	
	echo.	>> %COMPUTERNAME%-w.log
	::echo □ 기준 : .asa 매핑이 존재하는 경우	>> %COMPUTERNAME%-w.log
	::echo TIP : 아래의 2가지 항목중 한가지라도 설정이 되어잇을 경우 양호	>> %COMPUTERNAME%-w.log
	::echo 1. 요청필터링에 해당 확장자 false 설정 >> %COMPUTERNAME%-w.log
	::echo 2. 처리기 맵핑에 해당 확장자 등록되지 않음	>> %COMPUTERNAME%-w.log
	::echo 옵션이 설정되어 있지 않을 경우 사이트명만 출력됨	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
)
type flag.txt | findstr /i "false" > NUL
IF NOT ERRORLEVEL 1 (
	echo ☞ 결과 : .asa 매핑이 존재하고 있음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo 취약 리스트	>> %COMPUTERNAME%-w.log
	type id.txt | findstr "root" > nul
	IF ERRORLEVEL 1 type id2.txt | findstr "root" > nul
	IF NOT ERRORLEVEL 1 (
		echo [기본 설정] >> %COMPUTERNAME%-w.log
		type id.txt | findstr "root" > nul
		IF NOT ERRORLEVEL 1 (
			echo --요청필터링--	>> %COMPUTERNAME%-w.log
			%windir%\system32\inetsrv\appcmd list config /section:requestFiltering | findstr -i ".asa"""	>> %COMPUTERNAME%-w.log
			%windir%\system32\inetsrv\appcmd list config /section:requestFiltering | findstr -i ".asax"""	>> %COMPUTERNAME%-w.log
		)
		type id2.txt | findstr "root" > nul
		IF NOT ERRORLEVEL 1 (
			echo --처리기 맵핑--	>> %COMPUTERNAME%-w.log
			%windir%\system32\inetsrv\appcmd list config /section:handlers | findstr -i ".asa"	>> %COMPUTERNAME%-w.log
		)
	)
	echo.	>> %COMPUTERNAME%-w.log
	echo [사이트별 설정] >> %COMPUTERNAME%-w.log
	echo --요청필터링 누락된 사이트--	>> %COMPUTERNAME%-w.log
	for /F "tokens=1 skip=1" %%i in (id.txt) do (
		echo 사이트명 : %%i  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:requestFiltering | findstr -i ".asa"""  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:requestFiltering | findstr -i ".asax"""  >> %COMPUTERNAME%-w.log
	)
	echo --처리기 맵핑 등록된 사이트--	>> %COMPUTERNAME%-w.log
	for /F "tokens=1 skip=1" %%i in (id2.txt) do (
		echo 사이트명 : %%i  >> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:handlers | findstr -i ".asa"	>> %COMPUTERNAME%-w.log
	)
	echo.	>> %COMPUTERNAME%-w.log
	::echo □ 기준 : .asa 매핑이 존재하는 경우	>> %COMPUTERNAME%-w.log
	::echo TIP : 아래의 2가지 항목중 한가지라도 설정이 되어잇을 경우 양호	>> %COMPUTERNAME%-w.log
	::echo 1. 요청필터링에 해당 확장자 false 설정 >> %COMPUTERNAME%-w.log
	::echo 2. 처리기 맵핑에 해당 확장자 등록되지 않음	>> %COMPUTERNAME%-w.log
	::echo 옵션이 설정되어 있지 않을 경우 사이트명만 출력됨	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 취약	>> %COMPUTERNAME%-w.log
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
echo [%CODE%] IIS 데이터파일 ACL 적용	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : 홈 디렉토리 내에 있는 하위 파일들에 대해 Everyone 권한이 존재하지 않는 경우 >> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
)

echo □ 기준 : 홈 디렉토리 내에 있는 하위 파일들에 대해 Everyone 권한이 존재하지 않는 경우 >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

::루트폴더 및 하위폴더에 해당확장자 파일 모두 추출
echo. > abc.txt
for /F "tokens=1 skip=1" %%a in (hpath.txt) do (
	echo %%a >> abc.txt
	dir %%a /s/b | findstr ".exe .dll .cmd .pl .asp" >> abc.txt
)
::추출한 확장자파일의 권환 확인
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
	echo ☞ 결과 : 홈 디렉토리 내에 있는 하위 파일들에 대해 Everyone 권한이 존재하고 있음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo everyone 접근 권한이 있는 경로	>> %COMPUTERNAME%-w.log
	type acl.txt >> %COMPUTERNAME%-w.log
	echo acl.txt >> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	::echo □ 기준 : 홈 디렉토리 내에 있는 하위 파일들에 대해 Everyone 권한이 존재하지 않는 경우 >> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 취약	>> %COMPUTERNAME%-w.log	
	echo.	>> %COMPUTERNAME%-w.log
)
if errorlevel 1 (
	ECHO ☞ 결과 : 홈 디렉토리 내에 있는 하위 파일들에 대해 Everyone 권한이 존재하지 않음	>> %COMPUTERNAME%-w.log	
	echo.	>> %COMPUTERNAME%-w.log
	for /F "tokens=1 skip=1" %%a in (hpath.txt) do (
		echo %%a >> %COMPUTERNAME%-w.log 
		cacls %%a >> %COMPUTERNAME%-w.log
	)
	echo.	>> %COMPUTERNAME%-w.log
	::echo □ 기준 : 홈 디렉토리 내에 있는 하위 파일들에 대해 Everyone 권한이 존재하지 않는 경우 >> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	ECHO [%CODE%]
	ECHO @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
)

del abc.txt
del acl.txt
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-09
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS 미사용 스크립트 매핑 제거	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : 취약한 매핑.htr, .idc, .stm, .shtm, .shtml, .printer, .htw, .ida, .idq가 존재하는 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
)

echo □ 기준 : 취약한 매핑(.htr, .idc, .stm, .shtm, .shtml, .printer, .htw, .ida, .idq)가 존재하는 경우	>> %COMPUTERNAME%-w.log
echo TIP : 디폴트 옵션일경우 값이 나오지 않고, 취약함	>> %COMPUTERNAME%-w.log
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
	echo ☞ 결과 : 취약한 매핑이 존재하지 않음	>> %COMPUTERNAME%-w.log	
	echo.	>> %COMPUTERNAME%-w.log
	echo [기본 설정] 	>> %COMPUTERNAME%-w.log
	%windir%\system32\inetsrv\appcmd list config /section:handlers	>> %COMPUTERNAME%-w.log
	echo [사이트별 설정] 	>> %COMPUTERNAME%-w.log
	::for /F "tokens=1 delims=) skip=1" %%i in (hname.txt) DO (
	for /F "tokens=1 delims=) skip=1" %%i in (website-name.txt) DO (
		echo 사이트명 : %%i	>> %COMPUTERNAME%-w.log
		%windir%\system32\inetsrv\appcmd list config %%i /section:handlers	>> %COMPUTERNAME%-w.log
	)
) ELSE (
	echo ☞ 결과 : 취약한 매핑이 존재하고 있음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo 취약 리스트	>> %COMPUTERNAME%-w.log
	cscript %script%\adsutil.vbs enum W3SVC | findstr "\.htr \.idc \.stm \.shtm \.shtml \.printer \.htw \.ida \.idq" > nul
	IF NOT ERRORLEVEL 1 (
		echo [기본 설정] >> %COMPUTERNAME%-w.log
		cscript %script%\adsutil.vbs enum W3SVC | findstr "\.htr \.idc \.stm \.shtm \.shtml \.printer \.htw \.ida \.idq" >> %COMPUTERNAME%-w.log
	)
	type id.txt | findstr "0 1 2 3 4 5 6 7 8 9 0 a b c d e f g h i j k l m n o" > nul
	IF NOT ERRORLEVEL 1 (
		echo [사이트별 설정] >> %COMPUTERNAME%-w.log
		for /F "tokens=1  skip=1" %%i in (id.txt) DO (
			echo 사이트명 : %%i	>> %COMPUTERNAME%-w.log
			%windir%\system32\inetsrv\appcmd list config %%i /section:handlers | findstr /i "\.htr \.idc \.stm \.shtm \.shtml \.printer \.htw \.ida \.idq"	>> %COMPUTERNAME%-w.log
		)
	)
)
echo.	>> %COMPUTERNAME%-w.log
::echo □ 기준 : 취약한 매핑(.htr, .idc, .stm, .shtm, .shtml, .printer, .htw, .ida, .idq)가 존재하는 경우	>> %COMPUTERNAME%-w.log
::echo TIP : 디폴트 옵션일경우 값이 나오지 않고, 취약함	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
type flag.txt | findstr /i "false" > NUL
IF  ERRORLEVEL 1 echo @ 양호	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 echo @ 취약	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log



del script.txt
del flag.txt
del id.txt
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-10
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] FTP 서비스 구동 점검	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
echo □ 기준 : FTP 서비스를 사용하지 않는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
net start | find "Microsoft FTP Service" > nul      
IF ERRORLEVEL 1 net start | find "FTP Publishing Service" > nul
IF ERRORLEVEL 1 echo ☞ 결과 : FTP 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 (
	echo ☞ 결과 : FTP 서비스를 사용하고 있음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	net start | find "Microsoft FTP Service"	>> %COMPUTERNAME%-w.log
	net start | find "FTP Publishing Service"	>> %COMPUTERNAME%-w.log
)
echo.	>> %COMPUTERNAME%-w.log
::echo □ 기준 : FTP 서비스를 사용하지 않는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
net start | find "Microsoft FTP Service" > nul      
IF ERRORLEVEL 1 net start | find "FTP Publishing Service" > nul   
IF ERRORLEVEL 1 echo @ 양호	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 echo @ 취약	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-11
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] FTP 디렉토리 접근 권한 설정	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "Microsoft FTP Service" > nul
IF ERRORLEVEL 1 net start | find "FTP Publishing Service" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : FTP 홈 디렉토리에 Everyone 권한이 없는 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : FTP 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noFTP	
)
echo □ 기준 : FTP 홈 디렉토리에 Everyone 권한이 없는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo. > ftpdir.txt
for /F "tokens=1 skip=1" %%i in (fpath.txt) do cacls %%i	>> ftpdir.txt
type ftpdir.txt | find /I "Everyone" > nul
if NOT errorlevel 1 (
	echo ☞ 결과 : 홈 디렉토리에 Everyone 권한이 존재하고 있음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo everyone 접근 권한이 있는 경로	>> %COMPUTERNAME%-w.log
	for /F "tokens=1 skip=1" %%i in (fpath.txt) do (
		cacls %%i 	> test.txt
		type test.txt | find "Everyone"
		echo %%i	>> %COMPUTERNAME%-w.log
	)
	del test.txt
	echo.	>> %COMPUTERNAME%-w.log
	::echo □ 기준 : FTP 홈 디렉토리에 Everyone 권한이 없는 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 취약	>> %COMPUTERNAME%-w.log	
	echo.	>> %COMPUTERNAME%-w.log	
	GOTO  W-38-END
)	


ECHO ☞ 결과 : 홈 디렉토리에 Everyone 권한이 존재하지 않음	>> %COMPUTERNAME%-w.log	
echo.	>> %COMPUTERNAME%-w.log
type ftpdir.txt	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
::echo □ 기준 : FTP 홈 디렉토리에 Everyone 권한이 없는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
ECHO [%CODE%]
ECHO @ 양호	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

:W-38-END
del ftpdir.txt
:noFTP

:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-12
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] Anonymous FTP 금지	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "Microsoft FTP Service" > nul
IF ERRORLEVEL 1 net start | find "FTP Publishing Service" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : FTP 서비스를 사용하지 않거나, “익명 연결 허용”이 체크되지 않은 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : FTP 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noFTP	
)
echo □ 기준 : FTP 서비스를 사용하지 않거나, “익명 연결 허용”이 체크되지 않은 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
%windir%\system32\inetsrv\appcmd list config | findstr "anony" | findstr -v "userName" | find "false" > nul
IF ERRORLEVEL 1 echo ☞ 결과 : 익명 계정의 연결을 허용 하고 있음	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 echo ☞ 결과 : 익명 계정의 연결을 허용 하지 않음	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
%windir%\system32\inetsrv\appcmd list config | findstr "anony" | findstr -v "userName"	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
::echo □ 기준 : FTP 서비스를 사용하지 않거나, “익명 연결 허용”이 체크되지 않은 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
%windir%\system32\inetsrv\appcmd list config | findstr "anony" | findstr -v "userName" | find "false" > nul
IF ERRORLEVEL 1 echo @ 취약	>> %COMPUTERNAME%-w.log
IF NOT ERRORLEVEL 1 echo @ 양호	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

:noFTP
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-13
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] FTP 접근 제어 설정	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "Microsoft FTP Service" > nul
IF ERRORLEVEL 1 net start | find "FTP Publishing Service" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : 특정 IP 주소에서만 FTP 서버에 접속하도록 접근제어 설정을 적용한 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : FTP 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noFTP	
)
echo □ 기준 : 특정 IP 주소에서만 FTP 서버에 접속하도록 접근제어 설정을 적용한 경우	>> %COMPUTERNAME%-w.log
echo TIP : allowUnlisted="false" 일경우 허용 IP 이외의 모든 IP 차단 "true"일경우 모두 허용	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo. > ftpsecurity.txt
for /F "tokens=1 skip=1" %%i in (fname.txt) do %windir%\system32\inetsrv\appcmd list config %%i /section:ipSecurity	| find /i "allowunlisted" >> ftpsecurity.txt
type ftpsecurity.txt | find "false" > nul
IF NOT ERRORLEVEL 1 echo ☞ 결과 : 특정 IP 주소에서만 FTP 서버에 접근하도록 접근제어 설정을 적용하고 있음	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo ☞ 결과 : 특정 IP 주소에서만 FTP 서버에 접근하도록 접근제어 설정을 적용하지 않음	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
type ftpsecurity.txt | find "false" > nul
IF ERRORLEVEL 1 echo 접근 제어를 하지 않은 FTP 서버	>> %COMPUTERNAME%-w.log
for /F "tokens=1 skip=1" %%i in (fname.txt) do (
	%windir%\system32\inetsrv\appcmd list config %%i /section:ipSecurity > test.txt
	type test.txt | find "false" > nul
	IF ERRORLEVEL 1 echo %%i	>> %COMPUTERNAME%-w.log
	type test.txt | find /i "allowUnlisted"	>> %COMPUTERNAME%-w.log
	del test.txt
	echo.	>> %COMPUTERNAME%-w.log
)

::echo □ 기준 : 특정 IP 주소에서만 FTP 서버에 접속하도록 접근제어 설정을 적용한 경우	>> %COMPUTERNAME%-w.log
::echo TIP : allowUnlisted="false" 일경우 허용 IP 이외의 모든 IP 차단 "true"일경우 모두 허용	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
type ftpsecurity.txt | find "false" > nul
IF NOT ERRORLEVEL 1 echo @ 양호	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo @ 취약	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

del ftpsecurity.txt

:noFTP
:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-14
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS 웹 서비스 정보 숨김	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : 웹 서비스 에러 페이지가 별도로 지정되어 있는 경우	>> %COMPUTERNAME%-w.log
	echo TIP : %SystemDrive%\inetpub\custerr 디폴트 경로이외의 폴더가 나올경우 양호 그외에는 인터뷰 진행	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)

::echo. [IIS 배너 확인]                                                                      >> %COMPUTERNAME%-w.log
::IF NOT ERRORLEVEL 1 (
::	echo ---------------------------------HTTP Banner-------------------------------------       >> %COMPUTERNAME%-w.log
::	cscript %script%\http_banner.vbs > http_banner.txt
::	type http_banner.txt								>> %COMPUTERNAME%-w.log 2>nul
::	echo ---------------------------------------------------------------------------------       >> %COMPUTERNAME%-w.log
::	del http_banner.txt 2>nul
::)	ELSE (
::	ECHO ☞ IIS Service Disable                                                                >> %COMPUTERNAME%-w.log
::)
echo □ 기준 : 웹 서비스 에러 페이지가 별도로 지정되어 있는 경우										>> %COMPUTERNAME%-w.log
echo.                                                                                        >> %COMPUTERNAME%-w.log
echo [등록 사이트]                                                                        	>> %COMPUTERNAME%-w.log
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
echo [기본 설정]                                                                            >> %COMPUTERNAME%-w.log
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
echo *** 사이트별 설정 확인                                                                  >> %COMPUTERNAME%-w.log
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
			echo 기본 설정이 적용되어 있음.                                                          >> %COMPUTERNAME%-w.log
			echo.                                                                                    >> %COMPUTERNAME%-w.log
		)
	)
)
echo.                                                                                    >> %COMPUTERNAME%-w.log
type iis-result.txt | find /i "inetpub\custerr" > nul
IF NOT ERRORLEVEL 1 echo @ 취약	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo @ 양호	>> %COMPUTERNAME%-w.log

:noIIS


echo WEND                                                                                       >> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
set CODE=W-21
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo [%CODE%] IIS WebDAV 비활성화	>> %COMPUTERNAME%-w.log
echo #######################################################################################	>> %COMPUTERNAME%-w.log
echo WSTART                                                                                     >> %COMPUTERNAME%-w.log
net start | find "World Wide Web Publishing" > nul
IF ERRORLEVEL 1 (
	echo □ 기준 : WebDAV가 금지 되어 있는 경우	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo ☞ 결과 : IIS 서비스를 사용하지 않음	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	echo [%CODE%]
	echo @ 양호	>> %COMPUTERNAME%-w.log
	echo.	>> %COMPUTERNAME%-w.log
	GOTO noIIS
	
)
echo □ 기준 : WebDAV가 금지 되어 있는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
type %systemroot%\system32\inetsrv\config\applicationHost.config | findstr "add path" | findstr -i "WebDAV" | findstr "allowed" > dav.txt
type dav.txt | find "true" > nul
IF NOT ERRORLEVEL 1 echo ☞ 결과 : WebDAV가 금지되지 않음	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo ☞ 결과 : WebDAV가 금지되어 있음	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
type dav.txt	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
::echo □ 기준 : WebDAV가 금지 되어 있는 경우	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log
echo [%CODE%]
type dav.txt | find "true" > nul
IF NOT ERRORLEVEL 1 echo @ 취약	>> %COMPUTERNAME%-w.log
IF ERRORLEVEL 1 echo @ 양호	>> %COMPUTERNAME%-w.log
echo.	>> %COMPUTERNAME%-w.log

del dav.txt

:noIIS
type %COMPUTERNAME%-w.log                                                                >> %COMPUTERNAME%-test.log
goto end



:END
echo END_RESULT							    											>> %COMPUTERNAME%-test.log
echo.							    											>> %COMPUTERNAME%-test.log
echo ☞ End Time                                                                           >> %COMPUTERNAME%-test.log
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
echo ########################################################### 보안 준수율 : %score% 점 ##
echo ###################################################################################
echo.

echo ###################################################################################
echo ##                           보안 진단이 완료되었습니다 !!                       ##
echo ###################################################################################
echo.
echo. 	>> %COMPUTERNAME%-test.log
echo ################################################################################### 	>> %COMPUTERNAME%-test.log
echo ############################################################ 보안 준수율 : %score% 점 ## 	>> %COMPUTERNAME%-test.log
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

::echo %date% | findstr /I "월 화 수 목 금 토 일 Mon Tue Wed Thu Fri Sat Sun" > nul
::IF NOT ERRORLEVEL 1 SET /a date1=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
::IF NOT ERRORLEVEL 1 SET date1=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
::IF ERRORLEVEL 1 set date1=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%


::한글 (ex) 2020-03-31
date /t | findstr /I "[-]" | findstr /I "^[0-9]" > nul
IF NOT ERRORLEVEL 1 goto KRDATE

::영문 (ex) Tue 03/31/2020
date /t | findstr /I "[/]" | findstr /I "^[A-Z]" > nul
IF NOT ERRORLEVEL 1 goto EN1DATE

::영문 (ex) 03/31/2020 Tue 
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
echo       ##        스크립트 수행 경로 확인 후 재진단 요청드립니다          ##
echo       ##        스크립트 실행경로C:\joycity                        ##
echo       ##                                                                ##
echo       ####################################################################
echo.
pause
EXIT

:END
pause
EXIT
