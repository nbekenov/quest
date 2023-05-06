locals {
  name           = "${local.config["environment"]}-${var.application_name}"
  container_name = "rearc-quest"
  container_port = 3000
  subdomain      = "${local.config["environment"]}.${var.application_name}.${var.domain_name}"
}