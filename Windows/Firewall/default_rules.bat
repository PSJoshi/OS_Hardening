
##################### Firewall configuration ########################
# default firewall behaviour - Block incoming, block outgoing
netsh advfirewall set allprofile firewallpolicy blockinbound,blockoutbound

#### enable firewall logging #####
# store firewall logs to pfirewall.log
netsh advfirewall set allprofiles logging filename %systemroot%\system32\LogFiles\Firewall\pfirewall.log

# log all allowed firewall connections 
netsh advfirewall set allprofiles logging allowedconnetions enable

# log all denied firewall connections
netsh advfirewall set allprofiles logging droppedconnections enable

####### End of firewall logging ######

# Enable/Disable firewall inbound/outbound rules as per policy

##### firewall inbound rules #####
# netsh advfirewall firewall add rule name=https_in localport=443 dir=in  protocol=tcp action=allow
# netsh advfirewall firewall add rule name=ssh_in localport=22 dir=in protocol=tcp action=allow
# netsh advfirewall firewall add rule name=telnet_in localport=23 dir=in protocol=tcp action=block
# netsh advfirewall firewall add rule name=ftp_in localport=21 dir=in protocol=tcp action=block 
# netsh advfirewall firewall add rule name=metasploit_in localport=4444 dir=in protocol=tcp action=block
# netsh advfirewall firewall add rule name=rpc_in localport=135 dir=in protocol=tcp action=block
# netsh advfirewall firewall add rule name=smb_in localport=445 dir=in protocol=tcp action=block
# netsh advfirewall firewall add rule name=rlogin_in localport=513 dir=in protocol=tcp action=block

# netsh advfirewall firewall add rule name=northkorea_subnet_in localport=any remoteip=175.45.176.0/24 dir=in protocol=tcp action=block
# netsh advfirewall firewall add rule name=northkorea_subnet_in localport=any remoteip=175.45.177.0/24 dir=in protocol=tcp action=block
# netsh advfirewall firewall add rule name=northkorea_subnet_in localport=any remoteip=175.45.178.0/24 dir=in protocol=tcp action=block
# netsh advfirewall firewall add rule name=northkorea_subnet_in localport=any remoteip=175.45.179.0/24 dir=in protocol=tcp action=block
##### End of firewall inbound rules #####

##### firewall outbound rules #####
# netsh advfirewall firewall add rule name=https_out localport=443 dir=out protocol=tcp action=allow
# netsh advfirewall firewall add rule name=ssh_out localport=22 dir=out protocol=tcp action=allow
# netsh advfirewall firewall add rule name=telnet_out localport=23 dir=out protocol=tcp action=block
# netsh advfirewall firewall add rule name=ftp_out localport=21 dir=out protocol=tcp action=block
# netsh advfirewall firewall add rule name=metasploit_out localport=4444 dir=out protocol=tcp action=block 
# netsh advfirewall firewall add rule name=rpc_out localport=135 dir=out protocol=tcp action=block
# netsh advfirewall firewall add rule name=smb_out localport=445 dir=out protocol=tcp action=block
# netsh advfirewall firewall add rule name=rlogin_out localport=513 dir=out protocol=tcp action= block
##### End of firewall outbound rules #####

#####################################################################
