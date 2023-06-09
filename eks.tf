module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.2"

  cluster_name    = local.name
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id = module.vpc.vpc_id
  subnet_ids = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1],
    module.vpc.public_subnets[1]
  ]

    # EKS Managed Node Group(s)
    eks_managed_node_group_defaults = {
      instance_types = ["t3.micro", "t3.small", "t3.medium", "t3.large"]
    }

    eks_managed_node_groups = {
      blue = {}
      green = {
        min_size     = 2
        max_size     = 5
        desired_size = 2

        instance_types = ["t3.small"]
        capacity_type  = "ON_DEMAND"
      }
    }

#  manage_aws_auth_configmap = true
#
#  aws_auth_roles = [
#    {
#      rolearn  = "arn:aws:iam::665284826828:role/admin-role"
#      username = "Isaias.Souza@dentsuaegis.com"
#      groups   = ["system:masters"]
#    },
#  ]


  tags = merge(
    var.tags,
    {
      Name = local.name
    },
  )

  depends_on = [
    module.vpc
  ]
}

#data "aws_eks_cluster" "default" {
#  name = module.eks.cluster_name
#}
#
#data "aws_eks_cluster_auth" "default" {
#  name = module.eks.cluster_name
#}
#
#provider "kubernetes" {
#  host                   = data.aws_eks_cluster.default.endpoint
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
#  token                  = data.aws_eks_cluster_auth.default.token
#  depends_on = [
#    module.eks]
#}