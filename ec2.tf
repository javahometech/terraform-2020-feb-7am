resource "aws_instance" "web" {
  ami           = "${lookup(var.ami_ids, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.*.id[0]}"
  associate_public_ip_address = true
  user_data = "${file("scripts/apache.sh")}"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.id}"
  tags = {
    Name = "HelloWorld"
  }
}