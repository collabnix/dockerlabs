# Specify the provider (GCP, AWS, Azure)
provider "google" {
credentials = "${file("terraform-account.json")}"
project = "i-guru-209217"
region = "asia-east1"
}
