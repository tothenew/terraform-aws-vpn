resource "tls_private_key" "ca" {
  count     = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? 1 : 0
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ca" {
  count           = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? 1 : 0
  private_key_pem = tls_private_key.ca[count.index].private_key_pem

  subject {
    common_name  = var.ca_common_name
    organization = var.organization_name
  }

  validity_period_hours = 87600
  is_ca_certificate     = true

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

resource "aws_acm_certificate" "ca" {
  count            = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? 1 : 0
  private_key      = tls_private_key.ca[count.index].private_key_pem
  certificate_body = tls_self_signed_cert.ca[count.index].cert_pem
}
