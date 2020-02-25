resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
    Name       = "TerrafomDemo-${terraform.workspace}"
    Location   = "Banglore"
    Department = "HR"
    Environmet = "${terraform.workspace}"
  }
}

resource "aws_subnet" "public" {
  count             = "${local.az_length}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr,4,count.index)}"
  availability_zone = "${local.az_names[count.index]}"
  tags = {
    Name = "Public-${terraform.workspace}"
  }
}

resource "aws_subnet" "private" {
  count             = "${local.az_length}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr,4,local.az_length+count.index)}"
  availability_zone = "${local.az_names[count.index]}"
  tags = {
    Name = "Private-${terraform.workspace}"
  }
}

// Create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "internet-gateway-${terraform.workspace}"
  }
}

// Create route table for public subnet

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "public-rt-${terraform.workspace}"
  }
}
// Associate public route table to public subnets

resource "aws_route_table_association" "a" {
  count = "${local.az_length}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = aws_route_table.public.id
}
