variable "resource_groups" {
  description = "The map containing the resource groups that need to be created"
  type        = any
  default     = {}
}

variable "virtual_networks" {
  description = "The map containing the virtual networks that need to be created"
  type        = any
  default     = {}
}

variable "network_security_groups" {
  description = "The map containing the network security groups that need to be created"
  type        = any
  default     = {}
}

variable "subnet_network_security_group_associations" {
  description = "The map containing information about the association of a Network Security Group with a Subnet"
  type = map(object({
    virtual_network_key        = string
    subnet_key                 = string
    network_security_group_key = string
  }))
  default = {}
}

variable "dns_relays" {
  description = "The map containing dns relay configuration"
  type        = any
  default     = {}
}

variable "private_dns" {
  description = "The map containing private DNS configuration"
  type        = any
  default     = {}
}

variable "logging" {
  description = "The object containing logging configuration"
  type        = any
  default     = {}
}

variable "vpn" {
  description = "Is vpn enabled?"
  type        = bool
  default     = false
}

variable "vpn_groups" {
  description = "AAD groups allowed to connect to the VPN"
  type        = set(string)
  default     = []
}

variable "firewall" {
  description = "The object containing firewall configuration"
  type        = any
  default     = {}
}

variable "route_tables" {
  description = "The route tables to create"
  type        = any
  default     = {}
}

variable "route_table_associations" {
  description = "The map containing information about the association of a route table with a subnet"
  type = map(object({
    virtual_network_key = string
    subnet_key          = string
    route_table_key     = string
  }))
  default = {}
}

variable "my_domains" {
  description = "The set of domains that belong to me"
  type        = set(string)
  default     = []
}