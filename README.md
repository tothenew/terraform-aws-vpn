# terraform-aws-vpn

[![Lint Status](https://github.com/tothenew/terraform-aws-vpn/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-vpn/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-vpn)](https://github.com/tothenew/terraform-aws-vpn/blob/master/LICENSE)

This is a vpn module to use for baseline. You can use this module to setup pritunl as a vpn on an ubuntu aws ec2 instance. 

## Usage

```
module "vpn" {
  source                           = "git::https://github.com/tothenew/terraform-aws-vpn?ref=v0.0.1"
  vpc_id                           = var.vpc_id
  project_name_prefix              = var.project_name_prefix
  key_name                         = var.key_name
  instance_type                    = var.instance_type
  subnet_id                        = var.subnet_id
  volume_type                      = var.volume_type
  root_volume_size                 = var.root_volume_size
  vpn_port                         = var.vpn_port
  common_tags = {
    "Project"     = "ToTheNew",
    "Environment" = "dev"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.ca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_cloudwatch_log_group.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ec2_client_vpn_authorization_rule.all_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_authorization_rule.allow_network](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_authorization_rule.specific_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_endpoint.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_route.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route) | resource |
| [aws_eip.pritunl-eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [tls_cert_request.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_cert_request.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_locally_signed_cert.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_access_groups"></a> [allowed\_access\_groups](#input\_allowed\_access\_groups) | List of Access group IDs to allow access. Leave empty to allow all groups | `list(string)` | `[]` | no |
| <a name="input_allowed_cidr_ranges"></a> [allowed\_cidr\_ranges](#input\_allowed\_cidr\_ranges) | List of CIDR ranges from which access is allowed | `list(string)` | `[]` | no |
| <a name="input_authentication_saml_provider_arn"></a> [authentication\_saml\_provider\_arn](#input\_authentication\_saml\_provider\_arn) | (Optional) The ARN of the IAM SAML identity provider if type is federated-authentication. | `string` | `null` | no |
| <a name="input_authentication_type"></a> [authentication\_type](#input\_authentication\_type) | The type of client authentication to be used. Specify certificate-authentication to use certificate-based authentication, directory-service-authentication to use Active Directory authentication, or federated-authentication to use Federated Authentication via SAML 2.0. | `string` | `"certificate-authentication"` | no |
| <a name="input_ca_common_name"></a> [ca\_common\_name](#input\_ca\_common\_name) | n/a | `string` | `""` | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | Network CIDR to use for clients | `string` | `""` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A mapping of tags to assign to the resource | `map(string)` | n/a | yes |
| <a name="input_create_aws_ec2_pritunl"></a> [create\_aws\_ec2\_pritunl](#input\_create\_aws\_ec2\_pritunl) | n/a | `bool` | `true` | no |
| <a name="input_create_aws_vpn"></a> [create\_aws\_vpn](#input\_create\_aws\_vpn) | n/a | `bool` | `false` | no |
| <a name="input_delete_on_termination"></a> [delete\_on\_termination](#input\_delete\_on\_termination) | Whether EBS volume will be deleted when instance gets deleted. | `bool` | `true` | no |
| <a name="input_disable_api_stop"></a> [disable\_api\_stop](#input\_disable\_api\_stop) | If true, enables EC2 Instance Stop Protection. | `bool` | `false` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | If true, enables EC2 Instance Termination Protection | `bool` | `true` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of DNS Servers | `list(string)` | `[]` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `true` | no |
| <a name="input_enable_self_service_portal"></a> [enable\_self\_service\_portal](#input\_enable\_self\_service\_portal) | Specify whether to enable the self-service portal for the Client VPN endpoint | `bool` | `false` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | Whether EBS volume will be encrypted. | `bool` | `true` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start | `string` | `"t3a.medium"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource | `string` | n/a | yes |
| <a name="input_logs_retention"></a> [logs\_retention](#input\_logs\_retention) | Retention in days for CloudWatch Log Group | `number` | `365` | no |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | Name of organization to use in private certificate | `string` | `"ACME, Inc"` | no |
| <a name="input_project_name_prefix"></a> [project\_name\_prefix](#input\_project\_name\_prefix) | A string value to describe prefix of all the resources | `string` | `"dev-tothenew"` | no |
| <a name="input_root_common_name"></a> [root\_common\_name](#input\_root\_common\_name) | n/a | `string` | `""` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Root volume size of the EC2 instance | `number` | `100` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | Optional security group id to use instead of the default created | `string` | `""` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A string value for Security Group ID | `list(string)` | `[]` | no |
| <a name="input_server_common_name"></a> [server\_common\_name](#input\_server\_common\_name) | n/a | `string` | `""` | no |
| <a name="input_source_dest_check"></a> [source\_dest\_check](#input\_source\_dest\_check) | Source destination Check. Used for NAT or VPNs. | `bool` | `true` | no |
| <a name="input_split_tunnel"></a> [split\_tunnel](#input\_split\_tunnel) | With split\_tunnel false, all client traffic will go through the VPN. | `bool` | `true` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The VPC Subnet IDs to launch in | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet ID to associate clients (each subnet passed will create an VPN association - costs involved) | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Extra tags to attach to resources | `map(string)` | `{}` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Volume type for EC2 instance default latest type | `string` | `"gp3"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC Id to create resources | `string` | n/a | yes |
| <a name="input_vpn_port"></a> [vpn\_port](#input\_vpn\_port) | (Optional) The port number for the Client VPN endpoint. Valid values are 443 and 1194. Default value is 443.  In case of pritunl it can be any UDP port value set from pritunl console | `number` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-vpn/blob/main/LICENSE) for full details.
