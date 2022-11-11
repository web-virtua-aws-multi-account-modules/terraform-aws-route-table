output "route_table" {
  description = "Route table"
  value       = aws_route_table.create_route_table
}

output "route_table_association" {
  description = "Route table association"
  value       = aws_route_table_association.create_associate_subnet
}
