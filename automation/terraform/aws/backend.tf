terraform {
 backend "s3" {
   bucket         = "myorg-terraform-environmentname"
   key            = "shared/terraform.tfstate"
   region         = "us-east-1"
   encrypt        = true
   dynamodb_table = "terraform-lock"
 }
}
