# Create a Domain Controller

## Setup

* SuperMicro Server
  * 64GB RAM
  * 500GB Storage
  * ESXi Installed
* ESXi Host Configuration
  * ISO directory created with ISOs present
  * \[\[480-FW]] configured
  * \[\[Xubuntu]] box created
  * Windows Server ISO in ISOs folder
* Login to ESXi Host

## Step-by-step

### Create Base Snapshot

* Building the VM
  * Create a VM with the following specs:
    * 2 CPU
    * 4 GB RAM
    * 90 GB Storage (Thin Provisioned)
    * CD/ROM Drive: Datastore ISO > datastore-super27/ISOs/SW\_DVD9\_Win\_Server\_STD\_CORE\_2019\_1909.4\_64Bit\_English\_DC\_STD\_MLF\_X22-29333.ISO
  * Go through Windows Server 2019 install wizard
  * Reboot
  * You will see a prompt to enter a new Administrator password. Instead, use Ctrl+Shift+F3 to boot into Audit Mode. Audit Mode allows you to customize your computer, add applications and device drivers, and test your computer in a Windows environment. It will look like this:
    * ![image](https://user-images.githubusercontent.com/90063737/216848177-cf1fd9d8-3144-4f9c-a4c9-5f4949f431cb.png)
* Server Configurations
  * Use the command `sconfig` to configure these settings:
    * Manual updates (option 5)
      * ![image](https://user-images.githubusercontent.com/90063737/217150607-e9dd1a22-caa1-46c0-9cef-c4d0697e58d8.png)
    * Eastern Time Zone (option 9)
      * ![image](https://user-images.githubusercontent.com/90063737/217150726-e3520738-42a8-46be-b0aa-827d0bac6e29.png)
    * Run updates (option 6)
      * ![image](https://user-images.githubusercontent.com/90063737/217150893-898e7ba3-6017-4f0f-b654-2a790aded530.png)
* Installing VMWare Tools
  * Right-click the VM on the left side of the ESXi Host menu. Select Guest OS > Install VMware Tools
    * ![image](https://user-images.githubusercontent.com/90063737/217157572-50238135-d353-42e9-a707-cce1987d51fa.png)
  * VMware allows you to install VMware Tools by mounting a virtual DVD drive with VMware Tools on it. Run _setup64.exe_
    * ![image](https://user-images.githubusercontent.com/90063737/217158056-e112f0b2-c33a-4d9e-8bc0-cf79a8708461.png)
  * Reboot
* Running Sysprep script
  * Open Powershell and navigate to where you want the sysprep script to be: `cd .\Documents`
  * Get the script: `wget https://raw.githubusercontent.com/gmcyber/RangeControl/main/src/scripts/base-vms/windows/windows-prep.ps1 -Outfile ./windows-prep.ps1`
  * Unblock and trust the new file:
    * `Unblock-File .\windows-prep.ps1`
    * `Set-ExecutionPolicy RemoteSigned` (Select Y when prompted)
  * Run the script: `.\windows-prep.ps1`
* Create Base Snapshot
  * Allow the VM to shutdown completely
  * Create the base snapshot
    * ![image](https://user-images.githubusercontent.com/90063737/217162450-8756a52a-1017-4070-bfc5-37552ee226fb.png)

### Configure Domain Controller

* Turn on and log into the _deployer_. You will need to use Ctrl+Alt+Delete, but using your own keyboard will interface with the jump box OS. You need to send a virtual keystroke.
  * ![image](https://user-images.githubusercontent.com/90063737/217298040-6ae0c4ef-1a08-4408-8334-695129ef8931.png)
* Configure network and hostname
  * Put server on 480-WAN segment (Actions > Edit Settings > Network Adapter 1 > 480-WAN)
  * Configure IP, and make the default gateway and DNS server both be the IP of the 480-fw box
  * Give box a hostname of _**dc1**_
* Install ADDS and create a domain
  * `Add-WindowsFeature AD-Domain-Services -IncludeManagementTools`
  * `Install-ADDSForest -DomainName erik.local -InstallDNS`
* Making A Records
  * `Add-DnsServerResourceRecordA -Name "xubuntu-wan" -ZoneName "erik.local" -AllowUpdateAny -IPv4Address "10.0.17.100"`
  * `Add-DnsServerResourceRecordA -Name "480-fw" -ZoneName "erik.local" -AllowUpdateAny -IPv4Address "10.0.17.2"`
  * `Add-DnsServerResourceRecordA -Name "vcenter" -ZoneName "erik.local" -AllowUpdateAny -IPv4Address "10.0.17.3"`
* Create Reverse Lookup Zone
  * `Add-DnsServerPrimaryZone -NetworkID "10.0.17.0/24" -ReplicationScope "Domain"`
* Making PTR Records
  * `Add-DnsServerResourceRecordPtr -Name "100" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "xubuntu-wan.erik.local"`
  * `Add-DnsServerResourceRecordPtr -Name "2" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "480-fw.erik.local"`
  * `Add-DnsServerResourceRecordPtr -Name "3" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "vcenter.erik.local"`
  * `Add-DnsServerResourceRecordPtr -Name "4" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "dc1.erik.local"`
* Enable Remote Desktop and allow it through the firewall
  * `Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0`
  * `Enable-NetFirewallRule -DisplayGroup "Remote Desktop"`
* Install DHCP
  * `Install-WindowsFeature DHCP -IncludeManagementTools`
  * `Add-DHCPServerv4Scope -Name “480” -StartRange 10.0.17.101 -EndRange 10.0.17.150 -SubnetMask 255.255.255.0 -State Active`
  * `Set-DHCPServerv4OptionValue -ScopeID 10.0.17.0 -DnsDomain erik.local -DnsServer 10.0.17.4 -Router 10.0.17.2`
  * `Add-DhcpServerInDC -DnsName erik.local -IpAddress 10.0.17.4`
  * `Restart-service dhcpserver`
* Create Domain Admin
  * `New-ADUser -Name erik.biedrzycki-adm -AccountPassword <password> -Passwordneverexpires $true -Enabled $true`
  * `Add-ADGroupMember -Identity "Domain Admins" -Members erik.biedrzycki-adm`

### Working Notes

* ![image](https://user-images.githubusercontent.com/90063737/217379208-5d042a2c-9b42-4e7d-89d1-7414e37f6b72.png)
* ![image](https://user-images.githubusercontent.com/90063737/217401340-b58ca13f-430e-4606-8bfb-3e7d905dca16.png)
