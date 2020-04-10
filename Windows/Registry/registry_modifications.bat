# Disable RDP 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\TerminalServer" /f /v fDenyTSConnections /t REG_DWORD /d 1

# Pass the hash attack registry key
reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /f /v NoLMHash /t REG_DWORD /d 1

# Remove Sticky keys registry key
reg add "HKCU\ControlPanel\Accessibility\ToggleKeys" /v Flags /t REG_SZ /d 506 /f

# Disable runonce registry key 
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v DisableLocalMachineRunOnce /t REG_DWORD /d 1

# Disable RDP registry key 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\TerminalServer" /f /v fDenyTSConnections /t REG_DWORD /d 1

# Disable anonymous access
reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v restrictanonymoussam /t REG_DWORD /d 1 /f

# Enable UAC
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f

## Enable Windows update - weekly basis using scheduled task 
# SCHTASKS /Create /SC WEEKLY /TN WeeklyUpdateCheck /TR wuapp.exe
