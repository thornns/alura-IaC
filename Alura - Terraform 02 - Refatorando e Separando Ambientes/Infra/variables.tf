# Por não possuir um DEFAULT, será cobrado o preenchimento na hora do plan/apply.
# Para funcionar, deve ser preenchido dev ou prod
variable "ambiente" {
  type        = string
  description = "Os valores válidos são: prod, dev"

  validation {
    # condition testa se o valor está na lista de valores e retorna true ou false.
    condition     = contains(["prod", "dev"], var.ambiente)
    error_message = "Os valores válidos são: prod, dev"
  }
}

variable "regiao" {
  type        = string
  description = "Região da AWS"
  default     = "us-east-1"
}

variable "ec2-prod" {
  type        = string
  description = "O tamanho da EC2 de produção"
  default     = "t2.small"
}

variable "ec2-dev" {
  type        = string
  description = "O tamanho da EC2 de produção"
  default     = "t2.micro"
}
