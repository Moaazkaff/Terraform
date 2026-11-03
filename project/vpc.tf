resource "aws_vpc" "project" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "project"
  }
}

