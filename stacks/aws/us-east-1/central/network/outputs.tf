# Terraform Outputs File
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr_block" {
  value = "${module.vpc.vpc_cidr_block}"
}

output "public_route_table_ids" {
  value = ["${module.vpc.public_route_table_ids}"]
}

output "private_route_table_ids" {
  value = ["${module.vpc.private_route_table_ids}"]
}

output "public_subnets_ids" {
  value = ["${module.vpc.public_subnets_ids}"]
}

output "private_subnets_ids" {
  value = ["${module.vpc.private_subnets_ids}"]
}


output "default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "private_nat_eip_ids" {
  value = ["${module.vpc.private_nat_eip_ids}"]
}

output "private_nat_gw_ids" {
  value = ["${module.vpc.private_nat_gw_ids}"]
}

output "igw_id" {
  value = "${module.vpc.igw_id}"
}

output "private_nat_gw_routes" {
  value = ["${module.vpc.private_nat_gw_routes}"]
}


output "acm_cert_arn" {
  value = ["${module.acm.this_acm_certificate_arn}"]}


output "domain_name" {
  value = "${var.domain_name}"
}

output "zone_id" {
  value = "${data.aws_route53_zone.this.zone_id}"
}
