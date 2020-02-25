provider "aws" {
  region = "${var.region}"
}
terraform {
  backend "s3" {
    bucket         = "javahome2020-7am-tfstate"
    key            = "online-app/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "javahome"
  }
}