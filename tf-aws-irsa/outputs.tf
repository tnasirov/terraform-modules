output "iam_role_name" {
  description = "Name of IAM role"
  value       = module.eks-irsa.iam_role_name
}

output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = module.eks-irsa.iam_role_arn
}
