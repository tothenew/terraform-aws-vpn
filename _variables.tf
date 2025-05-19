variable "subnet_id" {
  description = "The VPC Subnet IDs to launch in"
  type        = string
}

variable "security_groups" {
  description = "A string value for Security Group ID"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
}

variable "project_name_prefix" {
  description = "A string value to describe prefix of all the resources"
  type        = string
  default     = "dev-tothenew"
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = true
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = true
}
variable "common_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}

variable "delete_on_termination" {
  description = "Whether EBS volume will be deleted when instance gets deleted."
  type        = bool
  default     = true
}

variable "encrypted" {
  description = "Whether EBS volume will be encrypted."
  type        = bool
  default     = true
}

variable "volume_type" {
  description = "Volume type for EC2 instance default latest type"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "Root volume size of the EC2 instance"
  type        = number
  default     = 100
}

variable "disable_api_stop" {
  description = "If true, enables EC2 Instance Stop Protection."
  type        = bool
  default     = false
}

variable "source_dest_check" {
  description = "Source destination Check. Used for NAT or VPNs."
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3a.medium"
}


variable "create_aws_vpn" {
  type    = bool
  default = false
}
variable "create_aws_ec2_pritunl" {
  type    = bool
  default = true
}
# variable "name" {
#   description = "Name prefix for the resources of this stack"
# }

variable "cidr" {
  description = "Network CIDR to use for clients"
  default     = ""
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ID to associate clients (each subnet passed will create an VPN association - costs involved)"
  default     = []
}

variable "allowed_cidr_ranges" {
  type        = list(string)
  description = "List of CIDR ranges from which access is allowed"
  default     = []
}

variable "allowed_access_groups" {
  type        = list(string)
  description = "List of Access group IDs to allow access. Leave empty to allow all groups"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC Id to create resources"
}
variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "List of DNS Servers"
}

variable "organization_name" {
  description = "Name of organization to use in private certificate"
  default     = "ACME, Inc"
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags to attach to resources"
}

variable "logs_retention" {
  default     = 365
  description = "Retention in days for CloudWatch Log Group"
  type        = number
}

variable "authentication_type" {
  type        = string
  default     = "certificate-authentication"
  description = "The type of client authentication to be used. Specify certificate-authentication to use certificate-based authentication, directory-service-authentication to use Active Directory authentication, or federated-authentication to use Federated Authentication via SAML 2.0."
}

variable "authentication_saml_provider_arn" {
  type        = string
  default     = null
  description = "(Optional) The ARN of the IAM SAML identity provider if type is federated-authentication."
}

variable "split_tunnel" {
  type        = bool
  default     = true
  description = "With split_tunnel false, all client traffic will go through the VPN."
}

variable "security_group_id" {
  type        = string
  default     = ""
  description = "Optional security group id to use instead of the default created"
}

variable "enable_self_service_portal" {
  type        = bool
  default     = false
  description = "Specify whether to enable the self-service portal for the Client VPN endpoint"
}

variable "vpn_port" {
  type        = number
  default     = null
  description = " (Optional) The port number for the Client VPN endpoint. Valid values are 443 and 1194. Default value is 443.  In case of pritunl it can be any UDP port value set from pritunl console"
}

variable "ca_common_name" {
  default = ""
  type    = string
}

variable "root_common_name" {
  default = ""
  type    = string
}

variable "server_common_name" {
  default = ""
  type    = string
}

