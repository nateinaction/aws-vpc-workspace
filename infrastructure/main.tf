provider "aws" {
  version = "~> 2.23.0"
  region  = var.aws_region
}

provider "cloudflare" {
  version    = "~> 2.0"
  email      = var.cloudflare_email
  api_token  = var.cloudflare_api_token
  account_id = var.cloudflare_account_id
}

module "network" {
  source = "./network"

  project_name = var.project_name
}

module "machine" {
  source = "./machine"

  project_name                 = var.project_name
  workspace_enabled            = var.workspace_enabled
  workspace_instance_type      = var.workspace_instance_type
  ami_filter_string            = var.ami_filter_string
  workspace_subnet_id          = module.network.workspace_subnet_id
  workspace_security_group_ids = module.network.workspace_security_group_ids
  users_public_key_bucket      = var.users_public_key_bucket
}

module "dns" {
  source = "./dns"

  workspace_enabled  = var.workspace_enabled
  workspace_ipv4     = module.machine.workspace_ipv4
  workspace_ipv6     = module.machine.workspace_ipv6
  cloudflare_zone_id = var.cloudflare_zone_id
}
