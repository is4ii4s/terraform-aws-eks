
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = local.name
  cidr = local.vpc_cird

  azs = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  public_subnets = ["10.79.0.0/24", "10.79.1.0/24", "10.79.2.0/24"]

  manage_default_network_acl = true
  default_network_acl_tags   = { Name = "${local.name}-default" }

  manage_default_route_table = true
  default_route_table_tags   = { Name = "${local.name}-default" }

  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.name}-default" }

  enable_dns_hostnames = true
  enable_dns_support   = true

  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = local.name
    },
  )
}