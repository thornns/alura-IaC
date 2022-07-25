resource "aws_lb" "loadbalancer" {
  internal = false
  subnets = [ aws_default_subnet.subnet_01.id ]
  # 1 se produção, 0 se não for
  count = var.contador
}

resource "aws_lb_target_group" "loadbalancer_target" {
  name = "Maquinas Alvo do Load Balancer"
  port = "8000"
  protocol = "HTTP"
  vpc_id = "vpc-0acd7f4d25881eadf"
  # 1 se produção, 0 se não for
  count = var.contador
}

resource "aws_lb_listener" "loadbalancer_listener" {
  load_balancer_arn = aws_lb.loadbalancer[0].arn
  port = "8000"
  protocol = "HTTP"
  # 1 se produção, 0 se não for
  count = var.contador

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.loadbalancer_target[0].arn
  }
}