# Installing Docker on Windows Server 2016

## Pre-requisite:

- Install Windows 2016

## Using OneGet PowerShell Module

To install the Docker Engine - Enterprise on your hosts, Docker provides a OneGet PowerShell Module.

Open an elevated PowerShell command prompt, and type the following commands.

```
Install-Module DockerMsftProvider -Force
```

```
PS C:\Users\Administrator> Install-Module DockerMsftProvider -Force

NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet-based repositories. The NuGet
 provider must be available in 'C:\Program Files\PackageManagement\ProviderAssemblies' or
'C:\Users\Administrator\AppData\Local\PackageManagement\ProviderAssemblies'. You can also install the NuGet provider by
 running 'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'. Do you want PowerShellGet to install
and import the NuGet provider now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): Y
PS C:\Users\Administrator>

```

## Troubleshooting

In case you encounter the below issue:

```
Install-Package : KB3176936 or later is required for docker to work
```

Full Error Message:

```
PS C:\Users\Administrator> Install-Package Docker -ProviderName DockerMsftProvider -Force
Install-Package : KB3176936 or later is required for docker to work
At line:1 char:1
+ Install-Package Docker -ProviderName DockerMsftProvider -Force
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (Microsoft.Power....InstallPackage:InstallPackage) [Install-Package],
   Exception
    + FullyQualifiedErrorId : RequiredWindowsUpdateNotInstalled,Install-Package,Microsoft.PowerShell.PackageManagement
   .Cmdlets.InstallPackage

PS C:\Users\Administrator> KB3176936 or later is required for docker to work

```

## How to fix this issue?


