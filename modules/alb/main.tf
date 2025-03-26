# ALB 생성
resource "aws_lb" "this" {
  name               = var.name
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.sg_id]
  internal           = false

  tags = {
    Name = var.name
  }
}

# Listener 생성 (기본 404 응답용)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Invalid route"
      status_code  = "404"
    }
  }
}