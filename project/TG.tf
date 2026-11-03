resource "aws_lb_target_group" "Target1" {
  name = "TG-1"

  target_type = "instance"

  protocol = "HTTP"

  port = 80

  ip_address_type = "ipv4"

  vpc_id = aws_vpc.project.id

  protocol_version = "HTTP1"

  health_check {
    port = 80
    protocol = "HTTP"
    path = "/"
  }
}

