### Erik Biedrzycki | Cloner 

### Connect to vCenter
$vcenter = "vcenter.erik.local"
Connect-VIServer -Server $vcenter


### Locates VMs and lists out all VMs in datastore
$datastore = Get-DataStore -Name "datastore1-super27"
$allVMs = @(Get-VM -Location $datastore)
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
$linkedClone = "{0}.linked" -f $vm.name
$linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $datastore

### Creates New VM from Linked Clone and takes snapshot
$newvm = New-VM -Name "server.2019.gui.base" -VM $linkedvm -VMHost $vmhost -Datastore $datastore
$newvm | New-Snapshot -Name "base"

### Removes Linked Clone (vm.linked)
$linkedvm | Remove-VM