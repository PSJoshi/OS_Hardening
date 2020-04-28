### LNK files(shortcuts)
* commonly known as shortcut, file(s) with .lnk extension
* Relatively simple but valuable artifact
* Windows create 'lnk' file when a user opens a local or remote file and this allows forensic investigator to gain information about suspicious activity

##### Location
* \%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Recent
* \%USERPROFILE%\AppData\Roaming\Microsoft\Office\Recent

##### Tool for analysis
Lnk Explorer command line - https://github.com/EricZimmerman/LECmd

### Prefetch
* Windows caches code pages loaded at program startup
  * to speeds up start up time ( Trick to Optimize loading time for a program)
  * works even if EXE is on USB drive
* Files are named <EXE name> hash.pf
 e.g chrome.exe 2332D2Df.pf

##### Location
* c:\windows\prefetch

##### Tool for analysis
* Win_prefetch_view- Nirsoft utility - https://www.nirsoft.net/utils/win_prefetch_view.html

### Thumbcache(thumbs.db)
* this is a hidden file in a directory wherein images of files accessed using windows explorer are stored in thumbnail graphics form.
* thumb.db catalogs pictures in a folder and stores a copy of thumbnail even if pictures are deleted

##### Location
* %USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbs.db

##### Tool for analysis
* Thumbcache viewer - https://thumbcacheviewer.github.io/

### Shellbags
* set of windows registry keys located in NTUSER.dat and USRClass.dat registry hives
* allows historical tracing of 'opened' windows folders using windows explorer
##### Location
* HKCU\Software\Microsoft\Windows\Shellbags
* HKCU\Software\Microsoft\Windows\ShellBagMRU
* HKCU\Software\Microsoft\Windows\ShellNoRoamBags
* NTUSER.dat
  * HKCU\Software\Microsoft\Windows\ShellNoRoamBagMRU
* USERCLASS.dat
  * HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\ShellBagMRU
  * HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\ShellBags
##### Tools for analysis
* Shell bags viewer - https://www.nirsoft.net/utils/shell_bags_view.html

### Jumplist
* this feature is available from Windows 7 onwards
* provides the user with a GUI associated with each installed application
* it also lists the files that have been previously accessed by the application

##### Location
* %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations
* %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Recent\CustomDestinations 

##### Tools for analysis
* Jump_list_viewer, Nirsoft utility - https://www.nirsoft.net/utils/jump_lists_view.html

### Windows Registry
Contain all the information you can think of!
e.g 
* User accounts present on the system
* Last logged time for each user
* Most recently used softwares
* network connection to wired/wireless access points
* list of searches done on the system
and so on..

##### Tools for analysis
* RegRipper - https://github.com/keydet89/RegRipper2.8
* Registry Explorer - https://f001.backblazeb2.com/file/EricZimmermanTools/RegistryExplorer_RECmd.zip
