# Enhancing security of Windows Endpoint using Windows Firewall
Windows firewall has been integral component of Microsoft Windows Operating system since Windows XP (Now, it's called Windows Defender Firewall) and everyone should use it a part of defense in depth stratergy. Enabling and applying firewall rules is  one of the easiest way to limit remote accesses to many commonly abused services.
In addition, firewall helps you to filter information as received from Internet and block unwanted network traffic going to Internet. It also blocks all unsolicited attempts to connect to your computer without your knowledge and keeps the endpoint safe from malicious actors.
By enforcing firewall rules, you are limiting potential attack surface of the endpoint as exploitable services can no longer be accessed easily. Further, you can enforce IPSEC authentication on all the management services and provide additional encryption to services that rely on plaintext or weak ciphers. By having these measures in place, you are making the life of attacker more difficult and frustrating!

### Firewall policy principles
The following points should be considered when deploying firewall policies in an enterprise.
#### Central Management
If you have active directory environment then its good to rely on using Group Policy Objects (GPO) for managing firewall rules. This has the benefit of native integration and using Advanced Group Policy Management (AGPM), you can change, control, rollback, all the rules as per your requirement.
#### Block everything by default. 
The basic principle to be followed is to block all services by default. Only whitelist critical services as per the requirements and with appropriate scope. Rest everything can go to a blackhole!
#### Enforce authentication
Before any communication with critical services/hosts, all the remote devices and users MUST need to authenticate themselves. If they don't, just ignore the requests.
#### Encrypt plaintext protocols. 
It is recommended to apply encryption and integrity protections on plaintext protocols like FTP.
#### Use strong cryptographic settings. 
From security perspective, ALWAYS use strong ciphers, key sizes, and protocols when establishing IPSec tunnels.
#### Ignore local policies. 
By default, any user or application can create local firewall rules. So, it is recommended to deny application of local firewall rules.

< To be continued...>

#### Credits:
* Endpoint isolation using Windows firewall - https://medium.com/@cryps1s/endpoint-isolation-with-the-windows-firewall-462a795f4cfb
* Windows firewall policies design - https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-firewall/checklist-implementing-a-basic-firewall-policy-design
* Advanced security using windows firewall - https://www.admin-magazine.com/Articles/Advanced-Security-in-Windows-Firewall
* 
