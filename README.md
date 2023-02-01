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

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-vpn/blob/main/LICENSE) for full details.
