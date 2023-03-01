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

function SelectFolder()
{
    $allFolders = @(Get-Folder -Location $datastore)
    $i = 0
    foreach($folderChoice in $allFolders)
    {
        Write-Host [$i] $folderChoice
        $i++
    }
    $folder = Read-Host "What folder do you want to clone from?"
}

function SelectVM()
{
    $allVMs = @(Get-VM -Location $folder)
    $i = 0
    foreach($vmChoice in $allVMs)
    {
        Write-Host [$i] $vmChoice
        $i++
    }
    $vm_selected = Read-Host "What VM do you want to clone? Please type full VM name as listed (i.e. xubuntu-wan)"
}

function DeployLinkedClone()
{
$vm = Get-VM -Name $allVMs[$vm_selected] 

### Grabs snapshot from VM
$snapshot = Get-Snapshot -VM $vm -Name $snapshot_name

### Gets ESXi Host
$vmhost = Get-VMHost -Name $esxi_host

### Creates Linked Clone
$linkedClone = Read-Host "What will the new VM be called?"
$linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $datastore -Location $linked_folder
$linkedvm | New-Snapshot -Name $snapshot_name
$linkedvm | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName $network
}

function DeployFullClone()
{
    
}