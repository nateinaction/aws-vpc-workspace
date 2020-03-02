// General
variable "project_name" {
  description = "The name of this project"
  type = string
}
variable "workspace_enabled" {
  description = "Should the workspace be online?"
  type = bool
}

// EC2
variable "ssh_key" {
  description = "SSH key name to use for the workspace server"
  default = ""
  type = string
}
variable "workspace_instance_type" {
  description = "Instance type to use for the workspace server"
  type = string
}
variable "ami_filter_string" {
  description = "Filter used to find the correct AMI"
  type = string
}
variable "workspace_security_group_ids" {
  description = "IDs of the security groups the workspace should be in"
  type = list(string)
}
variable "workspace_subnet_id" {
  description = "ID of the subnet where the workspace will live"
  type = string
}

// S3
variable "users_public_key_bucket" {
  description = "S3 bucket where user's public SSH keys are stored"
  type = string
}
