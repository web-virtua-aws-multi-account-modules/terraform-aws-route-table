variable "name" {
  description = "Name Route Table"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "gateway_id" {
  description = "Gateway ID"
  type        = string
}

variable "egress_only_internet_gateway_id" {
  description = "Egress only internet gatewa ID"
  type        = string
  default     = null
}

variable "cidr_block_route_table" {
  description = "Cidr Block IPV4"
  type        = string
  default     = "0.0.0.0/0"
}

variable "custom_routes" {
  description = "List with customized routes to configure in route table"
  type = list(object({
    cidr_block                 = string
    ipv6_cidr_block            = optional(string)
    destination_prefix_list_id = optional(string)
    carrier_gateway_id         = optional(string)
    core_network_arn           = optional(string)
    egress_only_gateway_id     = optional(string)
    gateway_id                 = optional(string)
    local_gateway_id           = optional(string)
    nat_gateway_id             = optional(string)
    network_interface_id       = optional(string)
    transit_gateway_id         = optional(string)
    vpc_endpoint_id            = optional(string)
    vpc_peering_connection_id  = optional(string)
  }))
  default = []
}

variable "cidr_block_ipv6_route_table" {
  description = "Cidr Block IPV6"
  type        = string
  default     = "::/0"
}

variable "ou_name" {
  description = "Organization unit name"
  type        = string
  default     = "no"
}

variable "subnet_ids" {
  description = "Subnets IDs list"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to bucket"
  type        = map(any)
  default     = {}
}
