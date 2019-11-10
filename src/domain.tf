resource "cloudflare_record" "execution_ipv4" {
  count = var.workspace_enabled ? 1 : 0

  zone_id = var.cloudflare_zone_id
  name    = "workspace"
  value   = aws_instance.workspace[count.index].public_ip
  type    = "A"
}

resource "cloudflare_record" "execution_ipv6" {
  count = var.workspace_enabled ? 1 : 0

  zone_id = var.cloudflare_zone_id
  name    = "workspace"
  value   = aws_instance.workspace[count.index].ipv6_addresses[0]
  type    = "AAAA"
}
