resource "aws_subnet" "public" {
  for_each                = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = var.azs[tonumber(each.key)]
  map_public_ip_on_launch = true
  tags = merge(local.common_tags, {
    Name = format("%s-public-%s", var.project_name, var.azs[tonumber(each.key)])
    Tier = "public"
  })
}
