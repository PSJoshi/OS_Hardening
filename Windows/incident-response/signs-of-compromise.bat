::## This script can be used by security administrators to check if the windows PC is compromised or not - ie. whether it contains malware or not.
@echo off 
set results_file="assessment.txt" 
(
echo "###################################################"
echo "Getting current date and time information."
echo.
echo "Date:" 
date /T 
echo "Time:" 
time /T 
echo.
echo "###################################################"

echo "###################################################"
echo "Getting system information"
echo. 
systeminfo
echo. 
echo "###################################################"

echo "#################################################"
echo " Getting currently logged in users"
echo. 
echo %username% 
echo.
echo "#################################################"

echo "#################################################"
echo "Getting information about current user and domain"
echo. 
whoami
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
echo "###################################################"

echo "###################################################"
echo "Getting path information."
echo. 
echo "%PATH%" 
echo. 
echo "###################################################"


echo "###################################################"
echo "Getting information about User Account Controls(UAC) - Enabled or Disabled"
echo " UAC limits what changes a program can make in Windows without permission from an administrator profile"
echo "If the results of query are  'ENABLELUA   REG_DWORD    0x1' then part or all of the UAC components are on"
echo. 
REG QUERY HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ /v EnableLUA

REM Another way:
REM reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" | find  "0x0" >NUL
REM if "%ERRORLEVEL%"=="0"  ECHO UAC disabled
REM if "%ERRORLEVEL%"=="1"  ECHO UAC enabled
echo. 
echo "###################################################"

echo "######################################################"
echo "Getting shared folder(s) information."
echo.
net share
echo.
echo "Getting local network share information"
net view \\127.0.0.1
echo.
echo "######################################################"

echo "######################################################"
echo "Getting password account policies information."
echo.
net accounts
echo.
echo "######################################################"

echo "######################################################"
echo "Getting windows services list"
echo.
sc query
echo.
echo "######################################################"


echo "######################################################"
echo "Getting information about windows services that are started during power up"
echo.
net start
echo.
echo "######################################################"

echo "######################################################"
echo "Getting information about process and its associated service" 
echo.
tasklist /svc 
echo.
echo "######################################################"

echo "######################################################"
echo " Getting information about all the running processes" 
echo.
tasklist /v 
echo.
echo "######################################################"

echo "######################################################"
echo "Enumerating user account information"
echo.
REM for /F "skip=1" %i in ('wmic useraccount get name') do net user %i >> %results_file%
REM for /F "skip=1" %i in ('wmic /append:%results_file% useraccount get name') do net user %i
for /F "skip=1" %%i in ('wmic useraccount get name') do net user %%i
echo.
echo "######################################################"

echo "######################################################"
echo "Enumerating group information"
echo.
REM for /F "delims=* tokens=1 skip=4" %i in ('net localgroup') do net localgroup %i >> %results_file%
REM Stackoverflow thread - https://stackoverflow.com/questions/35262862/issues-with-spaces-in-for-loop-variable-batch-script
REM for /F "delims=* tokens=1 skip=4" %i in ('net localgroup') do net localgroup %i
for /F "delims=* tokens=1 skip=4" %%i in ('net localgroup') do net localgroup %%i
echo.
echo "######################################################"

echo "######################################################"
echo "Calculating SHA256 hashes of running processes. These can be checked against services like Virustotal"
echo. 
for /F %%i in ('wmic process where "ExecutablePath is not null" get ExecutablePath') do (certutil -hashfile %%i SHA256)
echo.
echo "######################################################"

echo "######################################################"
echo "Getting information about the DLL loaded by each running process"
echo.
for /f "tokens=*" %%a in ('wmic process get processid') do @(cmd /c tasklist /m /fi "pid eq %%a")
echo.
echo "######################################################"


REM Credits:
REM * https://github.com/carlospolop/winPE/blob/master/winPE.bat
REM * Windows priviledge escalation checks - https://github.com/codingo/OSCP-2/blob/master/Windows/WinPrivCheck.bat

) > %results_file%

REM The following information is obtained using Windows Management Instrumentation Console(WMIC)

echo "##################################################"
echo "Getting information about installed security patches, hotfixes etc."
echo. 
wmic /append:%results_file% qfe get Caption,Description,HotFixID,InstalledOn /Format:CSV
echo. 
echo "###################################################"

echo "##################################################"
echo "Getting information about mounted disk drives"
echo. 
wmic /append:%results_file% logicaldisk get caption 2> nul
echo. 
echo "##################################################"

echo "##################################################"
echo "Getting information about registered Anti-virus program on the PC"
echo. 
wmic /append:%results_file% /Node:localhost /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName /Format:CSV
echo. 
echo "##################################################"

echo "##################################################"
echo "Getting information about installed softwares."
echo. 
wmic /append:%results_file% product get name,version,installdate,vendor /Format:CSV
echo. 
echo "######################################################"

echo "##################################################"
echo "Getting logical disks information"
echo.
wmic /append:%results_file% logicaldisk get name,freespace,systemname,size,volumename,filesystem
echo.
echo "######################################################"

echo "##################################################"
echo "Getting Hard Disk information"
echo.
wmic /append:%results_file% diskdrive get name,size,mediatype
echo.
echo "######################################################"

echo "##################################################"
echo "Getting computer Hardware Components information"
REM wmic computersystem list /format:list
echo.
wmic /append:%results_file% computersystem get domain,manufacturer,model,name,username,primaryownername,numberofprocessors,systemtype
echo.
echo "######################################################"

echo "##################################################"
echo "Getting installed product(s) information"
echo.
wmic /append:%results_file% product get description,installdate,name,vendor,version
echo.
echo "######################################################"

echo "######################################################"
echo "Getting user account(s) information"
echo.
wmic /append:%results_file% useraccount list full
echo.
echo "######################################################"

echo "######################################################"
echo "Getting windows services list using wmic"
echo.
wmic /append:%results_file% service get displayname,pathname,startname,state,startmode,servicetype
echo.
echo "######################################################"

echo "######################################################"
echo "Getting process list using wmic" 
echo.
REM wmic process list full 
wmic /append:%results_file% process get name,processid,parentprocessid,executablepath,installdate,virtualsize,executionstate 
echo.
echo "######################################################"

echo "######################################################"
echo "Getting full command line information of the running processes using wmic" 
echo.
wmic /append:%results_file% process where "commandline is not null and commandline!=''" get name,commandline
echo.
echo "######################################################"

echo "######################################################"
echo "Getting Remote desktop sessions information"
echo.
reg query "HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Default"
echo.
echo "######################################################"

echo "######################################################"
echo "Getting autorun entries"
REM wmic startup list full
echo.
wmic /append:%results_file% startup get caption,description, command,location
echo.
echo "######################################################"

echo "######################################################"
echo "Getting scheduled tasks information"
echo.
schtasks /query /fo list
echo.
echo "######################################################"

echo "######################################################"
echo "Getting installed drivers information"
echo.
driverquery /fo list
echo.
echo "######################################################"

echo "######################################################"
echo "Getting ARP entry information"
echo.
arp -a
echo.
echo "######################################################"

echo "######################################################"
echo "Getting firewall - current profile status"
echo.
netsh advfirewall show currentprofile
echo.
echo "######################################################"

echo "######################################################"
echo "Getting firewall - current configuration"
echo.
netsh firewall show config
echo.
echo "######################################################"

echo "######################################################"
echo "Searching file system for file names that contain certain keywords" 
echo.
dir /s *pass* == *cred* == *vnc* == *.config
echo.
echo "######################################################"

echo "######################################################"
echo "Searching registry for certain keywords. e.g password"
echo.
reg query HKLM /f password /t REG_SZ /s
reg query HKCU /f password /t REG_SZ /s
echo.
echo "######################################################"

echo "######################################################"
echo "Check if registry setting "AlwaysInstallElevated" is present or not."
REM "If this setting is enabled, it allows users of any priviledge level to install .msi packages as SYSTEM."
echo.
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
echo.
echo "######################################################"

echo "######################################################"
echo "Displaying information about process"
echo.
qprocess
echo.
echo "######################################################"

echo "######################################################"
echo "Getting existing audit policies"
echo.
auditpol /get /category:*
echo.
echo "######################################################"

::secedit /export /areas USER_RIGHTS /cfg C:\Users\<user>\Desktop\usr_rights.txt
::wmic useraccount
::wmic useraccount where name='<user>' get sid
::whoami /PRIV /FO LIST
