variable "create_eks" {
  description = "Controls if EKS should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common set of tags."
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "Environment name"
  default     = ""
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC id of where EKS will reside"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDS where nodes will be provisioned"
  type        = list(string)
  default     = []
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
  type        = bool
  default     = true
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap"

  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

#--------------------
# EKS managed node groups
#--------------------

variable "eks_managed_node_group_defaults" {
  description = "Map of values to be applied to all node groups. See `node_groups` module's documentation for more details"
  type        = any
  default     = {}
}
variable "node_groups" {
  description = "Map of node groups to create"
  type        = any
  default     = {}
}
