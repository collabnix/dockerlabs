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

Ensure that you clone this repository so as to get access to main.tf under this repository.

The content of main.tf looks like as shown below:

```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```

Run the below CLI:

```
 terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of kreuzwerker/docker from the dependency lock file
- Using previously-installed kreuzwerker/docker v2.13.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
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
 terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach           = false
      + bridge           = (known after apply)
      + command          = (known after apply)
      + container_logs   = (known after apply)
      + entrypoint       = (known after apply)
      + env              = (known after apply)
      + exit_code        = (known after apply)
      + gateway          = (known after apply)
      + hostname         = (known after apply)
      + id               = (known after apply)
      + image            = (known after apply)
      + init             = (known after apply)
      + ip_address       = (known after apply)
      + ip_prefix_length = (known after apply)
      + ipc_mode         = (known after apply)
      + log_driver       = "json-file"
      + logs             = false
      + must_run         = true
      + name             = "tutorial"
      + network_data     = (known after apply)
      + read_only        = false
      + remove_volumes   = true
      + restart          = "no"
      + rm               = false
      + security_opts    = (known after apply)
      + shm_size         = (known after apply)
      + start            = true
      + stdin_open       = false
      + tty              = false

      + healthcheck {
          + interval     = (known after apply)
          + retries      = (known after apply)
          + start_period = (known after apply)
          + test         = (known after apply)
          + timeout      = (known after apply)
        }

      + labels {
          + label = (known after apply)
          + value = (known after apply)
        }

      + ports {
          + external = 8000
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id           = (known after apply)
      + keep_locally = false
      + latest       = (known after apply)
      + name         = "nginx:latest"
      + output       = (known after apply)
      + repo_digest  = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_image.nginx: Creating...
docker_image.nginx: Creation complete after 0s [id=sha256:4cdc5dd7eaadff5080649e8d0014f2f8d36d4ddf2eff2fdf577dd13da85c5d2fnginx:latest]
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=a9a11bbfc354285374fffd6adc24f85c991ee336cf93c6a7435e589e9d824339]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

## Verifying

```
 curl localhost:8000
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
```
