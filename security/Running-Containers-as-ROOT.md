### Running Docker Containers as ROOT:

One of the best practices while running Docker Container is to run processes with a non-root user. This is because if a user manages to break out of the application running as root in the container, he may gain root user access on host. In addition, configuring container to user unprivileged is the best way yo prevent privilege escalation attacks.


This can be accomplished in different ways:

 - USER instruction in Dockerfile.

Example:
<pre><code>FROM alpine
RUN groupadd -r myuser && useradd -r -g myuser myuser
"HERE DO WHAT YOU HAVE TO DO AS A ROOT USER LIKE INSTALLING PACKAGES ETC."
USER myuser</code></pre>

 - Using -u flag during runtime
This option can be used if the image doesn't have its own user.
Example:
<pre><code>docker run --user 1001 alpine</code></pre>

- Enable USER namespace on the host.
This is the host configuration which enables to run any container as non-root user on the host.
Reference - https://docs.docker.com/engine/security/userns-remap/

### Other References:
- https://docs.docker.com/engine/reference/builder/#user
- https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html
- https://medium.com/@mccode/processes-in-containers-should-not-run-as-root-2feae3f0df3b
- https://americanexpress.io/do-not-run-dockerized-applications-as-root/
- https://engineering.bitnami.com/articles/why-non-root-containers-are-important-for-security.html
- http://www.projectatomic.io/blog/2016/01/how-to-run-a-more-secure-non-root-user-container/
