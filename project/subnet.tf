resource "aws_subnet" "Public-1A" {
  vpc_id = aws_vpc.project.id
  cidr_block = var.public_subnet_1a_cidr

  availability_zone = var.az_1a

  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet 1a"
  }
}

resource "aws_subnet" "Private-1A" {
  vpc_id = aws_vpc.project.id
  cidr_block = var.private_subnet_1a_cidr

  availability_zone = var.az_1a


  tags = {
    Name = "private subnet 1a"
  }
}

resource "aws_subnet" "Public-1B" {
  vpc_id = aws_vpc.project.id
  cidr_block = var.public_subnet_1b_cidr

  availability_zone = var.az_1b

  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet 1b"
  }
}

resource "aws_subnet" "Private-1B" {
  vpc_id = aws_vpc.project.id
  cidr_block = var.private_subnet_1b_cidr

  availability_zone = var.az_1b


  tags = {
    Name = "private subnet 1b"
  }
}