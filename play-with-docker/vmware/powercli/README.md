
## Pulling Photon OS Docker Image

```
$docker pull vmware/powerclicore
```

## Verify the Docker Image

```
$ docker images
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
vmware/powerclicore   latest              a8e3349371c5        4 months ago        610MB
[node1] (local) root@10.0.37.3 ~
$
```

## Entering into Photon OS container

```
$docker run -itd a8e33 /bin/bash
$docker attach <containerid>
```



## Verify the Photon OS version

```
root [ /powershell ]# cat /etc/os-release
NAME="VMware Photon"
VERSION="1.0"
ID=photon
VERSION_ID=1.0
PRETTY_NAME="VMware Photon/Linux"
ANSI_COLOR="1;34"
HOME_URL="https://vmware.github.io/photon/"
BUG_REPORT_URL="https://github.com/vmware/photon/issues"root [ /powershell ]#

```

## Initiating the powershell inside Photon OS

```
root [ /powershell ]# powershell
PowerShellCopyright (C) Microsoft Corporation. All rights reserved.

          Welcome to VMware vSphere PowerCLI!

Log in to a vCenter Server or ESX host:              Connect-VIServer
To find out what commands are available, type:       Get-VICommand
Once you've connected, display all virtual machines: Get-VM

       Copyright (C) VMware, Inc. All rights reserved.


Loading personal and system profiles took 4247ms.
PS /powershell>
```

## Using Photon Container
<pre>

PS /root> Connect-VIServer 172.17.40.78

Specify Credential
Please specify server credential
User: root
Password for user root: ********


Name                           Port  User
----                           ----  ----
172.17.40.78                   443   root


PS /root> Set-PowerCLIConfiguration -InvalidCertificateAction ignore -confirm:$false

Scope    ProxyPolicy     DefaultVIServerMode InvalidCertificateAction  Display
                                                                       Depreca
                                                                       tionWar
                                                                       nings
-----    -----------     ------------------- ------------------------  -------
Session  UseSystemProxy  Multiple            Ignore                    True
User                     Multiple            Ignore
AllUsers


PS /root> clear
PS /root> Get-VM

Name                 PowerState Num CPUs MemoryGB
----                 ---------- -------- --------
Test_07              PoweredOn  4        8.000
Test_09              PoweredOff 4        8.000
Test_12              PoweredOn  4        8.000
Test_13              PoweredOn  4        8.000
Test_15              PoweredOn  4        8.000
Test_11              PoweredOn  4        8.000
Test_06              PoweredOn  4        8.000
Test_14              PoweredOn  4        8.000
Test_10              PoweredOn  4        8.000
Ajeet_DockerHost     PoweredOn  1        1.000
Test_04              PoweredOn  4        8.000
Ajeet


</pre>

## Ready-Made PowerCLI scripts

```
PS /powershell> ls
PowerCLI-Example-Scripts  PowerCLI.Vds.zip     README.md   open_source_license.txt
PowerCLI.Cis              PowerCLI.ViCore.zip  __MACOSX    powernsx-master
PowerCLI.Cis.zip          PowerCLI_Core.zip    master.zip
```

## List of overall PowerCLI Script

```
PS /powershell/PowerCLI-Example-Scripts/Scripts> ls
AutomaticVMFSUnmap.ps1                     New-ClusterVmGroup.ps1
Check-VMwareTools.ps1                      New-ClusterVmHostRule.ps1
DatastoreSIOCStatistics.ps1                README.md
ESXInstallDate.ps1                         Remove-HostClient.ps1
ESXInstalledVIBs.ps1                       Remove-IPPool.ps1
ExportImportTags.ps1                       Report-LUNPath-ESXCLI.ps1
Get-BiosBootStatus.ps1                     SecureBoot.ps1
Get-DatastoreProvisioned.ps1               Set-LockdownLevel.ps1
Get-VMID.ps1                               Start-VMHostSsh.ps1
Get-VsanHclDatabase.ps1                    Stop-VMHostSsh.ps1
'Home Lab'                                 Sysprep_Automation_Script.ps1
'Horizon View Example Desktop Script.ps1'  Update_PowerCLI_Scripts.ps1
Horizon-GetUsageStats.ps1                  VSANSmartsData.ps1
Host_Memory_Assessment_Tool.ps1            VSANVersion.ps1
Install-HostClient.ps1                     modules.sh
Invoke-BiosBoot.ps1                        'vRealize Operations Maintenance Mode.ps1'
'NVME Info.ps1'                            vSphereLogins.ps1
New-ClusterHostGroup.ps1                   vTool_2016aug.ps1
```
