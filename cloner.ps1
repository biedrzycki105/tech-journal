### Erik Biedrzycki | Make full or linked clone VMs

### Connect to vCenter
$vcenter = "vcenter.erik.local"
Connect-VIServer -Server $vcenter

$cloneType = Read-Host "What type of clone would you like to make?"

function linked {
### Locates VMs and lists out all VMs in datastore
$datastore = Get-DataStore -Name "datastore1-super27"
$folder = "BASE_VMS"
$allVMs = @(Get-VM -Location $folder)
$i = 0
foreach($vmChoice in $allVMs)
{
    Write-Host [$i] $vmChoice
    $i++
}

### Asks for VM that needs to be cloned
$vmname = Read-Host "What VM do you want to clone? Please type full VM name as listed (i.e. xubuntu-wan)"
$vm = Get-VM -Name $vmname

### Grabs snapshot from VM
$snapshot = Get-Snapshot -VM $vm -Name "base"

### Gets ESXi Host
$vmhost = Get-VMHost -Name "192.168.7.37"

### Creates Linked Clone
$linkedClone = Read-Host "What will the new VM be called?"
$linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $datastore -Location "LINKED_VMS"
$linkedvm | New-Snapshot -Name "base"
$linkedvm | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName "480-WAN"
}

function full {
### Locates VMs and lists out all VMs in datastore
$datastore = Get-DataStore -Name "datastore1-super27"
$folder = "PROD"
$allVMs = @(Get-VM -Location $folder)
$i = 0
foreach($vmChoice in $allVMs)
{
    Write-Host [$i] $vmChoice
    $i++
}

### Asks for VM that needs to be cloned
$vmname = Read-Host "What VM do you want to clone? Make sure VM is turned off! Please type full VM name as listed (i.e. xubuntu-wan)"
$vm = Get-VM -Name $vmname

### Grabs snapshot from VM
$snapshot = Get-Snapshot -VM $vm -Name "base"

### Gets ESXi Host
$vmhost = Get-VMHost -Name "192.168.7.37"

### Creates Linked Clone
$linkedClone = "{0}.linked" -f $vm.name
$linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $datastore -Location "LINKED_VMS"

### Creates New VM from Linked Clone and takes snapshot
$newvmname = Read-Host "What would you like your new Base VM to be named?"
$newvm = New-VM -Name $newvmname -VM $linkedvm -VMHost $vmhost -Datastore $datastore -Location "BASE_VMS"
$newvm | New-Snapshot -Name "base"

### Removes Linked VM (vm.linked)
$linkedvm | Remove-VM
}
