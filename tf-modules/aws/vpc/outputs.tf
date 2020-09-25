output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.main.cidr_block}"
}

output "public_subnets_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "private_subnets_ids" {
  value = ["${aws_subnet.private.*.id}"]
}


output "public_route_table_ids" {
  value = ["${aws_route_table.public.*.id}"]
}

output "private_route_table_ids" {
  value = ["${aws_route_table.private.*.id}"]
}

output "default_security_group_id" {
  value = "${aws_vpc.main.default_security_group_id}"
}

output "private_nat_eip_ids" {
  value = ["${aws_eip.private_nat_eip.*.id}"]
}

output "private_nat_gw_ids" {
  value = ["${aws_nat_gateway.private_nat_gw.*.id}"]
}

output "igw_id" {
  value = "${aws_internet_gateway.main.id}"
}

output "private_nat_gw_routes" {
  value = ["${aws_route.to_private_nat_gateway.*.route_table_id}"]
}
