### Erik Biedrzycki | Clone From Production

### Connect to vCenter
$vcenter = "vcenter.erik.local"
Connect-VIServer -Server $vcenter


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
$vmname = Read-Host "What VM do you want to clone? Make sure VM is turned off! Please type full VM name as listed (i.e. xubuntu-wan)"
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