function 480Banner()
{
    $banner=@"
     ______      _ _      _                 _
    |  ____|    (_) |    | |               | |
    | |__   _ __ _| | __ | | ___   ___ __ _| |
    |  __| | '__| | |/ / | |/ _ \ / __/ _` | |
    | |____| |  | |   < _| | (_) | (_| (_| | |
    |______|_|  |_|_|\_(_)_|\___/ \___\__,_|_|
"@
    Write-Host $banner 
}

function Get-480Config([string] $config_path)
{
    $conf = (Get-Content -Raw -Path $config_path | ConvertFrom-Json)
    return $conf
}

function Connect-480Server([string] $vcenter_server)
{
    Connect-VIServer -Server $vcenter_server
}

function Select-Folder()
{
    $folders = @(Get-Folder -Type VM)
    $i = 0
    foreach($folder in $folders)
    {
        Write-Host [$i] $folder
        $i++
    }
    $folderChoice = Read-Host "What folder do you want to clone from? Please type the index number only"
    $folder_selected = $folders[$folderChoice]
    return $folder_selected
}

function Select-VM()
{
    $folder_selected = Select-Folder
    $vms = @(Get-VM -Location $folder_selected)
    $i = 0
    foreach($vm in $vms)
    {
        Write-Host [$i] $vm
        $i++
    }
    $vmChoice = Read-Host "What VM do you want to clone? Please type the index number only"
    $vm_selected = $vms[$vmChoice]
    return $vm_selected
}

function Deploy-LinkedClone()
{
    Get-480Config -config_path "/home/xubuntu-wan/Documents/GitHub/tech-journal/480-DevOps/configs/480.json"
    $vm_selected = Select-VM

    ### Grabs snapshot from VM
    $snapshot = Get-Snapshot -VM $vm_selected -Name $conf.snapshot_name

    ### Gets ESXi Host
    $vmhost = Get-VMHost -Name $conf.esxi_host

    ### Creates Linked Clone
    $linkedClone = Read-Host "What will the new VM be called?"
    $linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm_selected -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $conf.datastore -Location $conf.linked_folder
    $linkedvm | New-Snapshot -Name $conf.snapshot_name
    $linkedvm | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName $conf.network
}

function Deploy-FullClone()
{
    Get-480Config -config_path "/home/xubuntu-wan/Documents/GitHub/tech-journal/480-DevOps/configs/480.json"
    $vm_selected = Select-VM
    $snapshot = Get-Snapshot -VM $vm_selected -Name $conf.snapshot_name
    $vmhost = Get-VMHost -Name $conf.esxi_host
    $linkedClone = "{0}.linked" -f $vm_selected.name
    $linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm_selected -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $conf.datastore -Location $conf.linked_folder
    
    ### Creates New VM from Linked Clone and takes snapshot
    $newvmname = Read-Host "What would you like your new Base VM to be named?"
    $newvm = New-VM -Name $newvmname -VM $linkedvm -VMHost $vmhost -Datastore $conf.datastore -Location $conf.linked_folder
    $newvm | New-Snapshot -Name $conf.snapshot_name
    
    ### Removes Linked VM (vm.linked)
    $linkedvm | Remove-VM
}