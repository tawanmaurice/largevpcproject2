resource "aws_subnet" "private" {
  # Build a map: "0" => { az = "...", cidr = "..." }
  for_each = {
    for idx, az in tolist(var.azs) :
    tostring(idx) => {
      az   = az
      cidr = var.private_subnet_cidrs[idx]
    }
  }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = {
    Project = var.project_name
    Managed = "terraform"
    Tier    = "private"
    Name    = "${var.project_name}-private-${each.value.az}"
  }
}

