# Formação DevOps - Infraestrutura como código
## Curso 04 - Docker + EBS

A desvantagem do curso anterior é que a instância demora mais a subir devido a necessidade de se autoconfigurar toda vez que sobe uma nova instância EC2.
Este curso resolve este problema usando Docker.

O arquivo .tfstate será salvo em um bucket s3 para aumentar sua disponibilidade;

Será criada uma imagem docker para a aplicação e será feito o upload para um ECR;

Criaremos um bucket s3 para subir o arquivo zip que será usado pelo Beanstalk;

Criaremos uma IAM Role para que o Beanstalk tenha apenas o necessário para funcionar;

O Elastic Beanstalk usará esta imagem para subir o ambiente automaticamente.