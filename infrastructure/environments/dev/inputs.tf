// General
variable "project_name" {
  description = "The name of this project"
  type        = string
}
variable "workspace_enabled" {
  description = "Should the workspace be online?"
  type        = bool
}
variable "workspace_subdomain" {
  description = "The workspace will be available at this subdomain"
  type        = string
}

// Provider
variable "aws_account_id" {
  description = "Amazon account ID"
  type        = string
}
variable "aws_region" {
  description = "AWS Region"
  type        = string
}

// EC2
variable "workspace_instance_type" {
  description = "Instance type to use for the workspace server"
  type        = string
}
variable "ami_filter_string" {
  description = "Filter used to find the correct AMI"
  type        = string
}

// S3
variable "users_public_key_bucket" {
  description = "S3 bucket where user's public SSH keys are stored"
  type        = string
}

// Cloudflare
variable "cloudflare_email" {
  description = "Email address for the Cloudflare account"
  type        = string
}
variable "cloudflare_api_token" {
  description = "Limited scope Cloudflare API token"
  type        = string
}
variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
}
variable "cloudflare_zone_id" {
  description = "Zone ID for the domain managed by Cloudflare"
  type        = string
}
