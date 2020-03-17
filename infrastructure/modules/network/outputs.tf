output "workspace_security_group_ids" {
  value = [
      aws_vpc.network.default_security_group_id,
      aws_security_group.workspace.id,
    ]
}

output "workspace_subnet_id" {
  value = aws_subnet.public[0].id
}
