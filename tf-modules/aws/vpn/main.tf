#Terraform module to be imported while creation of VGW,CGW and VPN Connection.


resource "aws_vpn_gateway" "vgw" {

  vpc_id     = "${aws_vpc.main.id}"
  tags       = "${merge(var.tags, map("Name", format("%s-vgw", var.name)))}"
}


resource "aws_customer_gateway" "cgw" {

  bgp_asn    = "${var.bgp_asn}"
  ip_address = "${var.ip_address}"
  type       = "${var.type}"
  tags       = "${merge(var.tags, map("Name", format("%s-cgw", var.name)))}"

}

resource "aws_vpn_connection" "vpn" {

  vpn_gateway_id        = "${aws_vpn_gateway.vgw.id}"
  customer_gateway_id   = "${aws_customer_gateway.cgw.id}"
  type                  = "${var.type}"
  static_routes_only    = "${var.route}"
  tunnel1_preshared_key = "${var.vpn_connection_tunnel1_preshared_key}"
  tunnel2_preshared_key = "${var.vpn_connection_tunnel2_preshared_key}"
  tags                  = "${merge(var.tags, map("Name", format("%s-vpn", var.name)))}"

}


resource "aws_vpn_gateway_attachment" "vpn_attachment" {
  vpc_id         = "${aws_vpc.network.id}"
  vpn_gateway_id = "${aws_vpn_gateway.vpn.id}"


}
