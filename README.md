# AWS Route table for multiples accounts and regions Terraform module
* This module simplifies creating and configuring Route Tables across multiple accounts and regions on AWS

* Is possible use this module with one region using the standard profile or multi account and regions using multiple profiles setting in the modules.

## Actions necessary to use this module:

* Create file versions.tf with the exemple code below:
```hcl
terraform {
  required_version = ">= 1.3.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }
  }
}
```

* Criate file provider.tf with the exemple code below:
```hcl
provider "aws" {
  alias   = "alias_profile_a"
  region  = "us-east-1"
  profile = "my-profile"
}

provider "aws" {
  alias   = "alias_profile_b"
  region  = "us-east-2"
  profile = "my-profile"
}
```


## Features enable of route table configurations for this module:

- Route Table IPV4 and or IPV6
- Configuration with Internet Gateway or Nat Gateway
- Associate with one or more subnets

## Usage exemples

### Route table configured with IPV4 and IPV6
* OBS: When using IPV6, the VPC must also have IPV6 enabled and egress_only_internet_gateway_id must be set

```hcl
module "route_table_test" {
  source                         = "web-virtua-aws-multi-account-modules/route-table/aws"
  name                           = "tf-route-table-test"
  vpc_id                         = "vpc-047c3...3d4e"
  gateway_id                     = "igw-07b6a...fh0d"
  egress_only_internet_gateway_id = "eigw-0b03...fba6"
  subnet_ids                     = ["subnet-0097...0538"]
 
  providers = {
    aws = aws.alias_profile_b
  }
}
```

### Route table configured with IPV4

```hcl
module "route_table_test" {
  source        = "web-virtua-aws-multi-account-modules/route-table/aws"
  name          = "tf-route-table-test"
  vpc_id        = "vpc-047c3...3d4e"
  gateway_id    = "igw-07b6ad...f0d"
  subnet_ids    = ["subnet-0097...0538"]
 
  providers = {
    aws = aws.alias_profile_b
  }
}
```

### Route table configured with IPV4 and multiples routes

```hcl
module "route_table_test_multiples_routes" {
  source                         = "web-virtua-aws-multi-account-modules/route-table/aws""
  name                           =  "tf-route-table-test"
  vpc_id                         = "vpc-047c3...3d4e"
  egress_only_internet_gateway_id = "eigw-0b03...fba6"
  gateway_id                     = "nat-0f2re...ae49"
  subnet_ids                     = ["subnet-0097...0538"]
  cidr_block_route_table         = "10.0.0.0/16"
  custom_routes = [
    {
      cidr_block = "192.168.1.0/24"
      gateway_id = "eigw-0b03...fba6"
    }
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

## Variables

| Name | Type | Default | Required | Description | Options |
|------|-------------|------|---------|:--------:|:--------|
| name | `string` | `-` | yes | Name to route table | `-` |
| vpc_id | `string` | `-` | yes | VPC ID | `-` |
| gateway_id | `string` | `-` | yes | Internet or Nat gateway ID | `-` |
| egress_only_internet_gateway_id | `string` | `null` | no | If VPC has IPV6 set egress only internet gatewa ID | `-` |
| cidr_block_route_table | `string` | `0.0.0.0/0` | no | IPV4 cidr block to route table | `-` |
| cidr_block_ipv6_route_table | `string` | `::/0` | no | IPV6 cidr block to route table | `-` |
| subnet_ids | `list(string)` | `[]` | no | List within subnet IDs | `-` |
| custom_routes | `list(object)` | `[]` | no | List with customized routes to configure in route table | `-` |
| ou_name | `string` | `no` | no | Policy of ACL | `-` |
| tags | `map(any)` | `{}` | no | Tags to bucket | `-` |

* Model of custom_routes variable
```hcl
variable "custom_routes" {
  description = "List with customized routes to configure in route table"
  type = list(object({
    cidr_block                 = string
    ipv6_cidr_block            = optional(string)
    destination_prefix_list_id = optional(string)
    carrier_gateway_id         = optional(string)
    core_network_arn           = optional(string)
    egress_only_gateway_id     = optional(string)
    gateway_id                 = optional(string)
    local_gateway_id           = optional(string)
    nat_gateway_id             = optional(string)
    network_interface_id       = optional(string)
    transit_gateway_id         = optional(string)
    vpc_endpoint_id            = optional(string)
    vpc_peering_connection_id  = optional(string)
  }))
  default = [
    {
      cidr_block = "192.168.1.0/24"
      gateway_id = "eigw-0b03...fba6"
    }
  ]
}
```


## Resources

| Name | Type |
|------|------|
| [aws_route_table.create_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.create_associate_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |

## Outputs

| Name | Description |
|------|-------------|
| `route_table` | All informations of the route table |
| `route_table_association` | All informations of route table association |
