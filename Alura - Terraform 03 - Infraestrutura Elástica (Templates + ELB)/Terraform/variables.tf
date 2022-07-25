variable "minimo_instancias" {
  type = number
  description = "Número mínimo de instâncias sempre disponíveis"
}

variable "maximo_instancias" {
  type = number
  description = "Número máximo de instâncias que podem existir simultaneamente"
}

variable "nome_grupo_ec2" {
  type = string
  description = "Nome do grupo de instâncias"
}

variable "producao" {
  type = bool
  default = true
}

variable "contador" {
  type = number
  default = var.producao ? 1 : 0
}