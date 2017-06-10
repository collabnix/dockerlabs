## How to Run Dell SYSCFG Inside Docker Container

```
docker run --privileged  ajeetraina/dell-syscfg:v1.0 /opt/dell/toolkit/bin/syscfg --help
```

## How to check CPU Speed using SYSCFG Docker container

```
docker run --privileged  ajeetraina/dell-syscfg:v1.0 /opt/dell/toolkit/bin/syscfg --cpuspeed
```

## How to check Memory using SYSCFG Docker Container


```
docker run --privileged  ajeetraina/dell-syscfg:v1.0 /opt/dell/toolkit/bin/syscfg --mem
```
