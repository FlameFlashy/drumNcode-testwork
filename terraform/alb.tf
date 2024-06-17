# ALB
resource "aws_lb" "drumncode_alb" {
  name               = "ecs-drumncode-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.drumncode_vpc.id]
  subnets            = [aws_subnet.drumncode_vpc[0].id, aws_subnet.drumncode_vpc[1].id]
}

resource "aws_lb_target_group" "laravel" {
  name        = "laravel"
  port        = 9000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.drumncode_vpc.id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

# Listener for laravel
resource "aws_lb_listener" "laravel" {
  load_balancer_arn = aws_lb.drumncode_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.laravel.arn
  }
}
