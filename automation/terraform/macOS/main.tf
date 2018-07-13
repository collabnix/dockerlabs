provider "docker" {
  host ="unix:///var/run/docker.sock"
}

resource "docker_container" "nginx" {
  image = "${docker_image.nginx.latest}"
  name = "mynginx"
  ports {
     internal = 80
     external = 84
 }
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}
