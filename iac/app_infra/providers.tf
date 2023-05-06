provider "aws" {
  region  = local.config["region"]
  profile = local.config["profile"]

  default_tags {
    tags = local.default_tags
  }
}