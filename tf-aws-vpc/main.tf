module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  create_vpc = var.create_vpc
  name       = var.vpc_name
  cidr       = var.cidr
  azs        = local.azs

  ### public subnets
  public_subnets          = var.public_subnets
  map_public_ip_on_launch = var.map_public_ip_on_launch

  ### private subnets
  private_subnets = var.private_subnets

  ### database subnets
  database_subnets = var.database_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  ### Best practise for default security groups not to allow any incoming or outgoing traffic
  manage_default_security_group  = true
  default_security_group_egress  = []
  default_security_group_ingress = []

  ### a map of tags to add to all resources
  tags = local.tags
  public_subnet_tags = {
    subnet_type = "public"
    # public subnets must be tagged as follows so that Kubernetes knows to use only those subnets for external Load
    # Balancers instead of choosing a public subnet in each AZ (in lexicographical order by subnet ID), ref.:
    #   * https://docs.aws.amazon.com/eks/latest/userguide/load-balancing.html
    "kubernetes.io/role/elb"               = "1"
    "kubernetes.io/cluster/${var.env}-eks" = "shared"
  }
  private_subnet_tags = {
    subnet_type = "private"
    # private subnets must be tagged as follows so that Kubernetes and AWS Load Balancer controller know that a subnet
    # can be used for internal Load Balancer, ref.:
    #   * https://docs.aws.amazon.com/eks/latest/userguide/load-balancing.html
    "kubernetes.io/role/internal-elb"      = "1"
    "kubernetes.io/cluster/${var.env}-eks" = "shared"
  }
  database_subnet_tags = {
    subnet_type = "database"
  }
}

resource "aws_ebs_encryption_by_default" "account_ebs_encryption" {
  enabled = true
}
