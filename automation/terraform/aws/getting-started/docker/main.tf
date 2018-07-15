provider "aws" {
  access_key = "XXX"
  secret_key = "XXX"
  region     = "us-east-1"
}
resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  tags {
    Name = "terraform-example"
  }
  provisioner "remote-exec" {
      inline = [
        "sudo curl -sSL https://get.docker.com/ | sh",
        "sudo docker pull nginx",
        "sudo docker run -d -p 80:80 nginx"
        ]
   }
}
resource "aws_elb" "example" {
   name         = "example"
   availability_zones    = ["us-east-1a", "us-east-1b" ]
   instances = ["${aws_instance.example.id}"]
   listener {
      lb_port = 80
      lb_protocol = "http"
      instance_port = "8080"
      instance_protocol = "http"
    }
}
