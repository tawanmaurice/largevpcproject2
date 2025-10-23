# Private subnets (one per AZ)
resource "aws_subnet" "private" {
  # map index -> cidr so we can line up with var.azs
  for_each = { for i, cidr in var.private_subnet_cidrs : tostring(i) => cidr }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = var.azs[tonumber(each.key)]
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-private-${var.azs[tonumber(each.key)]}"
    Tier = "private"
  })
}

