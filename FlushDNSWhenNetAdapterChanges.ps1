# Revision: 7:17 AM 2/26/2020

# This function's intent is to be an 'always on' service. The intent is to clear the DNS cache (ipconfig /flushdns or Clear-DnsClientCache) when moving between wired and wireless.

# To run the script directly, you can adjust the execution policy through an administrator PowerShell
# Set-ExecutionPolicy Unrestricted

 # You can also bypass the execution policy running then call the script.
 # powershell.exe -noprofile -executionpolicy bypass -file "C:\...\FlushDNSWhenNetAdapterChanges.ps1"

function Check-NetIndex {
    # This is specifically looking for domain registered Networks, you can compare all network objects by removing the Where-Object reference.
    $a=Get-CimInstance -ComputerName localhost -Class Win32_NetworkAdapterConfiguration | Where-Object -Property FullDNSRegistrationEnabled -EQ $True
    # This is a while loop, with an if/else command block. Due if and else will never return false, making this an indefinite loop.
    While ($true) {
        Start-Sleep -Seconds 10
        # This is specifically looking for domain registered Networks, you can compare all network objects by removing the Where-Object reference.
        $DNS_Registered_NetAdapters=Get-CimInstance -ComputerName localhost -Class Win32_NetworkAdapterConfiguration | Where-Object -Property FullDNSRegistrationEnabled -EQ $True
        $b=$DNS_Registered_NetAdapters
        # Comparing first NetAdapter set to the second NetAdpater set
        if (diff $a $b) {
            # A match was found, clearing the DNS.
            Clear-DnsClientCache
            Write-Host Cleared the DNS Cache`n
            $a = $b
        } else {
            # No match was found.
            Write-Host No adjustment needed.`n
        }
    }
}
Check-NetIndex
