module "acm" {
  source = "../../../../../tf-modules/aws/acm"

  domain_name = "*.${var.domain_name}"
  zone_id     = "${data.aws_route53_zone.this.zone_id}"

  wait_for_validation = false # true

  tags = {
    Name = "${var.domain_name}"
  }
}
