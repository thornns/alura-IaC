resource "aws_key_pair" "ChaveSSH" {
  key_name = "Customizada"
  # Se o ambiente for de Prod, vai buscar a chave de PROD, caso contrário vai ser a chave de DEV
  public_key = var.ambiente == "prod" ? file("../Environment/Prod/iaC-Prod.pub") : file("../Environment/Dev/iaC-Dev.pub")
}
