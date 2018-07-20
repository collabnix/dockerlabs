# See https://cloud.google.com/compute/docs/load-balancing/network/example

provider "google" {
  region      = "${var.region}"
  project     = "${var.project_name}"
  credentials = "${file("${var.credentials_file_path}")}"
}


resource "google_compute_instance" "www" {
  count = 1

  name         = "tf-www-${count.index}"
  machine_type = "f1-micro"
  zone         = "${var.region_zone}"
  tags         = ["www-node"]

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
      "sudo curl -sSL https://get.docker.com/ | sh"
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
  target_tags   = ["www-node"]
}
