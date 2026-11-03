resource "aws_security_group" "public_sg" {
  name = "public-sg"
  description = "Allow local ip to connect using ssh."
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Public-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4 = var.allowed_ssh_ip
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "outbound" {
  security_group_id = aws_security_group.public_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = -1
}