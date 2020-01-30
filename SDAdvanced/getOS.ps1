function get-OS{
[CmdletBinding()]
Param([Parameter(ValueFromPipeline=$true)][String[]]$ComputerName)

process {
    foreach($comp in $ComputerName){
        Get-CimInstance -ComputerName $comp -class Win32_OperatingSystem
    }
}
} 
