resource "aws_eip" "nat" {
  domain = "vpc"

  depends_on = [
    aws_internet_gateway.project_igw
  ]

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.Public-1B.id

  tags = {
    Name = "terraform-nat"
  }

  depends_on = [
    aws_internet_gateway.project_igw
  ]
}