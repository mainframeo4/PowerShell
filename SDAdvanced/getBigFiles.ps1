function get-BigFiles{
[CmdletBinding()]
Param([Parameter(ValueFromPipeline=$true)][string]$path)
process {
    dir $path |
         sort-object –property Length –descending |
        select-object -first 1
}
} 
