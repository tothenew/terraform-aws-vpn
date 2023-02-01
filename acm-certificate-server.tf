resource "tls_private_key" "server" {
  count       = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? 1: 0
  algorithm = "RSA"
}

resource "tls_cert_request" "server" {
  count       = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? 1: 0
  private_key_pem = tls_private_key.server[count.index].private_key_pem

  subject {
    common_name  = "${var.server_common_name}"
    organization = var.organization_name
  }
}

resource "tls_locally_signed_cert" "server" {
  count       = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? 1: 0
  cert_request_pem   = tls_cert_request.server[count.index].cert_request_pem
  ca_private_key_pem = tls_private_key.ca[count.index].private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca[count.index].cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "server" {
  count       = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? 1: 0
  private_key       = tls_private_key.server[count.index].private_key_pem
  certificate_body  = tls_locally_signed_cert.server[count.index].cert_pem
  certificate_chain = tls_self_signed_cert.ca[count.index].cert_pem
}
