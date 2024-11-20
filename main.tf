resource "aws_route_table" "create_route_table" {
  vpc_id = var.vpc_id

  route {
    gateway_id = var.gateway_id
    cidr_block = var.cidr_block_route_table
  }

  dynamic "route" {
    for_each = var.egress_only_internet_gateway_id != null ? [1] : []
    content {
      ipv6_cidr_block        = var.cidr_block_ipv6_route_table
      egress_only_gateway_id = var.egress_only_internet_gateway_id
    }
  }

  dynamic "route" {
    for_each = var.custom_routes
    iterator = item

    content {
      cidr_block                 = item.value.cidr_block
      ipv6_cidr_block            = item.value.ipv6_cidr_block
      destination_prefix_list_id = item.value.destination_prefix_list_id
      carrier_gateway_id         = item.value.carrier_gateway_id
      core_network_arn           = item.value.core_network_arn
      egress_only_gateway_id     = item.value.egress_only_gateway_id
      gateway_id                 = item.value.gateway_id
      local_gateway_id           = item.value.local_gateway_id
      nat_gateway_id             = item.value.nat_gateway_id
      network_interface_id       = item.value.network_interface_id
      transit_gateway_id         = item.value.transit_gateway_id
      vpc_endpoint_id            = item.value.vpc_endpoint_id
      vpc_peering_connection_id  = item.value.vpc_peering_connection_id
    }
  }

  tags = merge(var.tags, {
    "tf-type" = "route-table"
    "Name"    = var.name
    "tf-ou"   = var.ou_name
  })
}

resource "aws_route_table_association" "create_associate_subnet" {
  count          = length(var.subnet_ids)
  subnet_id      = element(var.subnet_ids.*, count.index)
  route_table_id = aws_route_table.create_route_table.id
}
