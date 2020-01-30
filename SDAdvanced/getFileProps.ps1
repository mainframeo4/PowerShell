function get-FileProps{
[CmdletBinding()]
Param([Parameter(ValueFromPipelineByPropertyName =$true)]$Extension,
      [Parameter(ValueFromPipelineByPropertyName =$true)]$Name,
      [Parameter(ValueFromPipelineByPropertyName =$true)]$Length
     )

process {
    write-output "Name=$name ;  Extension=$Extension  ; Length=$length"
}
} 
