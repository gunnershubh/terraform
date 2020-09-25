output "aws_vpn_gateway" {
  value = "${aws_vpn_gateway.vgw.id}"
}

output "aws_customer_gateway" {
  value = "${aws_customer_gateway.cgw.id}"
}

output "aws_vpn_connection" {
  value = "${aws_vpn_connection.vpn.id}"
}
