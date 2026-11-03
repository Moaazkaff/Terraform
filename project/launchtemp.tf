resource "aws_launch_template" "Elb_asg_temp" {
  name_prefix = "Elb-asg-temp"

  image_id = data.aws_ami.aws_linux.id

  instance_type = var.instance_type

  key_name = var.key_pair

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_s3_profile.name
  }

  vpc_security_group_ids = [
    aws_security_group.allow_traffic.id
  ]

  monitoring {
    enabled = true
  }

  user_data = filebase64("${path.module}/userdata.bash")


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "webserver"
    }
  }
}