output "workspace_ipv4" {
  value = var.workspace_enabled ? aws_instance.workspace[0].public_ip : ""
}

output "workspace_ipv6" {
  value = var.workspace_enabled ? aws_instance.workspace[0].ipv6_addresses[0] : ""
}
