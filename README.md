# Large VPC Project with Private Subnets + NAT

This project provisions a **large AWS VPC** with both **public and private subnets** across three Availability Zones in `us-east-1`.  
It demonstrates how to configure:
- A custom VPC (10.10.0.0/16) with DNS support/hostnames enabled  
- Public subnets with Internet Gateway + default routes  
- Private subnets with a NAT Gateway for outbound Internet access  
- Security Groups for HTTP/SSH  
- A demo EC2 web server with Apache installed via user data  

The infrastructure is defined using **Terraform** and is modular, with resources split across multiple `.tf` files for clarity.

---

## 📁 Repository Structure

├── 0-Auth.tf # AWS provider / authentication (region, creds)
├── 1-vpc.tf # VPC definition (CIDR block, DNS options)
├── IGW.tf # Internet Gateway
├── route.tf # Route tables and associations
├── subnets.tf # Public subnets (3 AZs, auto-assign public IPs)
├── 2-private-subnets.tf # Private subnets (3 AZs, no public IPs)
├── 4-nat.tf # NAT Gateway + Elastic IP + private RTB routes
├── 6-sg01-all.tf # Security Group (allow HTTP/SSH)
├── 7-ec2.tf # Web EC2 instance + Apache via user data
├── variables.tf # Variable declarations (VPC CIDRs, AZs, etc.)
├── terraform.tfvars # Variable values (your_ip_cidr, key_name, etc.)
├── outputs.tf # Outputs (public DNS, web URL, NAT IDs, subnets)
├── versions.tf # Provider version constraints
