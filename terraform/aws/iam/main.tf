variable "short_name" {default = "rancher"}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.short_name}-profile"
  roles = ["${aws_iam_role.ec2_role.name}"]
}

resource "aws_iam_role_policy" "policy" {
  name = "${var.short_name}-policy"
  role = "${aws_iam_role.ec2_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:AttachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:DetachVolume",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": ["route53:*"],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:BatchGetImage"
      ],
      "Resource": "*"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::rzdev",
        "arn:aws:s3:::rzdev/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.short_name}-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

output "iam_instance_profile" {
  value = "${aws_iam_instance_profile.profile.name}"
}
