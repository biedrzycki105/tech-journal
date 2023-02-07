### Install ADDS and create a domain
$domain = "erik.local"
Add-WindowsFeature AD-Domain-Services
Install-ADDSForest -DomainName $dom -InstallDNS
### Making A Records
Add-DnsServerResourceRecordA -Name "xubuntu-wan" -ZoneName "erik.local" -AllowUpdateAny -IPv4Address "10.0.17.100"
Add-DnsServerResourceRecordA -Name "480-fw" -ZoneName "erik.local" -AllowUpdateAny -IPv4Address "10.0.17.2"
Add-DnsServerResourceRecordA -Name "vcenter" -ZoneName "erik.local" -AllowUpdateAny -IPv4Address "10.0.17.3"
### Create Reverse Lookup Zone
### Making PTR Records
Add-DnsServerResourceRecordPtr -Name "100" -ZoneName "0.17.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "xubuntu-wan.erik.local"
Add-DnsServerResourceRecordPtr -Name "2" -ZoneName "0.17.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "480-fw.erik.local"
Add-DnsServerResourceRecordPtr -Name "3" -ZoneName "0.17.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "vcenter.erik.local"
Add-DnsServerResourceRecordPtr -Name "4" -ZoneName "0.17.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "dc1.erik.local"
