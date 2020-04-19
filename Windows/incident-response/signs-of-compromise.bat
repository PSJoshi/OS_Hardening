::## This script can be used by security administrators to check if the windows PC is compromised or not - ie. whether it contains malware or not.

@echo off 
set results_file="assessment.txt" 

(
echo "###################################################"
echo "Getting current date and time information."
echo "Date:"
date /T 
echo "Time:"
time /T 
echo. 
echo.
echo "###################################################"

echo "###################################################"
echo "Getting system information"
echo. 
systeminfo
echo. 
echo.
echo "###################################################"

echo "#################################################"
echo " Getting currently logged in users"
echo. 
echo %username% 
echo.
echo. 
echo "#################################################"

echo "#################################################"
echo "Getting current user along with domain"
echo. 
whoami
echo. 
echo. 
REM if you have microsoft sysinternals tools, make use of psloggedon.exe 
REM psloggedon.exe -l
REM If you have Windows 10 Professional or later edition, you can also use query command. "query" command is not available as a part of Windows Home edition.
REM query user 
echo "##################################################"


echo "###################################################"
echo "Getting environment variables information."
echo. 
set 
echo. 
echo. 
echo "###################################################"

echo "###################################################"
echo "Getting path information."
echo. 
echo %PATH% 
echo. 
echo. 
echo "###################################################"


echo "###################################################"
echo "Getting information about User Account Controls(UAC) - Enabled or Disabled"
echo " UAC limits what changes a program can make in Windows without permission from an administrator profile"
echo "If the results of query are  'ENABLELUA   REG_DWORD    0x1' then part or all of the UAC components are on"
echo. 
echo. 
REG QUERY HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ /v EnableLUA

REM Another way:
REM reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" | find  "0x0" >NUL
REM if "%ERRORLEVEL%"=="0"  ECHO UAC disabled
REM if "%ERRORLEVEL%"=="1"  ECHO UAC enabled
echo. 
echo. 
echo "###################################################"


REM Credits:
REM * https://github.com/carlospolop/winPE/blob/master/winPE.bat
REM * Windows priviledge escalation checks - https://github.com/codingo/OSCP-2/blob/master/Windows/WinPrivCheck.bat

) > %results_file%


echo "##################################################"
echo "Getting information about installed security patches, hotfixes etc."
echo. 
wmic /append:"assessment.txt" qfe get Caption,Description,HotFixID,InstalledOn /Format:CSV
echo. 
echo. 
echo "###################################################"

echo "##################################################"
echo "Getting mounted disk drives information."
echo. 
wmic /append:"assessment.txt" logicaldisk get caption 2> nul
echo. 
echo. 
echo "##################################################"

echo "##################################################"
echo "Getting information about registered Anti-virus program on the PC"
echo. 
wmic /append:"assessment.txt" /Node:localhost /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName /Format:CSV
echo. 
echo. 
echo "##################################################"

echo "##################################################"
echo "Getting information about installed softwares."
echo. 
wmic /append:"assessment.txt" product get name,version,installdate,vendor /Format:CSV
echo. 
echo. 
echo "######################################################"

::more-settings-to-be-added...
