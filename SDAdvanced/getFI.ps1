function get-fi{
[cmdletbinding(PositionalBinding=$false)]
Param([Parameter(Mandatory,Position=0)][ValidateLength(9,9)][string]$aba,$b,$c,$d)
write-host "the aba is $aba"
}

function get-server{
[cmdletbinding()]
Param([ValidateSet('WebServer','AppServer','DatabaseServer')][string]$servertype)
write-host "the servertype is $servertype"
}