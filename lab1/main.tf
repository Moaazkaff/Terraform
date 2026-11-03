resource "aws_vpc" "main" {
  cidr_block = "15.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    name = "tf-vpc"
  }
}

resource "aws_subnet" "Public-SB" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "15.0.1.0/24"

  availability_zone_id = "use1-az1"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "Private-SB" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "15.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  depends_on = [
    aws_internet_gateway.gw
  ]

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.Public-SB.id

  tags = {
    Name = "terraform-nat"
  }

  depends_on = [
    aws_internet_gateway.gw
  ]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.Public-SB.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route" "private_internet_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = aws_nat_gateway.main.id

  depends_on = [aws_nat_gateway.main]
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.Private-SB.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "Bastion-SG" {
  name        = "Bastion-SG"
  description = "Allow HTTP and SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "Bastion-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "bastion_http" {
  security_group_id = aws_security_group.Bastion-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  description = "Allow HTTP"
}

resource "aws_vpc_security_group_ingress_rule" "bastion_ssh" {
  security_group_id = aws_security_group.Bastion-SG.id
  cidr_ipv4         = "41.39.127.149/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  description = "Allow SSH"
}

resource "aws_vpc_security_group_egress_rule" "bastion_all_outbound" {
  security_group_id = aws_security_group.Bastion-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Security Group for Private EC2"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "private-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "private_ssh_from_bastion" {
  security_group_id = aws_security_group.private_sg.id

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  referenced_security_group_id = aws_security_group.Bastion-SG.id

  description = "Allow SSH from Bastion SG"
}

resource "aws_instance" "bastion_ec2" {
  ami                    = "ami-0b6d9d3d33ba97d99"
  instance_type          = "t3.micro"

  subnet_id              = aws_subnet.Public-SB.id

  vpc_security_group_ids = [
    aws_security_group.Bastion-SG.id
  ]

  key_name = "Moaaz-ED25519"

  associate_public_ip_address = true

  tags = {
    Name = "Bastion-Host"
  }
}

resource "aws_instance" "private_ec2" {
  ami                    = "ami-0b6d9d3d33ba97d99"
  instance_type          = "t3.micro"

  subnet_id              = aws_subnet.Private-SB.id

  vpc_security_group_ids = [
    aws_security_group.private_sg.id
  ]

  key_name = "Moaaz-ED25519"

  associate_public_ip_address = false

  tags = {
    Name = "Private-EC2"
  }
}