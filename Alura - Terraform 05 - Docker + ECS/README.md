# Formação DevOps - Infraestrutura como código
## Curso 05 - Docker + ECS

Parecido com o curso anterior, criaremos uma imagem docker, subiremos para o ECR,
teremos nosso backend em um bucket S3 e criaremos uma IAM Role para limitar
o ambiente com o mínimo necessário para o funcionamento

Criaremos redes privadas usando um NAT Gateway e
redes públicas, onde o load balancer estará ouvindo para repassar às redes privadas.

Porém, usaremos o Elastic Container Service ao invés do Beanstalk.