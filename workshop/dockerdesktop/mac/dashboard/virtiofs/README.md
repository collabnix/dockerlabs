
# Overview of VirtioFS - File Sharing Implementation for your Containers


VirtioFS brings improved I/O performance for operations on bind mounts. Enabling VirtioFS will automatically enable Virtualization framework. Available in macOS 12.5 and above.


<img width="1269" alt="image" src="https://user-images.githubusercontent.com/313480/209800310-d1c52f13-7f74-40c9-8e6b-6128dfeef266.png">


Developers now have the option of using a new experimental file sharing implementation called virtiofs (the current default is gRPC-FUSE). 
Secondly, improvements have been made to the way that files are synced between the macOS host and Docker VM. 
During testing with our amazing macOS community of users, we have observed that these changes have reduced the time taken to complete filesystem operations by up to 98%.

For developers, these incredible gains in speed mean less time waiting for filesystem operations to complete (or building project-specific workarounds 
to improve performance) and more time focusing on innovation!

## Understanding common developer workflows

A common developer workflow when using technologies like Symfony or React is to edit source code located on the macOS host while running the app itself in a Docker container. The source code is shared between the host and the container by using Docker volumes, with a command like the following:

```
docker run -v /Users/me:/code -p 8080:8080 my-symfony-app
```

This allows the developer to edit their source code, save the changes and immediately see the results in their browser. 
Changes made to files located on the host system must propagate quickly and reliably to the container file system for the developer to optimize productivity and have a good user experience. This is where file sharing performance is absolutely critical.

## Big performance improvements

Performance is vital when application source code is shared between the host and container. 
For example when a developer uses the [Symfony PHP framework](https://symfony.com/), edits the source code and then reloads the page in the browser, the web-server in the container must re-read many PHP files stored on the host. When considering that modern dependency management can easily bring 10k – 100k files into a project (which linearly increases the performance penalty), this can result in poor performance as the host and container keep in sync via the volume.

The recent changes to Docker Desktop for Mac, including the usage of virtiofs, alleviate this problem and bring drastic improvements to file system performance. Specifically, developers working with an early preview of Docker Desktop 4.6 with virtiofs enabled and changes to file syncing included have observed:

- A 90% improvement in the time taken to complete a [284MB MySQL import](https://github.com/docker/roadmap/issues/7#issuecomment-1045986171) (3m 16s to 18s)
- An 87% improvement in the time taken to [run ‘composer install’ in a large codebase](https://github.com/docker/roadmap/issues/7#issuecomment-1067941403) (1m 27s to 11s)
- An 80% improvement in the time taken to boot [a monolithic Typescript app](https://github.com/docker/roadmap/issues/7#issuecomment-1063124441) (1m 30s to 18s)

And here are some of the comments we’ve heard from users:

“This works great on my mac mini M1!, running migrations on my laravel instance is now instant…instead of running for minutes.” (Source: Github user feedback)
“My development setup is ridiculously fast now. Thanks everyone!” (Source: Github user feedback)
“Looking forward to seeing this enhancement land in a released build. It was like night and day! 🙌.” (Source: Github user feedback)

## How to enable virtiofs

Virtiofs is only available to users of the following macOS versions:

- macOS 12.2 and above (for Apple Silicon)
- macOS 12.3 and above (for Intel)

To enable virtiofs in Docker Desktop:

- Ensure that you are using Docker Desktop version 4.6
- Navigate to ‘Preferences’ (the gear icon) > ‘Experimental Features’
- Select the ‘Use the new Virtualization framework’ and ‘Enable VirtioFS accelerated directory sharing’ toggles
- Click ‘Apply & Restart’

