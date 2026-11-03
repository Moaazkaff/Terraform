data "aws_vpc" "main_vpc" {
  id = "vpc-09eeed92514525244"
}

data "aws_subnet" "public_subnet" {
  vpc_id = data.aws_vpc.main_vpc.id
  id = "subnet-0be4f211815722b30"
  availability_zone = "us-east-1a"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}