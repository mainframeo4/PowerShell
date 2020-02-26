##### Next Goal, make the variables a hash table/object, then build the VM from the hash table. #####

##### Comment the vmSwitch out after the first VM is created. #####

Clear-Host
<# Bypassing VMware PowerCLI and Hyper-V Install

#Install/Enable Hyper-V Feature
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V

# Install VMware Module
Install-Module VMware.VimAutomation.Core -AllowClobber -Force

#Running Hyper-V VM commands Example: Hyper-V\Get-VM *
#Running VMware VM commands Example: VMware\Get-VM *

End of Bypass #>

# Virtual Network Variables #
$VM_Switch_Name = "NAT-Switch"
$Switch_IP = "192.168.255.254"
$PrefixLength = 29 # 255.255.255.248
$NAT_Name = "NAT-Network"
$NAT_Network = "192.168.255.248/29"

# Virtual Machine Variables #
################################################## Input Required ################################################## 
$VM_Name = "TestVM"
$VM_CPU = 2
$VM_RAM = 4GB
#$VM_CD_Path = "C:\Users\tbible\Downloads\Linux\SLE-12-SP3-Server-DVD-x86_64-GM-DVD1.iso" #SuSE
#$VM_CD_Path = "C:\Users\tbible\Downloads\Linux\CentOS-8.1.1911-x86_64-dvd1.iso" #CentOS
$VM_CD_Path = "C:\Users\tbible\Downloads\Linux\ubuntu-19.10-desktop-amd64.iso" #Ubuntu
$VHD_Drives = 2 ### Do you want one or two drives? ###
$VHD1_SizeBytes = 30GB # 20GB
$VHD2_SizeBytes = 5GB # 5GB
################################################## ^^^^^^^^^^^^^^ ################################################## 

# Virtual Drive Variables #
$VHD_Name = $VM_Name
$VHD_Path = "$env:public\Documents\Hyper-V\Virtual hard disks\"
$VHD_Extension = ".vhdx"
$VHD_1 = "$VHD_Path$VHD_Name-1$VHD_Extension"
$VHD_2 = "$VHD_Path$VHD_Name-2$VHD_Extension"

<#
################################################## vmSwitch ################################################## 
# Setting up virtual switch with NAT #
New-VMSwitch -SwitchName $vm_Switch_Name -SwitchType Internal
New-NetIPAddress -IPAddress $switch_IP -PrefixLength $PrefixLength -InterfaceIndex (Get-NetAdapter -Name "vEthernet ($vm_Switch_Name)").ifIndex
New-NetNat -Name $NAT_Name -InternalIPInterfaceAddressPrefix $NAT_Network
################################################## ^^^^^^^^^^^^^^ ################################################## 
#>

<# Setting up intial VM #>
Hyper-V\New-VM -Name $VM_Name -MemoryStartupBytes $VM_RAM -Generation 2 -SwitchName NAT-Switch
Hyper-V\Get-VM -VMName $VM_Name | Set-VM -ProcessorCount $VM_CPU -CheckpointType Disabled
Hyper-V\Get-VM -VMName $VM_Name | Set-VMMemory -DynamicMemoryEnabled $False

<# Setting up virtual hard drive(s) #>
IF ( $VHD_Drives -eq 1) {
Hyper-V\New-VHD -Path $VHD_1 -SizeBytes $VHD1_SizeBytes -Fixed
Hyper-V\Get-VM -VMName $VM_Name | Add-VMHardDiskDrive -Path $VHD_1
} Else {
Hyper-V\New-VHD -Path $VHD_1 -SizeBytes $VHD1_SizeBytes -Fixed
Hyper-V\New-VHD -Path $VHD_2 -SizeBytes $VHD2_SizeBytes -Fixed
Hyper-V\Get-VM -VMName $VM_Name | Add-VMHardDiskDrive -Path $VHD_1
Hyper-V\Get-VM -VMName $VM_Name | Add-VMHardDiskDrive -Path $VHD_2
}

Hyper-V\Get-VM -VMName $VM_Name | Add-VMDvdDrive -Path $VM_CD_Path
Hyper-V\Get-VM -VMName $VM_Name | Set-VMFirmware -EnableSecureBoot Off -BootOrder (Get-VMDvdDrive -VMName $VM_Name),(Get-VMHardDiskDrive -VMName $VM_Name -ControllerLocation 0)

Hyper-V\Start-VM -VMName $VM_Name
vmconnect.exe localhost -G (Get-VM -VMName $VM_Name).Id

<#
# Post VM Install, remove CD
Hyper-V\Set-VMDvdDrive -Path $null -VMName $VM_Name
#>

<# Clean up
Hyper-V\Stop-VM -VMName $VM_Name -Force
Hyper-V\Remove-VM -Name $VM_Name -Force
Remove-Item $VHD_1,$VHD_2 -Force

Hyper-V\Remove-VM -Name * -Force
Remove-Item -Include *.vhdx -Path $VHD_Path
Hyper-V\Remove-VMSwitch -SwitchName $vm_Switch_Name -Force
#>

<# Command List
Get-Command | Where-Object -Property Source -EQ Hyper-V

#>

<#
Hyper-V\Get-VM -Name * | Where-Object -Property State -EQ Off | Hyper-V\Start-VM
Hyper-V\Get-VM -VMName * | Where-Object -Property State -EQ Running | ForEach-Object {vmconnect.exe localhost -G $_.id}
#>
