


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.26.2"

  create = var.create_eks

  cluster_name                    = local.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_roles = var.map_roles

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = var.eks_managed_node_group_defaults

  eks_managed_node_groups = local.node_groups

  node_security_group_additional_rules = local.node_security_group_additional_rules

  tags = local.tags
}
