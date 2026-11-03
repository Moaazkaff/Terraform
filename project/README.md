# AWS Web Application Infrastructure

This directory contains a Terraform configuration for a small, two Availability Zone web tier on AWS. It creates a VPC, public and private subnets, an internet gateway, a NAT gateway, an Application Load Balancer, an Auto Scaling group, and a bastion host.

## Architecture

- The public subnets host the internet-facing Application Load Balancer and the bastion host.
- The load balancer listens on HTTP port 80 and forwards requests to web instances in the private subnets.
- The Auto Scaling group starts with two instances, can grow to four, and uses ALB requests per target for target tracking.
- Both private subnets share one NAT gateway in public subnet 1B for outbound internet access.
- The web instances run Amazon Linux 2023 and Apache. The page displays the instance's Availability Zone.
- A versioned S3 bucket and an EC2 IAM role are created. The role currently has the AWS-managed `AmazonS3FullAccess` policy attached.

The ALB access logging configuration is commented out, so the S3 bucket is not currently configured as an ALB access-log destination. The ALB serves HTTP only; no HTTPS listener or TLS certificate is configured.

## Requirements

- Terraform 1.x
- AWS credentials available through the AWS CLI profile or standard AWS environment variables
- An EC2 key pair in the target AWS region
- Two Availability Zones in the selected region
- A globally unique name for the S3 bucket configured in `s3.tf`

## Configure

From this directory, create a local `terraform.tfvars` file. The root `.gitignore` excludes `*.tfvars`, so your local values are not committed by default.

```hcl
region                  = "us-east-1"
az_1a                   = "us-east-1a"
az_1b                   = "us-east-1b"
vpc_cidr                = "10.0.0.0/16"
public_subnet_1a_cidr   = "10.0.1.0/24"
private_subnet_1a_cidr  = "10.0.2.0/24"
public_subnet_1b_cidr   = "10.0.3.0/24"
private_subnet_1b_cidr  = "10.0.4.0/24"
my_ip                   = "203.0.113.10/32"
key_pair                = "my-ec2-keypair"
instance_type           = "t3.micro"
```

Replace the example region, Availability Zones, and public IP with values valid for your AWS account. Set `my_ip` to your public IPv4 address in CIDR notation (usually `/32`). Keep all subnet CIDRs distinct and inside `vpc_cidr`. The fixed bucket name in `s3.tf` must be available globally; change it there if it is already taken.

## Deploy

```sh
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

After applying, find the load balancer's DNS name in the AWS EC2 console under **Load Balancers**, then open `http://<load-balancer-dns-name>` in a browser. There are no Terraform output blocks in this configuration yet.

To remove the infrastructure:

```sh
terraform destroy
```

The S3 bucket has `force_destroy = true`; destroying the stack can permanently delete its objects and all object versions. The NAT gateway and other provisioned AWS resources can incur charges while they exist.

## Files

| File | Purpose |
| --- | --- |
| `provider.tf`, `variables.tf`, `data.tf` | AWS provider, required inputs, and latest Amazon Linux 2023 AMI lookup |
| `vpc.tf`, `subnet.tf`, `igw.tf`, `nat.tf`, `route.tf` | VPC networking, subnets, gateways, and routes |
| `SG.tf`, `jumpserver.tf` | Security groups and bastion host |
| `TG.tf`, `lb.tf`, `launchtemp.tf`, `asg.tf`, `userdata.bash` | Load balancing and the auto-scaled Apache web tier |
| `iam.tf`, `s3.tf` | EC2 IAM role, instance profile, and versioned S3 bucket |

## Security notes

- HTTP is allowed from any IPv4 address. The security group also allows SSH from the first public subnet to resources using the web security group.
- Bastion SSH access is restricted by `my_ip`; keep this set to a trusted address.
- The EC2 role has `AmazonS3FullAccess`. Reduce this to the minimum required permissions before using the stack for workloads that need tighter access controls.
- Keep Terraform state, variable files, private keys, and other credentials out of version control. Terraform state can contain sensitive infrastructure data.
