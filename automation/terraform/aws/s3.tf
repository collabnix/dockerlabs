resource "aws_s3_bucket" "bucket"{
    bucket= "<bucket_name>"
    tags={
        Name= "<bucket_tag_name>"
        Environment= "<Environment_Name>"
      }
}
