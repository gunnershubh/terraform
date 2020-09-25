#===============================================================================
# General
#===============================================================================

variable "name" {
  description = "Used to prefix resources created by this template."
}

variable "tags" {
  description = "Tags you want on resources created by this template."
  type = "map"
}

variable "aws_region" {
  description = "aws region name"
}
#===============================================================================
# Networking
#===============================================================================

variable "vpc_cidr" {
  description = "(Required) The CIDR block for the VPC."
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  type        = "list"
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  type        = "list"
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = "false"
}

variable "domain_name" {
  description = "public domain name"
}