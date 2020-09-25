variable "name" {
  description = "Name tag"
}

variable "tags" {
  type        = "map"
  description = "A map of tags to add to all the resources"
}

variable "bgp_asn" {
  default = "65444"
}

variable "ip_address"  {
  description = "This is the Customer Gateway IP Address"
}
variable "type" {
  default = "ipsec.1"

}

variable "route" {
  default     = "dynamic"
  description = "This is the default route for VPN"
}

variable "vpn_connection_tunnel1_preshared_key" {
  description = "PSK for Tunnel 1"
}

variable "vpn_connection_tunnel2_preshared_key" {
  description = "PSK for tunnel 2"
}
