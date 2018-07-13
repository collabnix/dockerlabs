# How to use Terraform to build Nginx Docker Container running on Docker for Mac 18.05


## Installing Terraform on macOS

```
brew install terraform
```
```
==> Downloading https://homebrew.bintray.com/bottles/terraform-0.11.7.high_sierr
######################################################################## 100.0%
==> Pouring terraform-0.11.7.high_sierra.bottle.tar.gz
🍺  /usr/local/Cellar/terraform/0.11.7: 6 files, 80.2MB
```

## Verifying Terraform Version

```
[Captains-Bay]🚩 >  terraform version
Terraform v0.11.7
```

## Initializing Terraform

```
[Captains-Bay]🚩 >  terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "docker" (1.0.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.docker: version = "~> 1.0"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[Captains-Bay]🚩 >
```

##

```
[Captains-Bay]🚩 >  terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + docker_container.nginx
      id:                        <computed>
      bridge:                    <computed>
      gateway:                   <computed>
      image:                     "${docker_image.nginx.latest}"
      ip_address:                <computed>
      ip_prefix_length:          <computed>
      log_driver:                "json-file"
      must_run:                  "true"
      name:                      "mynginx"
      ports.#:                   "1"
      ports.4028926921.external: "80"
      ports.4028926921.internal: "80"
      ports.4028926921.ip:       ""
      ports.4028926921.protocol: "tcp"
      restart:                   "no"

  + docker_image.nginx
      id:                        <computed>
      latest:                    <computed>
      name:                      "nginx:latest"


Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

[Captains-Bay]🚩 >
```

##

```
[Captains-Bay]🚩 >  terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + docker_container.nginx
      id:                        <computed>
      bridge:                    <computed>
      gateway:                   <computed>
      image:                     "${docker_image.nginx.latest}"
      ip_address:                <computed>
      ip_prefix_length:          <computed>
      log_driver:                "json-file"
      must_run:                  "true"
      name:                      "mynginx"
      ports.#:                   "1"
      ports.4028926921.external: "84"
      ports.4028926921.internal: "80"
      ports.4028926921.ip:       ""
      ports.4028926921.protocol: "tcp"
      restart:                   "no"

  + docker_image.nginx
      id:                        <computed>
      latest:                    <computed>
      name:                      "nginx:latest"


Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.
```

Type "yes" and then you will see the below output:

```
 Enter a value: yes

docker_image.nginx: Creating...
  latest: "" => "<computed>"
  name:   "" => "nginx:latest"
docker_image.nginx: Still creating... (10s elapsed)
docker_image.nginx: Still creating... (20s elapsed)
docker_image.nginx: Still creating... (30s elapsed)
docker_image.nginx: Creation complete after 36s (ID: sha256:3c5a051232223f9ccf4a604d611696e9...8c9e567d3ecd2af881c9f93101nginx:latest)
docker_container.nginx: Creating...
  bridge:                    "" => "<computed>"
  gateway:                   "" => "<computed>"
  image:                     "" => "sha256:3c5a051232223f9ccf4a604d611696e98392648c9e567d3ecd2af881c9f93101"
  ip_address:                "" => "<computed>"
  ip_prefix_length:          "" => "<computed>"
  log_driver:                "" => "json-file"
  must_run:                  "" => "true"
  name:                      "" => "mynginx"
  ports.#:                   "" => "1"
  ports.3418040461.external: "" => "84"
  ports.3418040461.internal: "" => "80"
  ports.3418040461.ip:       "" => ""
  ports.3418040461.protocol: "" => "tcp"
  restart:                   "" => "no"
docker_container.nginx: Creation complete after 0s (ID: c0a71d28b97e41a2c38a4cf976d506609a130e0afd3ca41aed54da76da6c1986)

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
[Captains-Bay]🚩 >
```

## Verifying

```
[Captains-Bay]🚩 >  curl localhost:84
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
[Captains-Bay]🚩 >
```
