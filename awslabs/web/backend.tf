#store the terraform state file in s3
terraform {
  backend "s3" {
    bucket  = "bucketalbmodule"
    key     = "web.tfsate"
    region  = "ap-southeast-2"
    profile = "terraform_user"
  }
}