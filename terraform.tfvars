vpc_id                = "vpc-0123456789"
project_name_prefix   = "dev-tothenew"
key_name              = "my-ec2-keypair"
instance_type         = "t3a.medium"
subnet_id             = "subnet-0123456789"
volume_type           = "gp3"
root_volume_size      = 50
vpn_port              = 1194

common_tags = {
  Project     = "ToTheNew"
  Environment = "dev"
}

security_groups = ["sg-0123456789"]
disable_api_termination = true
ebs_optimized           = true
delete_on_termination   = true
encrypted               = true
disable_api_stop        = false
source_dest_check       = true
create_aws_vpn          = false
create_aws_ec2_pritunl  = true

cidr = "172.16.0.0/16"

subnet_ids = [
  "subnet-0123456789"
]

allowed_cidr_ranges = [
  "0.0.0.0/0"
]

allowed_access_groups = []

dns_servers = ["8.8.8.8", "8.8.4.4"]

organization_name = "To The New Pvt Ltd"

tags = {
  Owner = "Dhruv"
  Purpose = "VPN Access"
}

logs_retention                   = 365
authentication_type             = "certificate-authentication"
authentication_saml_provider_arn = null
split_tunnel                    = true
security_group_id               = "sg-0123456789"
enable_self_service_portal     = false

ca_common_name      = "ToTheNew CA"
root_common_name    = "ToTheNew Root"
server_common_name  = "vpn.tothenew.internal"
