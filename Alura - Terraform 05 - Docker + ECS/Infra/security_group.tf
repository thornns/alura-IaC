resource "aws_security_group" "app_loadbalancer" {
  name = "alb_ecs"
  description = "Grupo de Segurança para o Application Load Balancer para o ECS"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group" "privado" {
  name = "privado_ecs"
  description = "Grupo de Segurança para o Application Load Balancer para o ECS"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ingress_app_lb" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "TCP"
  security_group_id = aws_security_group.app_loadbalancer.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_app_lb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.app_loadbalancer.id
  cidr_blocks = ["0.0.0.0/0"]
}

######################################################################################

resource "aws_security_group_rule" "entrada_privada" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.privado.id
  source_security_group_id = aws_security_group.app_loadbalancer.id
}

resource "aws_security_group_rule" "saida_privada" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.privado.id
  cidr_blocks = ["0.0.0.0/0"]
}