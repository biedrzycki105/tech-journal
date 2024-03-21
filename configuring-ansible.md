# Configuring Ansible

## Setup

* SuperMicro Server
  * 64GB RAM
  * 500GB Storage
  * ESXi Installed
* VM Configuration
  * ISO directory created with ISOs present
  * \[\[480-FW]] configured
  * \[\[Xubuntu]] box created
  * Configure Domain Controller w/ ADDS, DNS, DHCP
  * vCenter installed
  * CA Configured
    * `Install-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools`
    * `Install-ADcsCertificationAuthority -CACommonName "erik-dc1-ca" -CAType EnterpriseRootCA -KeyLength 2048 –HashAlgorithmName SHA256 –ValidityPeriod Years –ValidityPeriodUnits 5`
  * ADDS SSO configured on vCenter
  * Install Ansible, Powershell, PowerCLI on Xubuntu-WAN
  * VM Cloning script written
  * 480-Utils Powershell Module
* Login to ESXi Host

## Step-by-step

* Install SSH and Paramiko
* Install Ansible
* Generate key pair and copy public keys to all target machines
*
