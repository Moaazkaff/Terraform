resource "aws_instance" "ec2" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id = data.aws_subnet.public_subnet.id

  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.instances_profile.name
     
  vpc_security_group_ids = [ 
    aws_security_group.main-sg.id
   ]

   key_name = var.key_pair_name
    

}