# Associate each private subnet to the right private RTB
# If single NAT, everyone uses RTB[0]; else align by index
resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private

  subnet_id = each.value.id
  route_table_id = aws_route_table.private[
    var.single_nat_gateway ? 0 : tonumber(each.key)
  ].id
}

