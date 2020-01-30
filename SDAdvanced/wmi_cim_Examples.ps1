$x=get-ciminstance -ClassName win32_logicaldisk -filter "DeviceID='C:'" |
   select-object -Property DeviceID,
                           @{Name='SizeInGB';Expression={[Math]::Round($_.Size/1GB,2)}},
                           @{Name='FreeSpaceInGB';Expression={[Math]::Round($_.FreeSpace/1GB,2)}}

$y=get-ciminstance -ClassName Win32_share

$z=get-ciminstance -classname Win32_Computersystem | 
    select-object -Property @{Name='MemoryInGB';Expression={[Math]::Round($_.TotalPhysicalMemory/1GB,2)}},
                            NumberOfLogicalProcessors,
                            NumberOfProcessors