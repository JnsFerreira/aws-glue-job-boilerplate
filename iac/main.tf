module "glue_job" {
  source = "https://github.com/JnsFerreira/terraform-module-aws-glue-job?ref=v1.0.0"

  name         = var.name
  description  = var.description
  glue_version = var.glue_version
  command      = var.command
}
