# EC2 demo outputs
output "web_public_ip" { value = aws_instance.web.public_ip }
output "web_public_dns" { value = aws_instance.web.public_dns }
output "web_http_url" { value = "http://${aws_instance.web.public_dns}" }
output "private_subnets" {
  value = [for s in aws_subnet.private : s.id]
}

output "nat_gateway_ids" {
  value = try([for n in aws_nat_gateway.this : n.id], [])
}

output "private_route_table_ids" {
  value = try([for r in aws_route_table.private : r.id], [])
}
