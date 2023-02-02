resource "aws_ec2_client_vpn_endpoint" "default" {
  count       = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? 1: 0
  description            = "${var.project_name_prefix}-Client-VPN"
  server_certificate_arn = aws_acm_certificate.server[count.index].arn
  client_cidr_block      = var.cidr
  split_tunnel           = var.split_tunnel
  dns_servers            = var.dns_servers
  self_service_portal    = local.self_service_portal
  vpn_port               = var.vpn_port

  authentication_options {
    type                       = var.authentication_type
    root_certificate_chain_arn = var.authentication_type != "certificate-authentication" ? null : aws_acm_certificate.server[count.index].arn
    saml_provider_arn          = var.authentication_saml_provider_arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn[count.index].name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn[count.index].name
  }

  tags = merge(
    var.tags,
    tomap({
      "Name"    = "${var.project_name_prefix}-Client-VPN",
      "EnvName" = var.project_name_prefix
    })
  )
}

resource "aws_ec2_client_vpn_route" "example" {
  count                  = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? length(var.subnet_ids): 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default[0].id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = element(var.subnet_ids, count.index)
  
  timeouts {
    create = "1h30m"
    delete = "20m"
  }
}


resource "aws_ec2_client_vpn_network_association" "default" {
  count                  = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? length(var.subnet_ids): 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default[0].id
  subnet_id              = element(var.subnet_ids, count.index)
  security_groups        = [var.security_group_id == "" ? aws_security_group.default[0].id : var.security_group_id]
}

resource "aws_ec2_client_vpn_authorization_rule" "all_groups" {
  count                  = !var.create_aws_ec2_pritunl && var.create_aws_vpn && length(var.allowed_access_groups) > 0 ? 0 : length(var.allowed_cidr_ranges)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default[0].id
  target_network_cidr    = var.allowed_cidr_ranges[count.index]
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "allow_network" {
  count                  = !var.create_aws_ec2_pritunl && var.create_aws_vpn && length(var.allowed_access_groups) > 0 ? 0 : length(var.allowed_cidr_ranges)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default[0].id
  target_network_cidr    = "0.0.0.0/0"
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "specific_groups" {
  count                  = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? length(var.allowed_access_groups) * length(var.allowed_cidr_ranges):0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default[0].id
  target_network_cidr    = element(var.allowed_cidr_ranges, count.index)
  access_group_id        = var.allowed_access_groups[count.index % length(var.allowed_cidr_ranges)]
}
