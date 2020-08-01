<#

Shortcut Location:
C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

Shortcut Info:
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -windowstyle hidden -noninteractive -nologo -file "C:\Users\User\Desktop\RestoreVPN.ps1"

#>
while ($true)
        {
            $vpnname = "PowershellClass"
            $vpnusername = "tbible"
            $vpnpassword = "P@ssw0rd"
            $vpn = Get-VpnConnection | where {$_.Name -eq $vpnname}
            if ($vpn.ConnectionStatus -eq "Disconnected")
            {
                $cmd = $env:WINDIR + "\System32\rasdial.exe"
                $expression = "$cmd ""$vpnname"" $vpnusername $vpnpassword"
                Invoke-Expression -Command $expression 
            }
            start-sleep -seconds 30
        }
