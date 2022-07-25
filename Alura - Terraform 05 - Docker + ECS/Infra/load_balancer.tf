resource "aws_lb" "loadbalancer" {
  name = "ecs-django"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.app_loadbalancer.id]
  subnets = module.vpc.public_subnets
}

resource "aws_lb_target_group" "loadbalancer_target" {
  name = "ecs-django"
  port = "8000"
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = [module.vpc.vpc_id]
}

resource "aws_lb_listener" "loadbalancer_listener" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port = "8000"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.loadbalancer_target.arn
  }
}

output "aws_lb_dns_name" {
  value = aws_lb.loadbalancer.dns_name
}