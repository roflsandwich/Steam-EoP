# steam_EoP.ps1
Command execution as NT_Authority\System

Works without admin privileges

Original credits: https://twitter.com/enigma0x3/status/1159103239729471488

For complete cleanup, at the end:
*regln-x64.exe -d HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Valve\Steam\Apps\PrivEsc*

You can download from here:
https://github.com/tenox7/regln/releases


#*Additional random info*

omgtehlion 1 hour ago [-]

There is more blatant violation:

1. Log on as non-admin on a box with steam 2. Do not start steam or any game 3. cat %system32%\calc.exe > %programfiles%\steam\bin\steamservice.exe 4. Reboot 5. Log on, start steam 6. BAM! Now you have calc.exe (attempted to) run as System with highest local priveleges
reply

yrro 1 hour ago [-]

Have you reported this to the vendor or whatever channels are required to get a CVE? reply

shawnz 1 hour ago [-]

From 2015: https://nvd.nist.gov/vuln/detail/CVE-2015-7985 
