variable "short_name" {default = "pubsub"}
variable "availability_zones" {}
variable "launch_configuration_name" {}
#variable "target_group_arns" {}
variable "subnet_ids" {}
variable "elb_names" {}

resource "aws_autoscaling_group" "pubsub" {
  vpc_zone_identifier = ["${split(",", var.subnet_ids)}"]
  availability_zones        = ["${split(",", var.availability_zones)}"]
  name                      = "${var.short_name}-autoscaling-group"
  max_size                  = 5
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 0
  force_delete              = true
  launch_configuration      = "${var.launch_configuration_name}"

  #target_group_arns = ["${split(",", var.target_group_arns)}"]
  termination_policies = ["OldestInstance", "OldestLaunchConfiguration", "Default"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.pubsub.name}"
  elb = "${var.elb_names}"
}