variable "ebs_volume_size" {default = "20"} # size is in gigabytes
variable "ebs_volume_type" {default = "gp2"}
variable "image_id" {}
variable "iam_profile" {}
variable "ec2_type" {}
variable "short_name" {default = "pubsub"}
variable "ssh_key_pair" {}
variable "security_group_ids" {}

resource "aws_launch_configuration" "as_conf" {
    name_prefix = "${var.short_name}-as-config-"
    image_id = "${var.image_id}"
    instance_type = "${var.ec2_type}"
    iam_instance_profile = "${var.iam_profile}"
    security_groups = [ "${split(",", var.security_group_ids)}"]
	key_name = "${var.ssh_key_pair}"
	associate_public_ip_address = true

    root_block_device {
		delete_on_termination = true
	    volume_size = "${var.ebs_volume_size}"
	    volume_type = "${var.ebs_volume_type}"
  	}

  	lifecycle {
      create_before_destroy = true
    }
}

output "name" {
	value = "${aws_launch_configuration.as_conf.name}"
}