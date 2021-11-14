# Create a new domain name
resource "civo_dns_domain_name" "dns" {
  name = var.domain_name
}
