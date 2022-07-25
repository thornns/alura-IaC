resource "aws_autoscaling_group" "grupo_escalonamento" {
  name = var.nome_grupo_ec2
  availability_zones = [ "us-east-1a" ]
  max_size = var.maximo_instancias
  min_size = var.minimo_instancias
  launch_template {
    id = aws_launch_template.elastica.id
    version = "$Latest"
  }
  # Se for de produção, precisa de load balancer, caso contrário não
  # Precisa ser [0] por conta do count.
  # Se houverem 3 targets, devemos especificar se esse grupo usará o [0] [1] ou [2]
  target_group_arns = var.producao ? [ aws_lb_target_group.loadbalancer_target[0].arn ] : []
}

resource "aws_autoscaling_policy" "politica_up" {
  autoscaling_group_name = var.nome_grupo_ec2
  # 1 se produção, 0 se não for
  count = var.producao
  name                   = "Politica de Escalonamento"
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}