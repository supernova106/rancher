variable "zone_id" {}
variable "short_name" {default = "pubsub"}
variable "records" {}
variable "domain" {}
variable "type" {}

resource "aws_route53_record" "www" {
	zone_id = "${var.zone_id}"
	name = "${var.short_name}.${var.domain}"
	type = "${var.type}"
	ttl = "60"
	records = ["${var.records}"]
}

