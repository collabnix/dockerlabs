# Injecting Files into your Image using ADD

It is the usual requirement of a developer to copy a few files into the docker image so that every container spawned from this image has the required files.

Docker allows us to do this using two isntructions in a Dockerfile: 1) ADD 2) COPY

## ADD instruction

This lets us copy our files/directories from a source (lying on the local filesystem of base system or at a remote site) to the destination filesystem of the image.
For copying files present at some remote site, provide URL in source field. Multiple sources can be specified.

ADD instruction takes the following format:

      ADD [--chown=user:group] (source1) (source2) ... (destination)
OR

      ADD [--chown=user:group] ("source"), ("source2"), ... ("destination")

The second form is preferred when paths contain whitespaces.

The option 'chown' lets us control the user and group for the destination filesystem. This option is applicable only to Linux containers.

If the destination path doesn't exist on the base image, it is created along with all parent directories.

Usage:

```
ADD hello.py /root/home/hello.py
```

#### Pattern Matching in Source Names 

Wildcards are used for creating patterns in source names.

Examples:

```
ADD myfile* /home/       #This would add all files starting with "myfile" - like myfile1.txt, myfile.py, myfilefinal.sh, etc.
```

```
ADD myfile?.txt /home/      #This would match only a single character after "myfile" - like myfile1.txt
```

Wildcard matching rules are in accordance with Go language, the one in which Docker tool was built.

#### Destination paths

Destination can be an absolute path or a path relative to WORKDIR.
 ```
 Note: We can specify a working directory for the image using WORKDIR. 
 This working directory corresponds to instructions like RUN, CMD, ENTRYPOINT, ADD and COPY.
 ```
 
Example:
 
Let the WORKDIR be /home
 
 ```
 ADD test user/   # The file test will be added to /home/user/
 
 ADD test /user/  # The file test will be added to /user/
 ```
 
#### chown flag

This is optional and applies only to Linux containers. In case this flag is not encountered, files/directories added to the image have UID and GID set to 0, that is their owner and group is set to 'root'.

This option can take usernames or groupnames as strings or can even take their respective numeric values as UID or GID.

If groupname is skipped, GID is set same as UID, that is default group of the user specifies is used.

The usernames and the groupnames provided are matched against /etc/passwd and /etc/group files of the container filesystem. So, make sure that you add the necessary users using RUN instruction if they don't exist by default.

If source is some remote URL, default permissions for it are 600.

#### Rule for ADD

1) Source files must be inside the context of the build. This is because the command 'docker build' first provides the context directory to the docker daemon and then initiates the build process.

2) If source is a directory, all its files and metadata is copied to destination, but not the directory itself.

3) If the destination has a trailing slash, it is considered a directory.

4) If the destination does not has a trailing slash, it is considered a file and the source's contents are written on it.

5) In case of multiple sources, provide a directory as a destination (with a trailing slash)

6) In case the source is a local tar archive, it is decompressed and files are copied into the destination directory.

7) Tar archives at remote URL are not decompressed.

8) A source URL must be a non trivial reference to a file. Example: http://www.abc.com/hello.txt is allowed, but http://www.abc.com/ won't work.

9) If STDIN method is used to pass a Dockerfile, there is no build context for this. So, we need to provide a remote URL as a source for this case.



## ADD vs COPY

COPY is another method for performing similar work as ADD and obeys the same rules.

The difference between these two instructions lies as follows:

1) COPY can't take remote URLs as source, whereas ADD can.

2) COPY can't extract a tar file directly into the destination.

Best practice is to use COPY for copying local filesystem's files, an operation which doesn't require the extra magic of ADD.
Also, when you need to keep the tar archive intact, use COPY instead of ADD.

Remote file downloading via ADD is also discouraged in best practices. It is recommended to use curl or wget commands using RUN instruction.

So, preferrably, ADD should be used only for auto-tar extraction capabilities. 
 
