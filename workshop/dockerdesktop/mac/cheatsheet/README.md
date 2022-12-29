# Docker Desktop for Mac Cheat Sheet

## How to restart Docker Desktop from the Command Line

```
curl -X POST -H 'Content-Type: application/json' -d '{ "openContainerView": true }' -kiv --unix-socket ~/Library/Containers/com.docker.docker/Data/backend.sock http://localhost/engine/restart
```
