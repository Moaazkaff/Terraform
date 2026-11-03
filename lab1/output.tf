output "bastion_public_ip" {
  value = aws_instance.bastion_ec2.public_ip
}

output "private_instance_ip" {
  value = aws_instance.private_ec2.private_ip
}