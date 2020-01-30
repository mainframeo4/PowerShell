function get-Computerinfo{
[CmdletBinding()]
Param([Parameter(ValueFromPipeline)][String[]]$ComputerName)

process {
    foreach($comp in $ComputerName){
        Get-CimInstance -ComputerName $comp -class Win32_ComputerSystem |
                   Select-Object -Property Name,
                                           @{N='MemInGB';E={[Math]::Round($_.TotalPhysicalMemory/1gb,2)}},
                                           NumberOfLogicalProcessors,
                                           NumberOfProcessors

    }
}
} 