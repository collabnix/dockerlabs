# Lab #14: Create an image with SHELL instruction

## Pre-requisite:

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side



1- Install Docker latest version.<br>
2- Shell instruction syntax 
```
SHELL ["executable", "parameters"]
```
- The SHELL instruction allows the default shell used for the shell form of commands to be overridden. The default shell on Linux is `["/bin/sh", "-c"]`, and on Windows is `["cmd", "/S", "/C"]`. The SHELL instruction must be written in JSON form in a Dockerfile.

- The SHELL instruction is particularly useful on Windows where there are two commonly used and quite different native shells: cmd and powershell, as well as alternate shells available including sh.

- The SHELL instruction can appear multiple times. Each SHELL instruction overrides all previous SHELL instructions, and affects all subsequent instructions. 

3- Create the Dockerfile with instruction. <br>
```
FROM windowsservercore

# Executed as cmd /S /C echo default
RUN echo default

# Executed as cmd /S /C powershell -command Write-Host default
RUN powershell -command Write-Host default

# Executed as powershell -command Write-Host hello
SHELL ["powershell", "-command"]
RUN Write-Host hello

# Executed as cmd /S /C echo hello
SHELL ["cmd", "/S"", "/C"]
RUN echo hello
```

- The following instructions can be affected by the `SHELL` instruction when the shell form of them is used in a Dockerfile: 
RUN, CMD and ENTRYPOINT.

The following example is a common pattern found on Windows which can be streamlined by using the SHELL instruction:

```

RUN powershell -command Execute-MyCmdlet -param1 "c:\foo.txt"

```

The command invoked by docker will be:

```

cmd /S /C powershell -command Execute-MyCmdlet -param1 "c:\foo.txt"

```
- This is inefficient for two reasons. First, there is an un-necessary cmd.exe command processor (aka shell) being invoked.
Second, each RUN instruction in the shell form requires an extra powershell `-command` prefixing the command.

- To make this more efficient, one of two mechanisms can be employed. One is to use the JSON form of the RUN command such as:

```

RUN ["powershell", "-command", "Execute-MyCmdlet", "-param1 \"c:\\foo.txt\""]

```

While the JSON form is unambiguous and does not use the un-necessary cmd.exe, it does require more verbosity 
through double-quoting and escaping. The alternate mechanism is to use the SHELL instruction and the shell form, 
making a more natural syntax for Windows users, especially when combined with the escape parser directive:

```
# escape=`

FROM windowsservercore
SHELL ["powershell","-command"]
RUN New-Item -ItemType Directory C:\Example
ADD Execute-MyCmdlet.ps1 c:\example\
RUN c:\example\Execute-MyCmdlet -sample 'hello world'

```
5. output 


```
PS E:\docker\build\shell> docker build -t shell .
Sending build context to Docker daemon 3.584 kB
Step 1 : FROM windowsservercore
 ---> 5bc36a335344
Step 2 : SHELL powershell -command
 ---> Running in 87d7a64c9751
 ---> 4327358436c1
Removing intermediate container 87d7a64c9751
Step 3 : RUN New-Item -ItemType Directory C:\Example
 ---> Running in 3e6ba16b8df9


Directory: C:\


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----         6/2/2016   2:59 PM                Example


 ---> 1f1dfdcec085
Removing intermediate container 3e6ba16b8df9
Step 4 : ADD Execute-MyCmdlet.ps1 c:\example\
 ---> 6770b4c17f29
Removing intermediate container b139e34291dc
Step 5 : RUN c:\example\Execute-MyCmdlet -sample 'hello world'
 ---> Running in abdcf50dfd1f
Hello from Execute-MyCmdlet.ps1 - passed hello world
 ---> ba0e25255fda
Removing intermediate container abdcf50dfd1f
Successfully built ba0e25255fda
PS E:\docker\build\shell>


```
- The SHELL instruction could also be used to modify the way in which a shell operates. For example,
using `SHELL cmd /S /C /V:ON|OFF` on Windows, delayed environment variable expansion semantics could be modified.
- The `SHELL` instruction can also be used on Linux should an alternate shell be required such zsh, csh, tcsh and others.
- The `SHELL` feature was added in Docker 1.12.




Next >> [Lab #16: Entrypoint Vs RUN](https://dockerlabs.collabnix.com/beginners/dockerfile/entrypoint-vs-run.html)
