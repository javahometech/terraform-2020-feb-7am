resource "aws_s3_bucket" "app" {
  bucket = "javahome2020-454545"
  acl    = "private"

  tags = {
    Name        = "JavaHome"
    Environment = "${terraform.workspace}"
  }
}