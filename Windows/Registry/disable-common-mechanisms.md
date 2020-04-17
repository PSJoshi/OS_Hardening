### Disable Autorun/AutoPlay
Disabling Autorun/Autoplay will prevent the system from automatically starting applications on removable/attachable media (if defined in an autorun.inf file). Microsoft has defined specific registry keys to control the behaviour of Autorun/Autoplay.

Its good to disable Autorun/Autoplay functionality on all drives by setting the following registry keys:
* HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoDriveTypeAutoRun - 0xff
* HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\policies\Explorer\NoDriveTypeAutoRun - 0xff

### Make USB device read only
It's better to convert any newly attached USB device(s) as read-only device(s) and thereby prevent accidental writes.
The following changes are required to be done in registry:
* HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies\WriteProtect - 1

(where 1 means that the OS will treat newly attached USB devices as read-only devices and 0 means writes are allowed)

### Disable automount
Windows will mount any newly attached storage devices and it can be a bad thing. To turn off Autorun feature, do the following:
* Run the command at command prompt - mountvol /N
* or set registry key - HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MountMgr\NoAutoMount to 1

### Disable search indexing (in forensic investigations)
It's always good to disable any automated indexing of any sort to prevent alteration of MACB times in any cyber-forensic investigation. To disable the service, do the following:
* Open the Services applet (services.msc).
* Locate and disable the Windows Search service (i.e. stop the service and set the startup type to be Disabled so that it won't run again).
