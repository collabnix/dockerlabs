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

## How to import under Docker SYSCFG Container

```
docker run --privileged -v /mnt:/mnt ajeetraina/dell-syscfg:v1.0 /opt/dell/toolkit/bin/syscfg --ox /mnt/test.txt
```

Please remember that even if /mnt directory is not present on the host and in the container, it will create it.


Alternative Way:

```
docker run --privileged -v /temp:/temp b657 ../bin/syscfg -o /temp/output.txt
```
