#--------modules/loadbalancer/main.tf------

 resource "aws_lb" "wp_lb" {
  name                       = "projectalb"
  internal                   = false 
  load_balancer_type         = var.lb_type
  security_groups            = [var.lb_sg]
  subnets                    = var.public_subnets
  enable_deletion_protection = false 

    tags = {
    Environment = "cfproject"
  }
}

resource "aws_lb_listener" "wp_lb_listener" {
  load_balancer_arn = aws_lb.wp_lb.arn
  port              = var.listener_port
  protocol          = var.tg_protocol
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.certificate_arn
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wp_lb_tg.arn
  }
}

resource "aws_lb_target_group" "wp_lb_tg" {
  name     = "webapp-target-group"
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id
  
  health_check {
    healthy_threshold   = var.lb_healthy_threshold
    unhealthy_threshold = var.lb_unhealthy_threshold
    timeout             = var.lb_timeout
    interval            = var.lb_interval
    protocol            = var.tg_protocol
    port                = var.tg_port
  }
}





