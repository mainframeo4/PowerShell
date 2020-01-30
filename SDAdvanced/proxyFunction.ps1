$MetaData = New-Object System.Management.Automation.CommandMetaData (Get-Command  select-object) 
[System.Management.Automation.ProxyCommand]::Create($MetaData)
