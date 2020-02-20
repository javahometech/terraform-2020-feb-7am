provider "aws"{
    region = "ap-south-1"
}
terraform {
  backend "s3" {
    bucket = "javahome2020-7am-tfstate"
    key    = "online-app/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "javahome"
  }
}

resource "aws_vpc" "abc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TerrafomDemo-${terraform.workspace}"
    Location = "Banglore"
    Department = "HR"
    Environmet = "${terraform.workspace}"
  }
}