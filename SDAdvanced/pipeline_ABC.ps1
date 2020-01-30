 Function A{
[CmdletBinding()]
Param([Parameter(ValueFromPipeline=$true)]$a)
Begin{
    write-host “A in BEGIN”
}
Process {
    write-host “A in PROCESS”
    write-host “`$a is $a”
    write-output “A: $a”
}
End {
   write-host “A in END”
}
}

Function B{
[CmdletBinding()]
Param([Parameter(ValueFromPipeline=$true)]$B)
Begin{
    write-host “B in BEGIN”
}
Process {
    write-host “B in PROCESS”
    write-host “`$b is $b”
    write-output “B: $b”
}
End {
   write-host “B in END”
}
}

Function C{
[CmdletBinding()]
Param([Parameter(ValueFromPipeline=$true)]$c)
Begin{
    write-host “C in BEGIN”
}
Process {
    write-host “C in PROCESS”
    write-host “`$c is $c”
    write-output “C: $c”
}
End {
   write-host “C in END”
}
}

Function d{
[CmdletBinding()]
Param([Parameter(ValueFromPipeline=$true)]$d)
    write-host “d in running”
    $d
}
1,2,3 | a | b | c | d