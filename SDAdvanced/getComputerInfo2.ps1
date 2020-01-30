function get-Computerinfo{
[CmdletBinding()]
Param([Parameter(ValueFromPipeline)][String[]]$ComputerName)

process {
    foreach($comp in $ComputerName){
        $os=get-ciminstance -ClassName Win32_OperatingSystem -ComputerName $comp
        $cmp=Get-CimInstance -ComputerName $comp -class Win32_ComputerSystem |
                   Select-Object -Property Name,
                                           @{N='MemInGB';E={[Math]::Round($_.TotalPhysicalMemory/1gb,2)}},
                                           NumberOfLogicalProcessors,
                                           NumberOfProcessors
        $ip=Resolve-DnsName -Name $comp | where-object Type -eq A 
        $drives=Get-ciminstance -ClassName Win32_logicaldisk -ComputerName $comp -Filter "DriveType=3"
        [PSCustomObject]@{   Name=$comp
                            Memory=$cmp.MemInGB
                            Procs=$cmp.NumberOfProcessors
                            Cores=$cmp.NumberOfLogicalProcessors
                            IP=$ip.IPAddress
                            Drives=$drives}


    }
}
} 