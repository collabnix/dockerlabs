provider "aws" {
  access_key = "XXXX"
  secret_key = "XXXX"
  region     = "us-east-1"
}
resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
