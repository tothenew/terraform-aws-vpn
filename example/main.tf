
module "vpn" {
  source                           = "../"
  create_aws_vpn                   = true
  create_aws_ec2_pritunl           = false
  security_group_id                = var.security_group_id
  subnet_ids                       = var.subnet_ids
  vpc_id                           = var.vpc_id
  cidr                             = var.cidr
  allowed_access_groups            = var.allowed_access_groups
  allowed_cidr_ranges              = var.allowed_cidr_ranges
  project_name_prefix              = var.project_name_prefix
  ca_common_name                   = var.ca_common_name
  server_common_name               = var.server_common_name
  root_common_name                 = var.root_common_name
  split_tunnel                     = var.split_tunnel
  organization_name                = var.organization_name
  logs_retention                   = var.logs_retention
  key_name                         = var.key_name
  disable_api_stop                 = var.disable_api_stop
  vpn_port                         = var.vpn_port
  tags                             = var.tags
  authentication_saml_provider_arn = var.authentication_saml_provider_arn
  instance_type                    = var.instance_type
  source_dest_check                = var.source_dest_check
  delete_on_termination            = var.delete_on_termination
  authentication_type              = var.authentication_type
  disable_api_termination          = var.disable_api_termination
  subnet_id                        = var.subnet_id
  volume_type                      = var.volume_type
  enable_self_service_portal       = var.enable_self_service_portal
  root_volume_size                 = var.root_volume_size
  dns_servers                      = var.dns_servers
  iam_instance_profile             = var.iam_instance_profile
  ebs_optimized                    = var.ebs_optimized
  encrypted                        = var.encrypted
  common_tags = {
    "Project"     = "ToTheNew",
    "Environment" = "dev"
  }
}


