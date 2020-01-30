function add-thing2{
[CmdletBinding()]
Param($a,$b)
write-error "We're about to add $a and $b" 
$a+$b
}

try {
add-thing2 10 20 -erroraction stop
} catch {
write-host "something bad happened $_"
}