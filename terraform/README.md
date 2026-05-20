# Week 9 – Advanced Terraform

## Modules

### modules/vpc
Creates a VPC with public and private subnets, internet gateway, and route tables.

| Input | Description |
|---|---|
| `vpc_name` | Name of the VPC |
| `vpc_cidr` | CIDR block for the VPC |
| `public_subnet_cidrs` | List of public subnet CIDRs |
| `private_subnet_cidrs` | List of private subnet CIDRs |
| `availability_zones` | List of AZs |
| `tags` | Tags to apply |

| Output | Description |
|---|---|
| `vpc_id` | VPC ID |
| `vpc_cidr` | VPC CIDR block |
| `public_subnet_ids` | List of public subnet IDs |
| `private_subnet_ids` | List of private subnet IDs |
| `internet_gateway_id` | Internet Gateway ID |

### modules/ec2
Creates an EC2 instance with a dynamic security group.

| Input | Description |
|---|---|
| `instance_name` | Name tag for the instance |
| `instance_type` | EC2 instance type (t2/t3 family only) |
| `allowed_ports` | List of inbound ports (1–65535) |
| `vpc_id` | VPC ID |
| `subnet_id` | Subnet ID |
| `tags` | Tags to apply |

| Output | Description |
|---|---|
| `instance_id` | EC2 instance ID |
| `public_ip` | Public IP address |
| `public_dns` | Public DNS name |
| `security_group_id` | Security group ID |

### modules/rds
Creates a PostgreSQL RDS instance in private subnets.

| Input | Description |
|---|---|
| `db_identifier` | RDS instance identifier |
| `instance_class` | RDS instance class |
| `db_username` | Master username (sensitive) |
| `db_password` | Master password (sensitive) |
| `vpc_id` | VPC ID |
| `subnet_ids` | List of private subnet IDs |
| `tags` | Tags to apply |

| Output | Description |
|---|---|
| `db_endpoint` | RDS endpoint (sensitive) |
| `db_port` | RDS port |
| `db_identifier` | RDS identifier |

## How to Run

```bash
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

## Workspaces

```bash
terraform workspace new dev
terraform workspace select dev
terraform apply
```
