// ec2
variable "workspace_enabled" {
  description = "Should the workspace be online?"
  type = bool
}
variable "workspace_ipv4" {
  description = "Public IPv4 address for workspace"
  type = string
}
variable "workspace_ipv6" {
  description = "Public IPv6 address for workspace"
  type = string
}

// Cloudflare
variable "cloudflare_zone_id" {
  description = "Zone ID for the domain managed by Cloudflare"
  type = string
}

