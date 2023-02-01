# output "security_group_id" {
#   value = try(aws_security_group.default[0].id, var.security_group_id)
# }
# output "vpn_endpoint_id" {
#   value = aws_ec2_client_vpn_endpoint.default.id
# }
# output "vpn_client_cert" {
#   value = tls_locally_signed_cert.root.cert_pem
#   sensitive = true
# }
# output "vpn_client_key" {
#   value = tls_private_key.root.private_key_pem
#   sensitive = true
# }
# output "vpn_server_cert" {
#   value = tls_locally_signed_cert.server.cert_pem
#   sensitive = true
# }
# output "vpn_server_key" {
#   value = tls_private_key.server.private_key_pem
#   sensitive = true
# }
# output "vpn_ca_cert" {
#   value = tls_self_signed_cert.ca.cert_pem
#   sensitive = true
# }
# output "vpn_ca_key" {
#   value = tls_private_key.ca.private_key_pem
#   sensitive = true
# }



# ########################Pritunl outputs############################
# output "test" {
#   value = data.aws_ami.ubuntu
# }
# output "private_ip" {
#   value = aws_instance.ec2.private_ip
# }

# output "id" {
#   value = aws_instance.ec2.id
# }

# output "arn" {
#   value = aws_instance.ec2.arn
# }

# output "public_ip" {
#   value = aws_instance.ec2.public_ip
# }
