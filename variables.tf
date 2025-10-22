# ----- REQUIRED -----
variable "project_name" {
  description = "Short name used in tags and resource names"
  type        = string
}

variable "region" {
  description = "AWS region to deploy into (e.g., us-east-1)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC (e.g., 10.10.0.0/16)"
  type        = string
}

variable "azs" {
  description = "Availability Zones to use, in order"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets (must match azs length)"
  type        = list(string)
}

# ----- EC2 DEMO (OPTION B) -----
variable "allowed_ssh_cidr" {
  description = "CIDR allowed for SSH (use YOUR_IP/32 for safety)"
  type        = string
  default     = "0.0.0.0/0" # override in terraform.tfvars
}

variable "key_name" {
  description = "Existing EC2 key pair name (or null to skip SSH)"
  type        = string
  default     = null
}

