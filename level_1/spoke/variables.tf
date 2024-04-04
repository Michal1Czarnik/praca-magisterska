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

variable "key_vaults" {
  description = "The map containing key vaults"
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