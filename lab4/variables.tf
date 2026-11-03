variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
}

variable "bucket_name" {
  description = "The globally unique name for the S3 bucket"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type (e.g., t3.micro)"
  type        = string
}

variable "key_pair_name" {
  description = "The name of the existing AWS Key Pair to attach to the EC2 instance"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "The CIDR block allowed to connect via SSH to the instance (e.g., your public IP)"
  type        = string
}

variable "project_name" {
  description = "The name of the project, used for resource tagging and naming prefixes"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod, staging)"
  type        = string
}