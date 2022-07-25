/*
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 999898949736.dkr.ecr.us-east-1.amazonaws.com
docker tag <DOCKER_IMAGE_ID> 999898949736.dkr.ecr.us-east-1.amazonaws.com/Terraform-Alura-ECR-Producao:v1
docker push 999898949736.dkr.ecr.region.amazonaws.com/Terraform-Alura-ECR-Producao:v1
aws elasticbeanstalk update-environment --environment-name nome-do-ambiente --version-label nome-da-versão-cadastrada
*/

module "prod" {
  source = "../../Infra"
  repositorio = "repositorio_prod"
  environment = "prod"
}

output "dns_name_alb" {
  value = module.prod.aws_lb_dns_name
}