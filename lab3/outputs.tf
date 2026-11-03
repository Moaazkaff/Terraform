output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_id" {
  description = "The ID of the Public Subnet"
  value       = aws_subnet.public.id
}

output "public_security_group_id" {
  description = "The ID of the Public Security Group"
  value       = aws_security_group.public_sg.id
}

output "public_instance_id" {
  description = "The ID of the Public EC2 Instance"
  value       = aws_instance.lab3.id
}

output "lab3_public_ip" {
  description = "The Public IP address of the Bastion Host"
  value       = aws_instance.lab3.public_ip
}