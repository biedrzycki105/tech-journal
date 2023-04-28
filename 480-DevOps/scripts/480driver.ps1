Import-Module 480-utils -Force

480Banner
$conf = Get-480Config -configPath "/home/xubuntu-wan/Documents/GitHub/tech-journal/480-DevOps/configs/480.json"
Connect-480Server -vcenter_server $conf.vcenter_server

# BASE VMS
#server.2019.gui.base
#windows10.ltsc.base
#server.2019.core.base

Set-Network -VMName blue1-wks1 -location "BLUE1-LAN"
Set-Network -VMName blue1-dc1 -location "BLUE1-LAN"
#Deploy-LinkedClone -VM "server.2019.core.base" -CloneName "blue1-dc1" -Folder "BLUE1-LAN" 
#Deploy-LinkedClone -VM "windows10.ltsc.base" -CloneName "blue1-wks1" -Folder "BLUE1-LAN" 
#Deploy-FullClone

#New-Network -NetworkName "Milestone6Test" -Server $conf.vcenter_server -VMHost $conf.esxi_host
#Get-IP -VMName "ubuntu1" -VMHost $conf.esxi_host
#Get-IP -VMName "ubuntu2" -VMHost $conf.esxi_host
#Get-IP -VMName "rocky3" -VMHost $conf.esxi_host
#Edit-VM -VMName "awx" -CPU "4" -MemGB "4"


