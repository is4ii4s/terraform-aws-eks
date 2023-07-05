
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = local.name
  cidr = local.vpc_cird

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.79.0.0/24", "10.79.1.0/24", "10.79.2.0/24"]
  public_subnets  = ["10.79.3.0/24", "10.79.4.0/24", "10.79.5.0/24"]
  #database_subnets = ["10.79.6.0/24", "10.79.7.0/24", "10.79.8.0/24"]

  #create_database_subnet_group = true

  manage_default_network_acl = true
  default_network_acl_tags   = { Name = "${local.name}-default" }

  manage_default_route_table = true
  default_route_table_tags   = { Name = "${local.name}-default" }

  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.name}-default" }

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  tags = merge(
    var.tags,
    {
      Name = local.name
    },
  )
}