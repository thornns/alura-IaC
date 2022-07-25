# Formação DevOps - Infraestrutura como código
## Curso 02 - Refatorando e Separando Ambientes

Semelhante ao curso 01, porém refatorando o código e separando ambientes (Dev e Produção)

A maior diferença aqui é a separação dos arquivos para maior legibilidade e o uso de módulos separando os ambientes.

- 01 máquina virtual AWS

    - Chave SSH customizada pelo Terraform, com cada ambiente tendo sua própria chave
    - Grupo de Segurança separado, criado pelo Terraform


- Configuração via Ansible

    - Instalação de Python3
    - Instalação das dependências da aplicação
    - Inicialização da Aplicação na porta 8080