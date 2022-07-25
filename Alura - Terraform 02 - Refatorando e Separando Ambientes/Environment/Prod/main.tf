# Outra forma de fazer seria esta:
# terraform init aqui neste diretorio (não esquecer do init lá no diretorio de infra)
# terraform plan e apply aqui neste diretório.
# o terraform iria no diretório de infra buscar as configurações mas usarias as variáveis aqui embaixo:

# Vai ficar comentado pois não quero usar assim. É apenas para registro.
/*
module "aws-prod" {
  source   = "../../Infra"
  ambiente = "prod"         # Obrigatória, por não possuir valor default em infra/variables.tf
  regiao   = "us-west-1"    # Opcional
  ec2-dev  = "t2.small"     # Opcional
}

output "ip_publico_prod" {
  value    = module.aws-prod.public_ip
}*/
