# Docker Desktop for Mac Cheat Sheet

## How to restart Docker Desktop from the Command Line

```
curl -X POST -H 'Content-Type: application/json' -d '{ "openContainerView": true }' -kiv --unix-socket ~/Library/Containers/com.docker.docker/Data/backend.sock http://localhost/engine/restart
```

The command you provided is used to restart the Docker daemon on a Mac using the Unix socket file ~/Library/Containers/com.docker.docker/Data/backend.sock.

Here's a breakdown of the command:

- curl is a command-line tool for transferring data over a network.
- -X POST specifies the HTTP request method to use, in this case, POST.
- -H 'Content-Type: application/json' sets the Content-Type header to application/json, indicating that the request body contains JSON data.
- -d '{ "openContainerView": true }' sets the request body to a JSON object containing the key-value pair "openContainerView": true.
- -kiv enables verbose output, tells curl to ignore SSL certificate errors, and makes the output more readable by showing the progress meter.
- --unix-socket specifies the path to the Unix socket file to use for the connection.
- http://localhost/engine/restart is the URL of the REST endpoint to send the request to.

This command sends a POST request to the /engine/restart endpoint on the Docker daemon, with a JSON body containing the key-value pair "openContainerView": true. This will cause the Docker daemon to restart, which will stop all containers and restart them after the daemon has restarted.

Note that this command will only work if you have the Docker command-line interface (CLI) installed and configured on your system, and if the Unix socket file specified in the command exists on your system. If you do not have the Docker CLI installed, you can install it by following the instructions in the Docker documentation.
