resource "aws_route_table" "create_route_table" {
  vpc_id = var.vpc_id

  route {
    gateway_id = var.gateway_id
    cidr_block = var.cidr_block_route_table
  }

  dynamic "route" {
    for_each = var.egress_only_internet_gatewa_id != null ? [1] : []
    content {
      ipv6_cidr_block        = var.cidr_block_ipv6_route_table
      egress_only_gateway_id = var.egress_only_internet_gatewa_id
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
