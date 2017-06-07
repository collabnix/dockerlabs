### Getting started with GITHUB




<h1>Step:1 : Clone the Repository</h1>


```
$git clone https://github.com/preetk/docker101
```

The whole repository gets dumped to your local machine.

Say, you want to add some files - a1, a2 and a3


```
$cd docker101
$echo "I am a1" >> a1 
$echo "I am a2" >> a2 
$echo "I am a3" >> a3
```

Now you want to push it to github. Before pushing it, you need to authenticate to GITHUB:

```
git config --global user.email "you@gmail.com"
git config --global user.name "Your Name"
```

In my case, it is:

```
# git config --global user.email "ajeetraina@gmail.com"
# git config --global user.name "ajeet"
```

Follow the steps:

```
$git add .
$git commit -m "Added a1 a2 a3"
```

Output:

```
git commit -m "Added a1 a2 a3"
[master 2bc6e75] Added a1 a2 a3
 3 files changed, 3 insertions(+)
 create mode 100644 play-with-docker/test/a1
 create mode 100644 play-with-docker/test/a2
 create mode 100644 play-with-docker/test/a3
root@ubuntu-16-10:~/project1/docker101/play-with-docker/test#

# git push
Username for 'https://github.com': ajeetraina@gmail.com
Password for 'https://ajeetraina@gmail.com@github.com':
Counting objects: 7, done.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (7/7), 481 bytes | 0 bytes/s, done.
Total 7 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/ajeetraina/docker101
   8f89e98..2bc6e75  master -> master
   ```
   
