get-wmiobject -class *service* -list

get-wmiobject -class win32_service | get-member

Get-CimClass -ClassName *service*

get-ciminstance -class win32_service