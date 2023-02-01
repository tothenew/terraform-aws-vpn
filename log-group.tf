resource "aws_cloudwatch_log_group" "vpn" {
  count       = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? 1: 0
  name              = "/aws/vpn/${var.project_name_prefix}/logs"
  retention_in_days = var.logs_retention

  tags = merge(
    var.tags,
    tomap({
      "Name"    = "${var.project_name_prefix}-Client-VPN-Log-Group",
      "EnvName" = var.project_name_prefix
    })
  )
}

resource "aws_cloudwatch_log_stream" "vpn" {
  count       = !var.create_aws_ec2_pritunl && var.create_aws_vpn ? 1: 0
  name           = "vpn-usage"
  log_group_name = aws_cloudwatch_log_group.vpn[count.index].name
}
