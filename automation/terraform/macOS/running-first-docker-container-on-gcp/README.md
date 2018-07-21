# Running Your First Docker Container on Google CLoud Platform using Terraform

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
