resource "aws_autoscaling_group" "asg" {
  name = "web-asg"
  desired_capacity = 2
  min_size = 2
  max_size = 4

  
  
  launch_template {
    id = aws_launch_template.Elb_asg_temp.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.Target1.arn
  ]

  vpc_zone_identifier = [ aws_subnet.Private-1A.id , aws_subnet.Private-1B.id ]

  
}

resource "aws_autoscaling_policy" "request_count_per_target" {
  name = "web-request-scaling"
  autoscaling_group_name = aws_autoscaling_group.asg.name

  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"

      resource_label = "${aws_lb.ELB.arn_suffix}/${aws_lb_target_group.Target1.arn_suffix}"
    }
    target_value = 60.0
  }
}
