# Deploying and Post Provisioning of BlueX Linux Servers

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

* Create a RockyOS base VM. Refer to previous milestones if needed.
  * Go to Devin's web page with all the ISOs, SSH into ESXi host, wget the ISO into the proper directory in the datastore.
  * Prep the box however you need. Remove MAC address and other machine-specific info. Make base snapshot
  * I used Devin's rhel-sealer.sh script
  * ![image](https://user-images.githubusercontent.com/90063737/226922021-db312af4-5351-45a1-9957-b1213efb1878.png)
* Configure blue1 vyos firewall
  * Static Route
    * `set protocols static route 0.0.0.0/0 next-hop 10.0.17.2`
  * Set up NAT
    * `set nat source rule 10 source address 10.0.5.0/24`
    * `set nat source rule 10 translation address masquerade`
  * Set up DHCP
    * ```
       set service dhcp-server global-parameters 'local-address {{ lan_ip }};'
       set service dhcp-server shared-network-name {{ shared_network }} authoritative
       set service dhcp-server shared-network-name {{ shared_network }} subnet {{ lan }} default-router '{{ lan_ip }}'
       set service dhcp-server shared-network-name {{ shared_network }} subnet {{ lan }} name-server '{{ dhcp_name_server }}'
       set service dhcp-server shared-network-name {{ shared_network }} subnet {{ lan }} domain-name '{{ dhcp_domain }}'
       set service dhcp-server shared-network-name {{ shared_network }} subnet {{ lan }} lease '86400'
       set service dhcp-server shared-network-name {{ shared_network }} subnet {{ lan }} range {{ shared_network }}-POOL start '10.0.5.75'
       set service dhcp-server shared-network-name {{ shared_network }} subnet {{ lan }} range {{ shared_network }}-POOL stop '10.0.5.125'

      ```
