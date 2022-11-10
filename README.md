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
* OBS: When using IPV6, the VPC must also have IPV6 enabled

```hcl
module "route_table_test" {
  source        = "web-virtua-aws-multi-account-modules/route-table/aws"
  name          = "tf-route-table-test"
  has_ipv6      = true
  vpc_id        = "vpc-047c3...3d4e"
  gateway_id    = "igw-07b6ad...f0d"
  subnet_ids    = ["subnet-0097...0538"]
 
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

## Variables

| Name | Type | Default | Required | Description | Options |
|------|-------------|------|---------|:--------:|:--------|
| name | `string` | `-` | yes | Name to route table | `-` |
| vpc_id | `string` | `-` | yes | VPC ID | `-` |
| gateway_id | `string` | `-` | yes | Internet or Nat gateway ID | `-` |
| has_ipv6 | `bool` | `false` | no | If VPC has IPV6 | `*`false <br> `*`true |
| cidr_block_route_table | `string` | `0.0.0.0/0` | no | IPV4 cidr block to route table | `-` |
| cidr_block_ipv6_route_table | `string` | `::/0` | no | IPV6 cidr block to route table | `-` |
| subnet_ids | `list(string)` | `[]` | no | List within subnet IDs | `-` |
| ou_name | `string` | `no` | no | Policy of ACL | `-` |
| tags | `map(any)` | `{}` | no | Tags to bucket | `-` |


## Resources

| Name | Type |
|------|------|
| [aws_route_table.create_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.create_associate_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_egress_only_internet_gateway.create_egress_only_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/egress_only_internet_gateway) | resource |

## Outputs

| Name | Description |
|------|-------------|
| `route_table` | All informations of the route table |
| `route_table_association` | All informations of route table association |
| `egress_only_internet_gateway` | All informations of the egress only internet gateway|
