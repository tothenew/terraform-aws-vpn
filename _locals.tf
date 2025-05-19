locals {
  self_service_portal = var.enable_self_service_portal && var.create_aws_vpn == true ? "enabled" : "disabled"
}
