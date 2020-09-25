module "vpc" {
  source = "../../../../../tf-modules/aws/vpc"

  #VPC Vars
  name                    = "${var.name}"
  vpc_cidr                = "${var.vpc_cidr}"
  public_subnets          = "${var.public_subnets}"
  private_subnets         = "${var.private_subnets}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

   #tagging
  tags = "${var.tags}"
}
