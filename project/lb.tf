resource "aws_lb" "ELB" {
  name = "elb-asg"
  
  load_balancer_type = "application"

  internal = false

  ip_address_type = "ipv4"

  security_groups = [ 
    aws_security_group.allow_traffic.id
   ]

   subnets = [ aws_subnet.Public-1A.id , aws_subnet.Public-1B.id ]

#    access_logs {
#      bucket = 
#      prefix = "project-lb"
#      enabled = true
#    }

   tags = {
     Environment = "production"
   }
}

resource "aws_lb_listener" "listner" {
  load_balancer_arn = aws_lb.ELB.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"

    forward {
      target_group {
        arn = aws_lb_target_group.Target1.arn
        weight = 100
      }
    }
  }
}