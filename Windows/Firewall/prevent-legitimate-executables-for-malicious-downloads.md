### Block usage of legitimate windows applications being used for malicious purposes

In many cyberattacks in the last few years, there is a growing trend  from malware authors to use built-in windows programs like "PowerShell.exe" to download malicious code from Internet. Often, it is seen that the user inadvertantly clicks on “Enable Macros” button when a malicious MS-Office attachment is received in a spear phishing email and triggers usage of powershell in the background.

Of course, an alert will be generated if you have deployed any free (Mircosoft Sysinternal SysMon) or commercial Endpoint Monitoring solution(s) like EndGame, Carbon Black etc. These endpoint monitoring solutions are monitoring the system for the signs such as MS office executable files (Word,Excel) spawning a "powershell.exe" as child process or MS office executable is being used in conjunction with "certutil.exe" or "regsvr32.exe" for download of malicious code. So, in principle, the malicious event(s) is detected but it is also TRUE that many a times, users often ignore it as nothing visible happens on the screen. 

So, as a security administrator, the moot question here is: 
```Is it possible to block such bad things from happening in the first place? ```

It turns out that Windows  Firewall can be of great help to thwart such attacks. In most organizations it is seen that the firewall is not configured properly or is mostly ignored by IT administartors to reduce the operational/incident tickets in Windows PCs.
Further, in many organizations, you will encounter a "Proxy server" that inspect and log all incoming/outgoing HTTP/HTTPS connections. Proxy solution can be an open source like Squid proxy or a commercial Proxy like BlueCoat with many features. Using these proxy appliances, it is possible to create appropriate rules and block legitimate executables from connecting to C&C servers.It is to remembered that one can use these legitimate windows programs (powershell.exe) for use on the internal network if one has experience and expertize. 

It is much easier and more effective to block outgoing connections of any windows legitimate programs like "PowerShell.exe" than trying to develop detections mechanisms for its malicious usage e.g obfuscated PowerShell scripts connecting Internet or restrict usage of "PowerShell" by blocking access to "PowerShell" DLLs and so on. In Security, priority should be ALWAYS given to prevention over detection in the first place especially when prevention can be easily accomplished using built-in Windows components.
 Of course, if you are operating in very strict environment, you can "ALWAYS" block all outgoing connections in Windows firewall itself. So, the choice to allow or disallow connections will be dictated by organization policies.
 
 The next question that comes to the mind is how to distribute these rules on each and every host. One way is to create a GPO for distribution of windows firewall rules on each host using Active Directory. The other option is to prepare a hardened Windows Host and using export/import local GPO to apply on each Windows host.
 
 From statistical malware analysis studies, it has been found that the following programs are used to fetch malicious payload from the Internet:
* powershell.exe 
* regsvr32.exe
* mshta.exe
* bitsadmin.exe 
* certutil.exe
* msbuild.exe
* makecab.exe
* ieexec.exe
* expand.exe
* extrac.exe
* wscript.exe 
* cscript.exe 

This list will be modified as soon as any new program(s) is known. (To do - I should add entries from LoLBin project!)

### Credits:
* Prevent legitimate Windows executable to gain initial foothold - https://medium.com/@dimitrismargaritis/prevent-legitimate-windows-executables-to-be-used-to-gain-initial-foothold-in-your-infrastructure-39771cd6ec90
