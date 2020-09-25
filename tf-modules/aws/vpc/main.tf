#===============================================================================
# VPC
#===============================================================================

resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags                 = "${merge(var.tags, map("Name", format("%s-vpc", var.name)))}"
}

## Subnets-----------------------------------------------------------------------
resource "aws_subnet" "public" {
  count                   = "${length(var.public_subnets)}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.public_subnets[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  tags                    = "${merge(var.tags, map("Name", format("%s-public-subnet-%s", var.name, element(data.aws_availability_zones.available.names, count.index))))}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

resource "aws_subnet" "private" {
  count             = "${length(var.private_subnets)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  tags              = "${merge(var.tags, map("Name", format("%s-private-subnet-%s", var.name, element(data.aws_availability_zones.available.names, count.index))))}"
}

##Route Tables------------------------------------------------------------------
resource "aws_route_table" "public" {
  vpc_id           = "${aws_vpc.main.id}"
  #propagating_vgws = ["${aws_vpn_gateway.main.id}"]
  tags             = "${merge(var.tags, map("Name", format("%s-route-table-public", var.name)))}"
}

resource "aws_route_table" "private" {
  vpc_id           = "${aws_vpc.main.id}"
  #propagating_vgws = ["${aws_vpn_gateway.main.id}"]
  count            = "${length(var.private_subnets)}"
  tags             = "${merge(var.tags, map("Name", format("%s-route-table-private-%s", var.name, element(data.aws_availability_zones.available.names, count.index))))}"
}

##Routes------------------------------------------------------------------------
resource "aws_route" "to_public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_route" "to_private_nat_gateway" {
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.private_nat_gw.*.id, count.index)}"
  count                  = "${length(var.private_subnets)}"
}

##Route tables associations-----------------------------------------------------
resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

##Internet Gateways-------------------------------------------------------------
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
  tags   = "${merge(var.tags, map("Name", format("%s-igw", var.name)))}"
}

##EIP---------------------------------------------------------------------------
resource "aws_eip" "private_nat_eip" {
  vpc   = true
  count = "${length(var.private_subnets)}"
  tags          = "${merge(var.tags, map("Name", format("%s-nat-eip-%s", var.name, element(data.aws_availability_zones.available.names, count.index))))}"
}

##NAT Gateways------------------------------------------------------------------
resource "aws_nat_gateway" "private_nat_gw" {
  allocation_id = "${element(aws_eip.private_nat_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  count         = "${length(var.public_subnets)}"
  tags          = "${merge(var.tags, map("Name", format("%s-nat-gw-%s", var.name, element(data.aws_availability_zones.available.names, count.index))))}"
  depends_on = ["aws_internet_gateway.main"]
}
