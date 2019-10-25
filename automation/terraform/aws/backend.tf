terraform{
backend "s3"{
bucket= "<bucket_name>"
profile= "<profile_name>"
region= "<region_name>"
key= "path/terraform.tfstate"
}
}
