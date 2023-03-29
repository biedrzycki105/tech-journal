Import-Module 480-utils -Force

480Banner
$conf = Get-480Config -configPath "/home/xubuntu-wan/Documents/GitHub/tech-journal/480-DevOps/configs/480.json"
Connect-480Server -vcenter_server $conf.vcenter_server

#Deploy-LinkedClone
#Deploy-FullClone

# New-Network -NetworkName "BLUE1-LAN" -Server $conf.vcenter_server -VMHost $conf.esxi_host
Get-IP -VMName "blue1-fw" -VMHost $conf.esxi_host
