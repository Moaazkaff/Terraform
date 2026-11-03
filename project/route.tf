resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.project.id

  tags = {
    Name = "public route"
    Description = "route table that route the 0.0.0.0/0 to the igw."
  }
}

resource "aws_route_table_association" "public_association_a" {
  route_table_id = aws_route_table.public_route.id
  subnet_id = aws_subnet.Public-1A.id
}

resource "aws_route_table_association" "public_association_b" {
  route_table_id = aws_route_table.public_route.id
  subnet_id = aws_subnet.Public-1B.id
}

resource "aws_route" "route_igw" {
  route_table_id = aws_route_table.public_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.project_igw.id
}



resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.project.id

  tags = {
    Name = "private route"
    Description = "route table that route all outgoing to the nat."
  }
}

resource "aws_route_table_association" "private_association_a" {
  route_table_id = aws_route_table.private_route.id
  subnet_id = aws_subnet.Private-1A.id
}

resource "aws_route_table_association" "private_association_b" {
  route_table_id = aws_route_table.private_route.id
  subnet_id = aws_subnet.Private-1B.id
}

resource "aws_route" "route_project_nat" {
  route_table_id = aws_route_table.private_route.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
}