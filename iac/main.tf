locals {
  iam_policy = file("iac/iam/policies/${var.environment}/policy.json")
}

module "glue_job" {
  source = "git::https://github.com/JnsFerreira/terraform-module-aws-glue-job?ref=v1.0.0"

  name         = var.name
  description  = var.description
  iam_policy   = local.iam_policy
  glue_version = var.glue_version
  command      = var.command
  tags         = var.tags
}

module "glue_workflow" {
  source   = "cloudposse/glue/aws//modules/glue-workflow"
  version  = "0.4.0"

  workflow_name        = "my-workflow"
  workflow_description = "Example of glue workflow"
}

module "glue_trigger" {
  source   = "cloudposse/glue/aws//modules/glue-trigger"
  version  = "0.4.0"

  trigger_name        = "my-trigger"
  workflow_name       = module.glue_workflow.name
  trigger_description = "Triggers ${module.glue_job.name} Glue Job"
  schedule            = var.schedule_expression
  type                = "SCHEDULED"

  actions = [
    {
      job_name = module.glue_job.name
      timeout  = 300
    }
  ]

  depends_on = [module.glue_job, module.glue_workflow]
}