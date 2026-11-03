variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "The specific Availability Zone for the subnet"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type for the Bastion Host"
  type        = string
}

variable "key_pair_name" {
  description = "The name of the SSH key pair to attach to the instance"
  type        = string
}

variable "allowed_ssh_ip" {
  description = "The IP address (with CIDR notation) allowed to SSH into the Bastion"
  type        = string
}