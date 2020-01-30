function Stop-Thing{
[CmdletBinding(SupportsShouldProcess)]
Param($thing)
if($PSCmdlet.ShouldProcess($thing)){
    write-host "stopped $thing"
} else {
    write-host "you passed whatif"
}
}