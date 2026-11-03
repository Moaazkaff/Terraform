resource "aws_instance" "bastion_server" {
  ami = data.aws_ami.aws_linux.id

  instance_type = var.instance_type

  key_name = var.key_pair
  
  subnet_id = aws_subnet.Public-1A.id

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]

  tags = { 
    Name = "Bastion-Host" 
  }
}