# How to install Docker 18.09.1 on Raspberry Pi 3



##  Flash Raspbian OS on SD card


## Booting up Raspbian OS

### Enable SSH to perform remote login



```
[Captains-Bay]🚩 >  ssh pi@192.168.1.5
pi@192.168.1.5's password:
Linux raspberrypi 4.14.98-v7+ #1200 SMP Tue Feb 12 20:27:48 GMT 2019 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Tue Feb 26 12:30:00 2019 from 192.168.1.4
pi@raspberrypi:~ $ sudo su
root@raspberrypi:/home/pi# cd
```

## Verifying Raspbian OS Version


```
root@raspberrypi:~# cat /etc/os-release
PRETTY_NAME="Raspbian GNU/Linux 9 (stretch)"
NAME="Raspbian GNU/Linux"
VERSION_ID="9"
VERSION="9 (stretch)"
ID=raspbian
ID_LIKE=debian
HOME_URL="http://www.raspbian.org/"
SUPPORT_URL="http://www.raspbian.org/RaspbianForums"
BUG_REPORT_URL="http://www.raspbian.org/RaspbianBugs"
root@raspberrypi:~#
```

