locals {

  tags = merge(
    var.tags,
    {
      terraform = true
      env       = "${var.env}"
    }
  )

  cluster_name = "${var.env}-eks"

  ### Here we loop over var.node_groups and create different node groups with different parameters sent by terragrunt side.
  node_groups = { for ng_key, ng_config in var.node_groups : ng_key => merge(
    ng_config,
    {
      pre_bootstrap_user_data = <<-EOT

      #!/usr/bin/env bash
      set -e
      export CONTAINER_RUNTIME="containerd"
      # install AWS SSM Agent
      yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
      EOT

      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      ]

      tags = local.tags
    }
  ) }

  ### Node group security group additional rules
  node_security_group_additional_rules = {
    ingress_self_allow_all = {
      description = "Node to node allow all"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_self_allow_all = {
      description = "Node to node allow all"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      self        = true
    }
  }
}
