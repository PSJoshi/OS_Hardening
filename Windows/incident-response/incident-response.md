### Why Incidence Response 
In many organizations, a standard procedure to deal with any cyber incident typically involves two steps:
* take the PC off the network
* format its OS drive -i.e. reinstall the system
It is presumed that the problem will disappear on its own!

Unfortunately, the evidence regarding the root cause and any side-effect(s) of incident is automatically destoryed but no body really bothers! But, in holistic sense, the organization has not become wiser and is still exposed to the same or similar attacks in the future.

Further, any incident response process requires you to understand attacker’s actions on compromised machines and this often requires examining hundreds or even thousands of artifacts to find the "needle" in the haystack.These artifacts typically include running processes, running services, current login information, open files, open shares, open handles, and so on. By having many artifacts, it is posssible to extract finer details of the attack and this allows us to rebuild the attack scenerio in a comprehensive way.
Secondly, in todays world, organizations are having their offices spread through various geo-graphical regions and these are often run with minimal IT staff. Since it is not possible to have Incident response (IR) team/ Security Experts available everywhere, organizations are always looking for ways to do operations remotely or if there is a way to collect these artifacts in an automated way.

"Live response" is the term commonly used by Incidence responders/ Security Analyst for collection of such artifacts from a running compromised machine.The basic goal here is to identify and analyze the initial "trigger" as quickly as possible. Further, IR experts are interested in capture of volatile memory information as the system state may substantially change over a period of time.

However, "Live  response" has its own challenges as mentioned below:
* Ability to remotely access and run code on a compromised machine.
* To remain unnoticed by the attacker; information-gathering process must be stealthy.
* Operations must not "jeopardize cyber crime scene." - known as Locard's Exchange Principle

It is true that IT teams in many organization are too stressed, or there is not sufficient manpower or expertize or lack of data gathering tools at their disposal. So, simple method of "Running THE Show" is applied and the process repeats year after year!

Incidence response toolkit (IRT) is designed to collect all security related data from the host under investigation and to furnish this evidence to incident responder for quicker analysis. It consists of three modules:
* Data collector module
* Centralized Data processing and analysis module 
* Reporting module

Once the data is gathered, it can be sent to forensic specialist so that they can do analysis of the incident accurately and send recommendatations about threat mitigations.

Data collection scripts can be used to collect many aspects of Windows operating system like:
* MFT entries - Master file table (MFT) is a database in which information about each file and directory on NTFS file system (NTFS) volume is stored. 
* USN Journal (Update Sequence Number Journal) - It is a feature of the Windows NT file system (NTFS) which maintains a record of changes made to the volume.
* Browser history
* Memory dump
* Registry changes
* Log(*.evtx) files
 and so on

There are tools/script available from open source as well as commericial domains. Some of the popular tools are listed below:
* CDIR collector - https://github.com/CyberDefenseInstitute/CDIR/blob/master/README_en.md
* CyLR collector - https://github.com/orlikoski/CyLR
* Live response collection - https://www.brimorlabs.com/tools/
* FastIR collector - https://github.com/SekoiaLab/Fastir_Collector
* DFIR triage - https://github.com/travisfoley/dfirtriage
* Windows collection using Batch configuration - https://github.com/opsdisk/batchconfig
* Evidence collector windows - https://github.com/heikovoegeli/ETHZ_EC_Winx86

Examples of commercial tools for data collection are:
* CrowdStrike - https://www.crowdstrike.com/wp-content/community-tools/CrowdResponse.zip
* IR evidence collector - https://binalyze.com/products/irec


The following site contain links to many such programs - https://medium.com/@soji256/evidence-collecting-tools-for-fast-forensics-f4ee952f32bb

I decided to write my own to gain first hand experience of data collection, analysis and reporting at scale in Windows/Linux environment.

The features that I am targeting are :
* Should works on all version of windows 
* Do not require any special training
* No installation of additional software required
* On demand reports generation

To start with, I have written a windows batch file that collect most important artifacts of windows environment to a file "assessment.txt". 

### To do:
* Convert data collection file - "assessment.txt" to JSON or any other format to make it machine readable.
* Generate report that summarizes data collection information and indiate if the PC is infected

### Running of Unusual services
Checking un-usual and un-authorized services should be included in the plan of any incident responders(IR). In addition, IR should also check if any default services are compromised thorugh mechanisms like process injection, process hollowing. Many viruses and malwares try to install themselves as a service so that they are automatically started again after a reboot. 

If you are familiar with startup services and have established their baseline, it will greatly reduce the efforts on incident responder part during the course of investigations.  If running a particular service is not necessary, it should be clearly identified and removed permanently from startup list of services. If any malicious service(s) is found to be running, it should be stopped immediately and you have to make sure that it should not be running again.
The following command is usually used to keep track of services during startup:
```
net start
```
[[screenshot]]
There is also another command (Windows 7 onwards) that gives detailed information
```
sc query
```
[[screenshot]]
