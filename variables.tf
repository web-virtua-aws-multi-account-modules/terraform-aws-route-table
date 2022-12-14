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

variable "egress_only_internet_gatewa_id" {
  description = "Egress only internet gatewa ID"
  type        = string
  default     = null
}

variable "cidr_block_route_table" {
  description = "Cidr Block IPV4"
  type        = string
  default     = "0.0.0.0/0"
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
