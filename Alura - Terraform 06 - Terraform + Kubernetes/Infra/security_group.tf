resource "aws_security_group" "ssh_cluster" {
  name = "ssh_eks"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group" "privado" {
  name = "privado_ecs"
  description = "Grupo de Segurança para o Application Load Balancer para o ECS"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ingress_ssh_cluster" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  security_group_id = aws_security_group.ssh_cluster.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_ssh_cluster" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.ssh_cluster.id
  cidr_blocks = ["0.0.0.0/0"]
}

######################################################################################

resource "aws_security_group_rule" "entrada_privada" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.privado.id
  source_security_group_id = aws_security_group.ssh_cluster.id
}

resource "aws_security_group_rule" "saida_privada" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.privado.id
  cidr_blocks = ["0.0.0.0/0"]
}