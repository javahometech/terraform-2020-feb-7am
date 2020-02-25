resource "aws_iam_role" "webapp_role" {
  name = "javahome_webapp_role_${terraform.workspace}"

  assume_role_policy = "${data.template_file.ec2_assume_role.rendered}"
}

data "template_file" "ec2_assume_role" {
  template = "${file("iam/iam-assume-role-policy.tpl")}"
  vars = {
    service_name = "ec2"
  }
}

// iam policy for your web app

resource "aws_iam_policy" "s3_policy" {
  name        = "s3_iam_ec2_${terraform.workspace}"
  description = "s3_iam_ec2_${terraform.workspace}"

  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "Stmt1582597130935",
          "Action": [
            "s3:GetObject",
            "s3:PutObject"
          ],
          "Effect": "Allow",
          "Resource": "${aws_s3_bucket.app.arn}/*"
        }
      ]
    }
EOF
}

resource "aws_iam_role_policy_attachment" "s3-ec2-policy-attach" {
  role       = "${aws_iam_role.webapp_role.name}"
  policy_arn = "${aws_iam_policy.s3_policy.arn}"
}

// create iam instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_s3_profile"
  role = "${aws_iam_role.webapp_role.name}"
}