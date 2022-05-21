# Building Docker Image using Docker assemble

```
[Captains-Bay]🚩 >  docker assemble

Usage:	docker assemble [OPTIONS] COMMAND

assemble is a high-level build tool

Options:
      --addr string   backend address (default
                      "docker-container://docker-assemble-backend-ajeetraina")

Management Commands:
  backend     Manage build backend service

Commands:
  build       Build a project into a container
  version     Print the version number of docker assemble

Run 'docker assemble COMMAND --help' for more information on a command.
```

## Run the Docker Asseble Backend

```
[Captains-Bay]🚩 >  clear

[Captains-Bay]🚩 >  docker assemble backend start
Pulling image docker/assemble-backend@sha256:acdf5453584e25aa344c2e6613394ca6791Pulling image docker/assemble-backend@sha256:acdf5453584e25aa344c2e6613394ca6791Pulling image docker/assemble-backend@sha256:acdf5453584e25aa344c2e6613394ca6791Pulling image docker/assemble-backend@sha256:acdf5453584e25aa344c2e6613394ca6791Pulling image docker/assemble-backend@sha256:acdf5453584e25aa344c2e6613394ca6791Pulling image docker/assemble-backend@sha256:acdf5453584e25aa344c2e6613394ca6791Pulling image docker/assemble-backend@sha256:acdf5453584e25aa344c2e6613394ca6791

Pulling image alpine/socat@sha256:5f245d7a2d63fccdb098834d00d9fb04c404a3f1423eb2f84045fc00e93d7c32: Success
Started backend container "docker-assemble-backend-ajeetraina" (4be3be815999)
Started backend → host port 5000 proxy container "docker-assemble-backend-ajeetraina-proxy-port-5000" (c0329f7fe112)

```

## Clone the Repository

```
[Captains-Bay]🚩 >  git clone https://github.com/anokun7/docker-springframework
Cloning into 'docker-springframework'...
remote: Enumerating objects: 86, done.
remote: Total 86 (delta 0), reused 0 (delta 0), pack-reused 86
Unpacking objects: 100% (86/86), done.

[Captains-Bay]🚩 >  cd docker-springframework/
[Captains-Bay]🚩 >  

```

```
[Captains-Bay]🚩 >  git rm Dockerfile
rm 'Dockerfile'
```

```
[Captains-Bay]🚩 >  git rm Dockerfile*
rm 'Dockerfile.maven'
```

```
[Captains-Bay]🚩 >  git commit -a -m "Sy Bye to Dockerfiles"
[master 3c716f0] Sy Bye to Dockerfiles
 2 files changed, 8 deletions(-)
 delete mode 100644 Dockerfile
 delete mode 100644 Dockerfile.maven
[Captains-Bay]🚩 > 
```

## Building using docker assemble

```
bash-3.2$ docker assemble build docker-springframework
[+] Building 1734.9s (13/15)                                                    
[+] Building 1735.1s (13/15)                                                    
[+] Building 1736.9s (13/15)                                                    
[+] Building 1738.3s (13/15)                                                    
[+] Building 1738.5s (13/15)                                                    
[+] Building 1738.7s (13/15)                                                    
[+] Building 1953.5s (22/22) FINISHED                                           
 => local://project (docker-assemble.yaml)                                 0.0s
 => => transferring project: 2B                                            0.0s
 => local://project (*.[fc]sproj)                                          0.0s
 => => transferring project: 2B                                            0.0s
 => local://project (pom.xml)                                              0.0s
 => => transferring project: 1.14kB                                        0.0s
 => resolve image config for docker.io/library/maven:3-jdk-8-alpine       10.6s
 => resolve image config for docker.io/docker/dockerfile-copy:v0.1.8@sha2  0.0s
 => resolve image config for docker.io/library/openjdk:8-jre-alpine        3.4s
 => build image                                                         1234.1s
 => => resolve docker.io/library/maven:3-jdk-8-alpine@sha256:16691dc7e18e  0.0s
 => => sha256:b3fdc3f660bf7e77fbc46bb310626d68533af00e0a7f3e0 358B / 358B  3.7s
 => => sha256:f910a506b6cb1dbec766725d70356f695ae2bf2bea6224 238B / 238B  11.0s
 => => sha256:16691dc7e18e5311ee7ae38b40dcf98ee1cfe4a487f 1.65kB / 1.65kB  0.0s
 => => sha256:008aeef593f3af886e6a096c7930c9ac463c5c5f7f1 1.78kB / 1.78kB  0.0s
 => => sha256:7445f83cd169b9f0b185e443e755ece1e37d3cf1e2e 6.13kB / 6.13kB  0.0s
 => => sha256:e7c96db7181be991f19a9fb6975cdbbd73c65f4a2 2.76MB / 2.76MB  164.5s
 => => sha256:c2274a1a0e2786ee9101b08f76111f9ab8019e 70.73MB / 70.73MB  1231.0s
 => => sha256:e4ef40f7698347c89ee64b2e5c237d214cae777f3 2.18MB / 2.18MB  143.8s
 => => sha256:9d14ff8d6dec99f79d9b35fb7f1f20241e3381c6f 9.16MB / 9.16MB  339.2s
 => => sha256:35df3984e88492fee07786421722d9564cdde74b02bea9e 856B / 856B  7.5s
 => => unpacking docker.io/library/maven:3-jdk-8-alpine@sha256:16691dc7e1  2.9s
 => copy helper image                                                     61.5s
 => => resolve docker.io/docker/dockerfile-copy:v0.1.8@sha256:b9485cc85d7  0.0s
 => => sha256:b9485cc85d79d69255d6cc42d26935e52580a868bb4 2.03kB / 2.03kB  0.0s
 => => sha256:ef4fa6611214cc62ebdd34dfdd0d8a881da9c76fc12dab0 736B / 736B  0.0s
 => => sha256:58a96f4aaf8be49f149869a3d2e15eb551826c383bcd509 766B / 766B  0.0s
 => => sha256:9321446b57a04a1fdc95092d074dfe428ff8d4 898.21kB / 898.21kB  61.1s
 => => sha256:a7fed83e5b578c4d9c89d4765e5cec2a0d3a1f 860.18kB / 860.18kB  55.9s
 => => unpacking docker.io/docker/dockerfile-copy:v0.1.8@sha256:b9485cc85  0.2s
 => runtime image                                                       1113.5s
 => => resolve docker.io/library/openjdk:8-jre-alpine@sha256:f362b165b870  0.0s
 => => sha256:f362b165b870ef129cbe730f29065ff37399c0aa8bc 1.64kB / 1.64kB  0.0s
 => => sha256:b2ad93b079b1495488cc01375de799c402d45086015a120 947B / 947B  0.0s
 => => sha256:e7c96db7181be991f19a9fb6975cdbbd73c65f4a2 2.76MB / 2.76MB  164.3s
 => => sha256:f7a292bbb70c4ce57f7704cc03eb09e299de9da1901 3.42kB / 3.42kB  0.0s
 => => sha256:f910a506b6cb1dbec766725d70356f695ae2bf2bea6224 238B / 238B  10.8s
 => => sha256:b6abafe80f63b02535fc111df2ed6b3c728469 54.94MB / 54.94MB  1111.2s
 => => unpacking docker.io/library/openjdk:8-jre-alpine@sha256:f362b165b8  2.0s
 => local://project                                                        0.1s
 => => transferring project: 52.87kB                                       0.1s
 => copy pom.xml to build container                                        0.4s
 => mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml depen  455.9s
 => copy project source to build container                                 0.5s
 => mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml packa  230.2s
 => copy hello-boot-1.jar to runtime container                             0.5s
 => collecting runtime image command info: java -version                   1.0s
 => listing Alpine packages                                                0.8s
 => collecting build image command info: mvn -v                            1.2s
 => collecting build image command info: java -version                     1.0s
 => listing Alpine packages                                                0.8s
 => listing Maven packages                                                 0.8s
 => exporting to oci image format                                          6.3s
 => => exporting layers                                                    1.6s
 => => exporting manifest sha256:e8244ed92bcdfbad88ea822d775b55d5760b2a4f  0.0s
 => => exporting config sha256:20ad09f4f17375aaa4c1c1d3f65d873e4ddbe1d0ff  0.0s
 => => sending tarball                                                     4.6s
Successfully built: docker.io/library/hello-boot:1
```

## Verifying if Docker Images are created

```
bash-3.2$ docker image ls | head -n 2
REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
hello-boot                1                   20ad09f4f173        14 minutes ago      99.3MB
bash-3.2$ 
```

##

```
bash-3.2$ docker run -d --rm -p 8080:8080 hello-boot:1

7da583bcc9e5afb09b851f6c9b12308f393bbf10ec6bd1fb779e4a0d195d6404
```

```
bash-3.2$ curl localhost:8080
Hello from 7da583bcc9e5
bash-3.2$ 
```

##

```
bash-3.2$ docker logs -f 7da

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v1.5.2.RELEASE)

2019-06-08 14:22:11.020  INFO 1 --- [           main] hello.Application                        : Starting Application v1 on 7da583bcc9e5 with PID 1 (/hello-boot-1.jar started by root in /)
2019-06-08 14:22:11.029  INFO 1 --- [           main] hello.Application                        : No active profile set, falling back to default profiles: default
2019-06-08 14:22:11.226  INFO 1 --- [           main] ationConfigEmbeddedWebApplicationContext : Refreshing org.springframework.boot.context.embedded.AnnotationConfigEmbeddedWebApplicationContext@579bb367: startup date [Sat Jun 08 14:22:11 GMT 2019]; root of context hierarchy
2019-06-08 14:22:14.133  INFO 1 --- [           main] s.b.c.e.t.TomcatEmbeddedServletContainer : Tomcat initialized with port(s): 8080 (http)
2019-06-08 14:22:14.160  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service Tomcat
2019-06-08 14:22:14.162  INFO 1 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet Engine: Apache Tomcat/8.5.11
2019-06-08 14:22:14.315  INFO 1 --- [ost-startStop-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2019-06-08 14:22:14.316  INFO 1 --- [ost-startStop-1] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 3107 ms
2019-06-08 14:22:14.525  INFO 1 --- [ost-startStop-1] o.s.b.w.servlet.ServletRegistrationBean  : Mapping servlet: 'dispatcherServlet' to [/]
2019-06-08 14:22:14.533  INFO 1 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'characterEncodingFilter' to: [/*]
2019-06-08 14:22:14.534  INFO 1 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'hiddenHttpMethodFilter' to: [/*]
2019-06-08 14:22:14.535  INFO 1 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'httpPutFormContentFilter' to: [/*]
2019-06-08 14:22:14.535  INFO 1 --- [ost-startStop-1] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'requestContextFilter' to: [/*]
2019-06-08 14:22:15.000  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerAdapter : Looking for @ControllerAdvice: org.springframework.boot.context.embedded.AnnotationConfigEmbeddedWebApplicationContext@579bb367: startup date [Sat Jun 08 14:22:11 GMT 2019]; root of context hierarchy
2019-06-08 14:22:15.186  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/]}" onto public java.lang.String hello.HelloController.index()
2019-06-08 14:22:15.193  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/error],produces=[text/html]}" onto public org.springframework.web.servlet.ModelAndView org.springframework.boot.autoconfigure.web.BasicErrorController.errorHtml(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)
2019-06-08 14:22:15.194  INFO 1 --- [           main] s.w.s.m.m.a.RequestMappingHandlerMapping : Mapped "{[/error]}" onto public org.springframework.http.ResponseEntity<java.util.Map<java.lang.String, java.lang.Object>> org.springframework.boot.autoconfigure.web.BasicErrorController.error(javax.servlet.http.HttpServletRequest)
2019-06-08 14:22:15.242  INFO 1 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Mapped URL path [/webjars/**] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
2019-06-08 14:22:15.243  INFO 1 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Mapped URL path [/**] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
2019-06-08 14:22:15.304  INFO 1 --- [           main] o.s.w.s.handler.SimpleUrlHandlerMapping  : Mapped URL path [/**/favicon.ico] onto handler of type [class org.springframework.web.servlet.resource.ResourceHttpRequestHandler]
2019-06-08 14:22:15.518  INFO 1 --- [           main] o.s.j.e.a.AnnotationMBeanExporter        : Registering beans for JMX exposure on startup
2019-06-08 14:22:15.608  INFO 1 --- [           main] s.b.c.e.t.TomcatEmbeddedServletContainer : Tomcat started on port(s): 8080 (http)
2019-06-08 14:22:15.615  INFO 1 --- [           main] hello.Application                        : Started Application in 5.304 seconds (JVM running for 6.133)
2019-06-08 14:22:18.066  INFO 1 --- [nio-8080-exec-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring FrameworkServlet 'dispatcherServlet'
2019-06-08 14:22:18.066  INFO 1 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : FrameworkServlet 'dispatcherServlet': initialization started
2019-06-08 14:22:18.092  INFO 1 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : FrameworkServlet 'dispatcherServlet': initialization completed in 26 ms

```
