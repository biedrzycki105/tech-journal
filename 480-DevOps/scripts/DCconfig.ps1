### Install ADDS and create a domain
Add-WindowsFeature AD-Domain-Services
Install-ADDSForest -DomainName erik.local -InstallDNS

### Making A Records

#Add-DnsServerResourceRecordA -Name "xubuntu-wan" -ZoneName "erik.local" -AllowUpdateAny -IPv4Address "10.0.17.100"
#Add-DnsServerResourceRecordA -Name "480-fw" -ZoneName "erik.local" -AllowUpdateAny -IPv4Address "10.0.17.2"
#Add-DnsServerResourceRecordA -Name "vcenter" -ZoneName "erik.local" -AllowUpdateAny -IPv4Address "10.0.17.3"

### Create Reverse Lookup Zone

#Add-DnsServerPrimaryZone -NetworkID "10.0.17.0/24" -ReplicationScope "Domain"

### Making PTR Records

#Add-DnsServerResourceRecordPtr -Name "100" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "xubuntu-wan.erik.local"
#Add-DnsServerResourceRecordPtr -Name "2" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "480-fw.erik.local"
#Add-DnsServerResourceRecordPtr -Name "3" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "vcenter.erik.local"
#Add-DnsServerResourceRecordPtr -Name "4" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "dc1.erik.local"

### Install DHCP

Install-WindowsFeature DHCP -IncludeManagementTools
Add-DHCPServerv4Scope -Name “480” -StartRange 10.0.17.101 -EndRange 10.0.17.150 -SubnetMask 255.255.255.0 -State Active



#Set-DHCPServerv4OptionValue -ScopeID 192.168.64.0 -DnsDomain corp.momco.com -DnsServer 192.168.64.2 -Router 192.168.64.1
#Add-DhcpServerInDC -DnsName corp.momco.com -IpAddress 192.168.64.2
#Restart-service dhcpserver
