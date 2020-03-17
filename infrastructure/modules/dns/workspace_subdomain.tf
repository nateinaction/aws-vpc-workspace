resource "cloudflare_record" "execution_ipv4" {
  count = var.workspace_enabled ? 1 : 0

  zone_id = var.cloudflare_zone_id
  name    = var.workspace_subdomain
  value   = var.workspace_ipv4
  type    = "A"
}

resource "cloudflare_record" "execution_ipv6" {
  count = var.workspace_enabled ? 1 : 0

  zone_id = var.cloudflare_zone_id
  name    = var.workspace_subdomain
  value   = var.workspace_ipv6
  type    = "AAAA"
}
