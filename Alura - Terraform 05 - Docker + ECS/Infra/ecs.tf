module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
  name = "${var.environment}-ecs"
  container_insights = true

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy = [{
    capacity_provider = "FARGATE"
  }]

  tags = {
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                = "Django-API"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256 # 1/4 de CPU
  memory = 512 # 0.5 GB
  execution_role_arn = aws_iam_role.a.arn
  container_definitions = jsondecode([{
    name = var.environment
    image = "999898949736.dkr.ecr.us-east-1.amazonaws.com/Terraform-Alura-ECR-Producao:v1"
    cpu = 256
    memory = 512
    essential = true
    portMappings = [{
      containerPort = 8000
      hostPort = 8000
    }]
  }])
}

resource "aws_ecs_service" "ecs_service" {
  name = "Django-API"
  cluster = module.ecs.ecs_cluster_id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count = 3
  iam_role = aws_iam_role.a.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.loadbalancer_target.arn
    container_name = var.environment
    container_port = 8000
  }

  network_configuration {
    subnets = module.vpc.private_subnets
    security_groups = [aws_security_group.privado.id]
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight = 1
  }
}