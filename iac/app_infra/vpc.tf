locals {

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "${local.config["environment"]}-${var.application_name}-vpc"
  cidr = local.vpc_cidr

  azs = local.azs

  private_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnet_names = ["Private Subnet One", "Private Subnet Two"]

  public_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true
}