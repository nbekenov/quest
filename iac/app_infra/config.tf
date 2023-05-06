locals {

  valid_workspaces = {
    dev  = "dev"
    prod = "prod"
  }

  selected_workspace = local.valid_workspaces[terraform.workspace]

  default_tags = {
    "environment" = local.config["environment"]
    "automation"  = "terraform"
    "project"     = "quest"
    "component"   = "app-infra"
  }

  config = local.environment_config[local.selected_workspace]

  environment_config = {
    dev  = local.dev
    prod = local.prod
  }
}