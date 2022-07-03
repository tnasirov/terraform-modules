# common variables for every module
variable "tags" {
  description = "Common set of tags."
  type        = map(string)
  default     = {}
}

variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = true
}

variable "env" {
  description = "Environment name"
  default     = ""
}

variable "serviceaccount_name" {
  description = "Service name usually reflected pod name and included to IAM Role name"
  type        = string
}

variable "pod_namespace" {
  description = "EKS cluster namespace were pod deployed"
  type        = string
}

variable "iam_policy_json" {
  description = "IAM policy for service/pod, json formatted"
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  type        = string
}
