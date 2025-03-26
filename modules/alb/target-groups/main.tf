resource "aws_lb_target_group" "this" {
  for_each = var.target_groups

  name     = "${each.key}-service-tg"
  port     = each.value.port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = each.value.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "${each.key}-service-tg"
  }
}
