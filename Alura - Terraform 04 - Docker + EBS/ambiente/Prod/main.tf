module "producao" {
  source = "../../infra/"
  reponame = "Terraform-Alura-ECR-Producao"
  ec2Size = "t2.micro"
  ec2SizeMaximo = 3
}