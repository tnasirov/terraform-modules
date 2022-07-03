module "eks-irsa" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "~> 4"
  create_role                   = var.create_role
  role_name                     = "${var.serviceaccount_name}-${var.env}-pod-role"
  provider_url                  = replace(var.cluster_oidc_issuer_url, "https://", "")
  role_policy_arns              = [aws_iam_policy.iam_policy[0].arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.pod_namespace}:${var.serviceaccount_name}"]
  tags                          = local.tags
}

resource "aws_iam_policy" "iam_policy" {
  count       = var.create_role ? 1 : 0
  name        = "${var.serviceaccount_name}-${var.env}-pod-policy"
  description = "IAM policy for IAM Role ${var.serviceaccount_name}-${var.env}-pod-role"
  policy      = var.iam_policy_json
  tags        = local.tags
}
