# Create application load balancer

resource "aws_lb" "aws_application_lb" {
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.security_group_alb[0]]
  subnets                    = tolist(var.public_subnets)
  enable_deletion_protection = false

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-alb"
  })
}

# Create target group for ALB

resource "aws_lb_target_group" "alb_target_group" {
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 10
    path                = "/"
    timeout             = 5
    matcher             = 200
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-alb-tg"
  })
}


# Create a listener on port 80

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.aws_application_lb.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.id
  }
}


# Target Group Attachment

resource "aws_lb_target_group_attachment" "tgattachment" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = element(var.instance_ids, count.index)
}