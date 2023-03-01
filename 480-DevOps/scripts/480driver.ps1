Import-Module 480-utils -Force

480Banner
$conf = Get-480Config -config_path "/home/xubuntu-wan/Documents/GitHub/tech-journal/480-DevOps/configs/480.json"
Connect-480Server -vcenter_server $conf.vcenter_server

#Deploy-LinkedClone

Deploy-FullClone
