resource "aws_vpc" "abc" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
    Name       = "TerrafomDemo-${terraform.workspace}"
    Location   = "Banglore"
    Department = "HR"
    Environmet = "${terraform.workspace}"
  }
}

resource "aws_subnet" "public" {
  count             = "${length(data.aws_availability_zones.azs.names)}"
  vpc_id            = "${aws_vpc.abc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "?"
  tags = {
    Name = "Public-1"
  }
}
