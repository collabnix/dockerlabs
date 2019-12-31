# Setting up k3sup on macOS to build Kubernetes Cluster remotely on Jetson Nano

# Pre-requisite:

- 2x Jetson Boards 
   - Board1: 192.168.1.7
   - Board2: 192.168.1.8
- Passwordless SSH from macOS

```
[Captains-Bay]🚩 >  ssh jetson@192.168.1.7
Welcome to Ubuntu 18.04.2 LTS (GNU/Linux 4.9.140-tegra aarch64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

191 packages can be updated.
0 updates are security updates.

Last login: Tue Dec 31 11:24:01 2019 from 192.168.1.6
jetson@master1:~$
```
