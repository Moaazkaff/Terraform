resource "aws_instance" "lab3" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

    subnet_id = aws_subnet.public.id

    vpc_security_group_ids = [
        aws_security_group.public_sg.id
    ]

  key_name = var.key_pair_name

  associate_public_ip_address = true

  tags = {
    Name = "lab3"
  }

}