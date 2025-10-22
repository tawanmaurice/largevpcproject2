# Latest Amazon Linux 2023
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

locals {
  public_subnet_ids = [for s in aws_subnet.public : s.id]
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = "t3.micro"
  subnet_id                   = local.public_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true
  key_name                    = var.key_name # set in tfvars if you want SSH

  user_data = <<-EOF
    #!/bin/bash
    dnf -y update
    dnf -y install httpd
    echo "<h1>${var.project_name} – hello from $(hostname)</h1>" > /var/www/html/index.html
    systemctl enable --now httpd
  EOF

  tags = merge(local.common_tags, { Name = "${var.project_name}-web" })
}
