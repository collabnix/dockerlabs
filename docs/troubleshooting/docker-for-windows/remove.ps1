Run this script in Powershell, preferably from an elevated prompt.You can save it with a .ps1 extension.

    $ErrorActionPreference = "SilentlyContinue"

    kill -force -processname 'Docker for Windows', com.docker.db, vpnkit, com.docker.proxy, com.docker.9pdb, moby-diag-dl, dockerd

    try {
        ./MobyLinux.ps1 -Destroy
    } Catch {}

    $service = Get-WmiObject -Class Win32_Service -Filter "Name='com.docker.service'"
    if ($service) { $service.StopService() }
    if ($service) { $service.Delete() }
    Start-Sleep -s 5
    Remove-Item -Recurse -Force "~/AppData/Local/Docker"
    Remove-Item -Recurse -Force "~/AppData/Roaming/Docker"
    if (Test-Path "C:\ProgramData\Docker") { takeown.exe /F "C:\ProgramData\Docker" /R /A /D Y }
    if (Test-Path "C:\ProgramData\Docker") { icacls "C:\ProgramData\Docker\" /T /C /grant Administrators:F }
    Remove-Item -Recurse -Force "C:\ProgramData\Docker"
    Remove-Item -Recurse -Force "C:\Program Files\Docker"
    Remove-Item -Recurse -Force "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Docker"
    Remove-Item -Force "C:\Users\Public\Desktop\Docker for Windows.lnk"
    Get-ChildItem HKLM:\software\microsoft\windows\currentversion\uninstall | % {Get-ItemProperty $_.PSPath}  | ? { $_.DisplayName -eq "Docker" } | Remove-Item -Recurse -Force
    Get-ChildItem HKLM:\software\classes\installer\products | % {Get-ItemProperty $_.pspath} | ? { $_.ProductName -eq "Docker" } | Remove-Item -Recurse -Force
    Get-Item 'HKLM:\software\Docker Inc.' | Remove-Item -Recurse -Force
    Get-ItemProperty HKCU:\software\microsoft\windows\currentversion\Run -name "Docker for Windows" | Remove-Item -Recurse -Force
    #Get-ItemProperty HKCU:\software\microsoft\windows\currentversion\UFH\SHC | ForEach-Object {Get-ItemProperty $_.PSPath} | Where-Object { $_.ToString().Contains("Docker for Windows.exe") } | Remove-Item -Recurse -Force $_.PSPath
    #Get-ItemProperty HKCU:\software\microsoft\windows\currentversion\UFH\SHC | Where-Object { $(Get-ItemPropertyValue $_) -Contains "Docker" }
