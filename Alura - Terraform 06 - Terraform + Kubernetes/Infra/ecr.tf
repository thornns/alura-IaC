/*
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 999898949736.dkr.ecr.us-east-1.amazonaws.com
docker tag <DOCKER_IMAGE_ID> 999898949736.dkr.ecr.us-east-1.amazonaws.com/Terraform-Alura-ECR-Producao:v1
docker push 999898949736.dkr.ecr.region.amazonaws.com/Terraform-Alura-ECR-Producao:v1
*/

resource "aws_ecr_repository" "repositorio" {
  name = var.repositorio

  image_scanning_configuration {
    scan_on_push = true
  }
}