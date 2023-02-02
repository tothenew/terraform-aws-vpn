resource "aws_security_group" "default" {
  count       = var.security_group_id == "" ? 1 : 0
  name_prefix = "${var.project_name_prefix}-Client-VPN"
  description = "security group allowing egress for client-vpn users"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = var.vpn_port
    protocol    = "udp"
    to_port     = var.vpn_port
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "all"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name               = "${var.project_name_prefix}-Client-VPN"
    EnvName            = var.project_name_prefix
    Service            = "client-vpn"
    TerraformWorkspace = terraform.workspace
  }
}

# resource "aws_security_group_rule" "default_egress_world" {
#   count             = var.security_group_id == "" ? 1 : 0
#   type              = "egress"
#   from_port         = -1
#   to_port           = -1
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.default[0].id
# }
