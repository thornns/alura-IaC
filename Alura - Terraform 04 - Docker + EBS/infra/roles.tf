resource "aws_iam_role" "beanstalk_ec2" {
  name = "beanstalk-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2022-07-18"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "beanstalk_ec2_policy" {
  name = "beanstalk-ec2-policy"
  role = aws_iam_role.beanstalk_ec2.id

  policy = jsonencode({
    Version = "2022-07-18"
    Statement = [
      {
        Action = [
          # colocar informações de métrica no cloudwatch
          "cloudwatch:PutMetricData",
          # Cria um objeto com a descrição de uma máquina
          "ds:CreateComputer",
          # Obtém informações sobre os diretórios que pertencem à conta
          "ds:DescribeDirectories",
          #  Pode verificar o status de uma instância especificada ou de todas as instâncias disponiveis
          "ec2:DescribeInstanceStatus",
          # Beanstalk utiliza os vários logs gerados para poder decidir como ele deve agir
          "logs:*",
          # Systems Manager é uma ferramenta para aplicarmos correções nas máquinas criadas e automatizar tarefas em geral
          "ssm:*",
          # Garante o envio de 6 tipos de mensagens entre máquinas, sendo eles: confirmação, apagar, falha, obter o endpoint, obter mensagens e enviar respostas
          "ec2messages:*",
          # Esse token funciona como credenciais de autorização do IAM e pode ser utilizado para acessar os recursos do Amazon ECR
          "ecr:GetAuthorizationToken",
          # Verifica a existência de uma ou mais layers de imagens no repositório
          "ecr:BatchCheckLayerAvailability",
          # Retorna um link do S3 (onde a Amazon guarda os arquivos) que direciona para os layers da imagem
          "ecr:GetDownloadUrlForLayer",
          # Retorna as permisões do repositório desejado
          "ecr:GetRepositoryPolicy",
          # Retorna informações do repositório, como data da criação, tipo de criptografia ...
          "ecr:DescribeRepositories",
          # Retorna uma lista com todas as imagens dentro do repositório
          "ecr:ListImages",
          # Retorna metadados das imagens no repositório, como data da criação da imagem, tamanho da imagem ...
          "ecr:DescribeImages",
          # Obtém informações detalhadas de uma imagem em específico e retorna um manifesto com as configurações
          "ecr:BatchGetImage",
          # S3 é onde vamos guardar os dados para a nossa aplicação, sendo assim o benastalk tem que ter acesso
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "beanstalk_ec2_profile" {
  name = "beanstalk-ec2-profile"
  role = aws_iam_role.beanstalk_ec2.name
}