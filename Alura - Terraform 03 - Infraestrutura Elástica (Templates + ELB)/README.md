# Formação DevOps - Infraestrutura como código
## Curso 03 - Infraestrutura Elástica

Aprendizado focado em infraestrutura elástica, pensando na redução de custos e uso de balanceamento de carga.
Usei Templates, Load Balancers e Ansible para autoconfiguração das instâncias EC2

É usado um template Ubuntu Latest que, durante a inicialização usa o arquivo ansible.sh para se autoconfigurar
e já estar pronto para uso.

A quantidade de instâncias EC2 depende das variáveis:

```
variable "minimo_instancias" {
type = number
description = "Número mínimo de instâncias sempre disponíveis"
}

variable "maximo_instancias" {
type = number
description = "Número máximo de instâncias que podem existir simultaneamente"
}
```