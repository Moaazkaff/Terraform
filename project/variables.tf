variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "az_1a" {
  description = "Availability Zone 1A"
  type        = string
}

variable "az_1b" {
  description = "Availability Zone 1B"
  type        = string
}

variable "public_subnet_1a_cidr" {
  description = "CIDR block for Public Subnet 1A"
  type        = string
}

variable "private_subnet_1a_cidr" {
  description = "CIDR block for Private Subnet 1A"
  type        = string
}

variable "public_subnet_1b_cidr" {
  description = "CIDR block for Public Subnet 1B"
  type        = string
}

variable "private_subnet_1b_cidr" {
  description = "CIDR block for Private Subnet 1B"
  type        = string
}

variable "region" {
  description = "region"
  type = string
}

variable "my_ip" {
  description = "my-ip"
  type = string
}

variable "key_pair" {
  description = "Key pair"
  type = string
}

variable "instance_type" {
  description = "instance type"
  type = string
}