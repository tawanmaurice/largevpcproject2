provider "aws" { region = var.region }

locals {
  common_tags = {
    Project = var.project_name
    Managed = "terraform"
  }
}
