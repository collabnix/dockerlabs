# The docker run CLI comes with --init and --init-path options. What is it

## Have you heard about Tini

Tini is the simplest init you could think of. All Tini does is spawn a single child(Tini is meant to be run in a container), and wait for it to exit all the while reaping zombies and performing signal forwarding.

## Why Tini

Using Tini has several benefits:

- It protects you from software that accidentally creates zombie processes, which can(over time!) starve your entire system for PIDs(and make it unusable).
- It ensures that the default signal handlers work for the software you run in your Docker image. For example, with Tini, SIGTERM properly terminates your process even if you didn't explicitly install a signal handler for it.
- It does so completely transparently! Docker images that work without Tini will work with Tini without any changes.
- If you'd like more detail on why this is useful, review this issue discussion: [What is advantage of Tini?](https://github.com/krallin/tini/issues/8)

## Using Tini

> NOTE: If you are using Docker 1.13 or greater, Tini is included in Docker itself. This includes all versions of Docker CE. To enable Tini, just pass the --init flag to docker run.

> NOTE: There are pre-built Docker images available for Tini. If you're currently using an Ubuntu or CentOS image as your base, you can use one of those as a drop-in replacement.

> NOTE: There are Tini packages for Alpine Linux and NixOS. See below for installation instructions.

Add Tini to your container, and make it executable. Then, just invoke Tini and pass your program and its arguments as arguments to Tini.

In Docker, you will want to use an entrypoint so you don't have to remember to manually invoke Tini:

### Wait ! Wait ! Wait... Why are you talking about this

Good Question!

Let's talk a little bit about Docker. When you run a Docker container, Docker proceeds to isolate it from the rest of the system.
That isolation happens at different levels(e.g. network, filesystem, processes). Tini isn't really concerned with the network or the filesystem, so let's focus on what matters in the context of Tini: `processes`.

Each Docker container is a PID namespace, which means that the processes in your container are isolated from other processes on your host. A PID namespace is a tree, which starts at PID 1, which is commonly called init.

> Note: When you run a Docker container, PID 1 is whatever you set as your ENTRYPOINT(or if you don't have one, then it's either your shell or another program, depending on the format of your CMD)

Now, unlike other processes, PID 1 has a unique responsibility, which is to reap zombie processes.

Zombie processes are processes that:

- Have exited
- Were not waited on by their parent process(wait is the syscall parent processes use to retrieve the exit code of their children), have lost their parent (i.e. their parent exited as well), which means they'll never be waited on by their parent.
- When a zombie is created(i.e. which happens when its parent exits, and therefore all chances of it ever being waited by it are gone), it is reparent to init, which is expected to reap it(which means calling wait on it).

In other words, someone has to clean up after "irresponsible" parents that leave their children un-wait'ed, and that's PID 1's job.

That's what Tini does, and is something the JVM(which is what runs when you do exec java...) does not do, which his why you don't want to run Jenkins as PID 1.

> Note that creating zombies is usually frowned upon in the first place(i.e. ideally you should be fixing your code so it doesn't create zombies), but for something like Jenkins, they're unavoidable: since Jenkins usually runs code that isn't written by the Jenkins maintainers(i.e. your build scripts), they can't "fix the code". This is why Jenkins uses Tini: to clean up after build scripts that create zombies.

_Now, Bash actually does the same thing(reaping zombies), so you're probably wondering: why not use Bash as PID 1?_

One problem is, if you run Bash as PID 1, then all signals you send to your Docker container(e.g. using docker stop or docker kill) end up sent to Bash, which does not forward them anywhere(unless you code it yourself). In other words, if you use Bash to run Jenkins, and then run docker stop, then Jenkins will never see the stop command!

Tini fixes by "forwarding signals": if you send a signal to Tini, then it sends that same signal to your child process(Jenkins in your case).

A second problem is that once your process has exited, Bash will proceed to exit as well. If you're not being careful, Bash might exit with exit code 0, whereas your process actually crashed(0 means "all fine"; this would cause Docker restart policies to not do what you expect). What you actually want is for Bash to return the same exit code your process had.

> Note that you can address this by creating signal handlers in Bash to actually do the forwarding, and returning a proper exit code. On the other hand that's more work, whereas adding Tini is a few lines in your Dockerfile.

_Now, there would be another solution, which would be to add e.g. another thread in Jenkins to reap zombies, and run Jenkins as PID 1._

This isn't ideal either, for two reasons:

- First, if Jenkins runs as PID 1, then it's difficult to differentiate between process that were re-parented to Jenkins(which should be reaped), and processes that were spawned by Jenkins(which shouldn't, because there's other code that's already expecting to wait them). I'm sure you could solve that in code, but again: why write it when you can just drop Tini in?
- Second, if Jenkins runs as PID 1, then it may not receive the signals you send it!

That's a subtlety in PID 1. Unlike other unlike processes, PID 1 does not have default signal handlers, which means that if Jenkins hasn't explicitly installed a signal handler for SIGTERM, then that signal is going to be discarded when it's sent(whereas the default behavior would have been to terminate the process).
Tini does install explicit signal handlers(to forward them, incidentally), so those signals no longer get dropped. Instead, they're sent to Jenkins, which is not running as PID 1(Tini is), and therefore has default signal handlers(note: this is not the reason why Jenkins uses Tini, they use it for signal reaping, but it was used in the RabbitMQ image for that reason).

> Note that there are also a few extras in Tini, which would be harder to reproduce in Bash or Java(e.g. Tini can register as a subreaper so it doesn't actually need to run as PID 1 to do its zombie-reaping job), but those are mostly useful for specialist use cases.

Hope this helps!

Here are some references you might be interested in to learn more about that topic:

More about zombies:

- [Docker and the pid 1 zombie reaping problem](https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/)

- [A more succinct explanation](https://github.com/docker-library/official-images#init)

Finally, do note that there are alternatives to Tini (like **Phusion's base image**).

Tini differentiates with:

Doing everything PID 1 needs to do and nothing else. Things like reading environment files, changing users, process supervision are out of scope for Tini(there are other, better tools for those). It requires zero configuration to do its job properly(Tini >= 0.6 will also warn you if you're not running it properly). It's got a lot of tests.

Let's see it in action -

Without init, CMD becomes pid 1. In this case, `/bin/bash`

```docker
$ docker run -ti --rm ubuntu:16.04 /bin/bash
root@e166034a9571:/# ps -fA
UID         PID   PPID  C STIME TTY          TIME CMD
root          1      0  0 13:26 pts/0    00:00:00 /bin/bash
root         11      1  0 1
```

With --init, tini(/dev/init) becomes pid 1

```docker
$ docker run -ti --init --rm ubuntu:16.04 /bin/bash
root@d20fb387ca64:/# ps -aF
UID         PID   PPID  C    SZ   RSS PSR STIME TTY          TIME CMD
root          7      1  0  4558  3300   5 13:23 pts/0    00:00:00 /bin/bash
root         12      7  0  8605  2860   0 13:23 pts/0    00:00:00 ps -aF
root@d20fb387ca64:/# ps -fA
UID         PID   PPID  C STIME TTY          TIME CMD
root          1      0  0 13:23 pts/0    00:00:00 /dev/init -- /bin/bash
root          7      1  0 13:23 pts/0    00:00:00 /bin/bash
root         13      7  0 13:24 pts/0    00:00:00 ps -fA
root@d20fb387ca64:/#
```
