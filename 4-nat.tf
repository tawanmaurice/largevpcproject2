resource "aws_eip" "nat" {
  count  = var.single_nat_gateway ? 1 : length(var.azs)
  domain = "vpc"
  tags = {
    Project = var.project_name
    Managed = "terraform"
    Name    = "${var.project_name}-eip-nat-${count.index}"
  }
}

resource "aws_nat_gateway" "this" {
  count         = var.single_nat_gateway ? 1 : length(var.azs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[var.single_nat_gateway ? "0" : tostring(count.index)].id
  tags = {
    Project = var.project_name
    Managed = "terraform"
    Name    = "${var.project_name}-nat-${count.index}"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  count  = length(var.azs)
  vpc_id = aws_vpc.main.id
  tags = {
    Project = var.project_name
    Managed = "terraform"
    Name    = "${var.project_name}-rtb-private-${count.index}"
  }
}

resource "aws_route" "private_default" {
  count                  = length(var.azs)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.single_nat_gateway ? aws_nat_gateway.this[0].id : aws_nat_gateway.this[count.index].id
}

resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private
  route_table_id = aws_route_table.private[tonumber(each.key)].id
  subnet_id      = each.value.id
}

