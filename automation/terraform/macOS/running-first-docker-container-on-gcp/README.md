# Running Your First Docker Container on Google Cloud Platform using Terraform

## Installing Terraform on macOS

```
[Captains-Bay]🚩 >  brew install terraform
Updating Homebrew...
==> Auto-updated Homebrew!
Updated 4 taps (jenkins-x/jx, homebrew/cask-versions, homebrew/core, homebrew/cask).
==> Updated Formulae
agda                globus-toolkit      pango               shibboleth-sp
bacula-fd           hadolint            pdftoedn            subversion
chronograf          jenkins-x/jx/jx     pdftoipe            tkdiff
conan               json-fortran        php@5.6             triton
convox              jsonnet             php@7.0             vdirsyncer
diff-pdf            kitchen-sync        php@7.1             xapian
fdroidserver        libdill             picard-tools        xml-tooling-c
fn                  lmod                poppler
git-annex           pandoc              rust

Warning: terraform 0.11.7 is already installed and up-to-date
To reinstall 0.11.7, run `brew reinstall terraform`
[Captains-Bay]🚩 >
```
## Clone the Repository

```
[Captains-Bay]🚩 >  git clone https://github.com/ajeetraina/docker101
Cloning into 'docker101'...
remote: Counting objects: 5637, done.
remote: Compressing objects: 100% (155/155), done.
remote: Total 5637 (delta 117), reused 114 (delta 57), pack-reused 5422
Receiving objects: 100% (5637/5637), 17.67 MiB | 432.00 KiB/s, done.
Resolving deltas: 100% (1821/1821), done.
[Captains-Bay]🚩 >
```

## Browse to Terraform directory

```
[Captains-Bay]🚩 >  pwd
/Users/ajeetraina/docker101/automation/terraform/googlecloud/building-first-instance
[Captains-Bay]🚩 >  tree
.
├── README.md
├── compute.tf
├── first-docker-container
│   ├── README.md
│   ├── main.tf
│   ├── output.tf
│   ├── terraform-provider-google
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── terraform.tfvars.example
│   └── variables.tf
├── google-compute-firewall.tf
├── provider.tf
└── terraform-account.json

2 directories, 12 files
[Captains-Bay]🚩 >
```

## Understanding TF files


```
provider "google" {
  region      = "${var.region}"
  project     = "${var.project_name}"
  credentials = "${file("${var.credentials_file_path}")}"
}


resource "google_compute_instance" "docker" {
  count = 1

  name         = "tf-docker-${count.index}"
  machine_type = "f1-micro"
  zone         = "${var.region_zone}"
  tags         = ["docker-node"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1404-trusty-v20160602"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral
    }
  }

  metadata {
    ssh-keys = "root:${file("${var.public_key_path}")}"
  }


  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }

    inline = [
      "sudo curl -sSL https://get.docker.com/ | sh",
      "sudo usermod -aG docker `echo $USER`",
      "sudo docker run -d -p 80:80 nginx"
    ]
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
}

resource "google_compute_firewall" "default" {
  name    = "tf-www-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["docker-node"]
}
```


## File: variables.tf


```
[Captains-Bay]🚩 >  cat variables.tf
variable "region" {
  default = "us-central1"
}

variable "region_zone" {
  default = "us-central1-f"
}

variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
  default     = "~/.gcloud/Terraform.json"
}

variable "public_key_path" {
  description = "Path to file containing public key"
  default     = "~/.ssh/gcloud_id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to file containing private key"
  default     = "~/.ssh/gcloud_id_rsa"
}
```

## Generating Key

```
[Captains-Bay]🚩 >  ssh-keygen -f ~/.ssh/gcloud_id_rsa
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/ajeetraina/.ssh/gcloud_id_rsa.
Your public key has been saved in /Users/ajeetraina/.ssh/gcloud_id_rsa.pub.
The key fingerprint is:
SHA256:ebJlwBe0MCFQv49bLHtfXZ2havVf89sulIYE2PDHXBI ajeetraina@Ajeets-MacBook-Air.local
The key's randomart image is:
+---[RSA 2048]----+
|    .oo =*o E..  |
|       +.+o= o   |
|        + +.+  . |
|         = .. . +|
|        S +. + oo|
|         X  + =..|
|        + +o o.oo|
|         =o  .. *|
|        o. ..  +*|
+----[SHA256]-----+
[Captains-Bay]🚩 >
```

##

```
[Captains-Bay]🚩 >  terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "google" (1.16.2)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.google: version = "~> 1.16"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[Captains-Bay]🚩 >
```

## Download Terraform.json Credential File from GCP

```
[Captains-Bay]🚩 >  mkdir ~/.gcloud
[Captains-Bay]🚩 >  cd ~/.gcloud/
[Captains-Bay]🚩 >  vi Terraform.json
[Captains-Bay]🚩 >
```

## Terraform

```
terraform init
```

```
[Captains-Bay]🚩 >  terraform plan
var.project_name
  The ID of the Google Cloud project

  Enter a value: i-guru-209217

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

google_compute_instance.www: Refreshing state... (ID: tf-www-0)
google_compute_firewall.default: Refreshing state... (ID: tf-docker-firewall)

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + google_compute_firewall.default
      id:                                                  <computed>
      allow.#:                                             "1"
      allow.272637744.ports.#:                             "1"
      allow.272637744.ports.0:                             "80"
      allow.272637744.protocol:                            "tcp"
      destination_ranges.#:                                <computed>
      direction:                                           <computed>
      name:                                                "tf-www-firewall"
      network:                                             "default"
      priority:                                            "1000"
      project:                                             <computed>
      self_link:                                           <computed>
      source_ranges.#:                                     "1"
      source_ranges.1080289494:                            "0.0.0.0/0"
      target_tags.#:                                       "1"
      target_tags.1090984259:                              "docker-node"

  + google_compute_instance.docker
      id:                                                  <computed>
      boot_disk.#:                                         "1"
      boot_disk.0.auto_delete:                             "true"
      boot_disk.0.device_name:                             <computed>
      boot_disk.0.disk_encryption_key_sha256:              <computed>
      boot_disk.0.initialize_params.#:                     "1"
      boot_disk.0.initialize_params.0.image:               "ubuntu-os-cloud/ubuntu-1404-trusty-v20160602"
      boot_disk.0.initialize_params.0.size:                <computed>
      boot_disk.0.initialize_params.0.type:                <computed>
      can_ip_forward:                                      "false"
      cpu_platform:                                        <computed>
      create_timeout:                                      "4"
      deletion_protection:                                 "false"
      guest_accelerator.#:                                 <computed>
      instance_id:                                         <computed>
      label_fingerprint:                                   <computed>
      machine_type:                                        "f1-micro"
      metadata.%:                                          "1"
      metadata.ssh-keys:                                   "root:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDW4qyWPIaZg0fu5QMMgVRc96Nv1C2ft2k+cy6bkf0fz5WjZTDWaGRlvkdt7eZqFd5I7C+9frYfwUpBMAJ+lu2nK2xKxTjPUC/PGuhgIVz+AzJX1Rz1RxaOr//xMDvlYDvoQesRO/EMqb31uYPTY/WZVz8k+joj7OMQHkDwZo/Al5a8uSmkHQ6sPQ2mPusT7p7bFfe9M/xQxVBeWtvfAXtXTFRhGecLPByQQ3RogDMO5TvUh3/tURt54OmQNnqzRf36o9Nh69jxhSpbMrRr3ViWZADcyNnD0eECec+1d/3JzbZqoMmUhm5Jpiua+iEPYOj8WbvrU6j4GCuhth0HWSuP ajeetraina@Ajeets-MacBook-Air.local\n"
      metadata_fingerprint:                                <computed>
      name:                                                "tf-docker-0"
      network_interface.#:                                 "1"
      network_interface.0.access_config.#:                 "1"
      network_interface.0.access_config.0.assigned_nat_ip: <computed>
      network_interface.0.access_config.0.nat_ip:          <computed>
      network_interface.0.access_config.0.network_tier:    <computed>
      network_interface.0.address:                         <computed>
      network_interface.0.name:                            <computed>
      network_interface.0.network:                         "default"
      network_interface.0.network_ip:                      <computed>
      network_interface.0.subnetwork_project:              <computed>
      project:                                             <computed>
      scheduling.#:                                        <computed>
      self_link:                                           <computed>
      service_account.#:                                   "1"
      service_account.0.email:                             <computed>
      service_account.0.scopes.#:                          "1"
      service_account.0.scopes.2862113455:                 "https://www.googleapis.com/auth/compute.readonly"
      tags.#:                                              "1"
      tags.1090984259:                                     "docker-node"
      tags_fingerprint:                                    <computed>
      zone:                                                "us-central1-f"


Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```


##

```

google_compute_instance.docker (remote-exec):   Host: 35.226.155.224
google_compute_instance.docker (remote-exec):   User: root
google_compute_instance.docker (remote-exec):   Password: false
google_compute_instance.docker (remote-exec):   Private key: true
google_compute_instance.docker (remote-exec):   SSH Agent: false
google_compute_instance.docker (remote-exec):   Checking Host Key: false
google_compute_instance.docker: Still creating... (40s elapsed)
google_compute_instance.docker (remote-exec): Connected!
google_compute_instance.docker (remote-exec): # Executing docker install script, commit: 36b78b2
google_compute_instance.docker (remote-exec): + sh -c apt-get update -qq >/dev/null
google_compute_instance.docker: Still creating... (50s elapsed)
google_compute_instance.docker: Still creating... (1m0s elapsed)
google_compute_instance.docker (remote-exec): + sh -c apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
google_compute_instance.docker: Still creating... (1m10s elapsed)
google_compute_instance.docker (remote-exec): + sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
google_compute_instance.docker (remote-exec): + sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu trusty edge" > /etc/apt/sources.list.d/docker.list
google_compute_instance.docker (remote-exec): + [ ubuntu = debian ]
google_compute_instance.docker (remote-exec): + sh -c apt-get update -qq >/dev/null
google_compute_instance.docker: Still creating... (1m20s elapsed)

google_compute_instance.docker (remote-exec): 54ff137eb1b2: Extracting     204B/204B

google_compute_instance.docker (remote-exec): 54ff137eb1b2: Pull complete
google_compute_instance.docker (remote-exec): Digest: sha256:4a5573037f358b6cdfa2f3e8a9c33a5cf11bcd1675ca72ca76fbe5bd77d0d682
google_compute_instance.docker (remote-exec): Status: Downloaded newer image for nginx:latest
google_compute_instance.docker (remote-exec): a6df1767bb64d34461ff54b87bba2dadff2a94078bd6c4d5091b2a59a9cc9087
google_compute_instance.docker: Still creating... (3m0s elapsed)
google_compute_instance.docker: Creation complete after 3m1s (ID: tf-docker-0)

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
[Captains-Bay]🚩 >
[Captains-Bay]🚩 >

```
