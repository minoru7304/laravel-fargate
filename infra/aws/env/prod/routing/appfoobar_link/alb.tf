resource "aws_lb" "this" {
  count = var.enable_alb ? 1 : 0

  name = "${local.name_prefix}-appfoobar-link"

  internal           = false
  load_balancer_type = "application"

  access_logs {
    bucket  = data.terraform_remote_state.log_alb.outputs.s3_bucket_this_id
    enabled = true
    prefix  = "appfoobar-link"
  }

  security_groups = [
    data.terraform_remote_state.network_main.outputs.security_group_web_id,
    data.terraform_remote_state.network_main.outputs.security_group_vpc_id
  ]

  subnets = [
    "subnet-0fea4f842edfc355f", #minoru-saito-public-a
    "subnet-04f581eb4685b78a8"  #minoru-saito-public-c
  ]

  tags = {
    Name = "${local.name_prefix}-appfoobar-link"
  }
}

resource "aws_lb_listener" "http" {
  count = var.enable_alb ? 1 : 0

#   certificate_arn   = aws_acm_certificate.root.arn
  load_balancer_arn = aws_lb.this[0].arn
  port              = "80" #443
  protocol          = "HTTP" #HTTPS

  default_action {
    type = "forward" #fixed-response

    # fixed_response {
    #   content_type = "text/plain"
    #   message_body = "Fixed response content"
    #   status_code  = "200"
    # }

    target_group_arn = aws_lb_target_group.foobar.arn
  }
}

# resource "aws_lb_listener" "redirect_http_to_https" {
#   count = var.enable_alb ? 1 : 0

#   load_balancer_arn = aws_lb.this[0].arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

resource "aws_lb_target_group" "foobar" {
  name = "${local.name_prefix}-foobar"

  deregistration_delay = 60
  port                 = 80
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = "vpc-0be7eabe7f291ec71" # minoru-saito-vpc

  health_check {
    healthy_threshold   = 2
    interval            = 30
    matcher             = 200
    path                = "/tasks"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${local.name_prefix}-foobar"
  }
}
