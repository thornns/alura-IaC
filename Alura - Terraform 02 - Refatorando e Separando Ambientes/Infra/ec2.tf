# Busca a AMI mais recente do ubuntu na AWS
data "aws_ami" "ubuntu" {
  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# O nome do resource, alura01 NÃO É o nome da VM na AWS.
resource "aws_instance" "alura01" {
  ami = data.aws_ami.ubuntu.id
  # Se o ambiente for de produção, a EC2 é mais potente que a de dev
  instance_type          = var.ambiente == "prod" ? var.ec2-prod : var.ec2-dev
  key_name               = aws_key_pair.ChaveSSH.id
  vpc_security_group_ids = [aws_security_group.alura_ssh.id]
  # Vem da Default VPC
  subnet_id = "subnet-0a1d836f1b2d3f6de"

  tags = {
    # O Nome da VM depende dessa tag, não do nome do resource
    Name  = "Alura-01"
    Curso = "Preparando Máquinas na AWS com Ansible e Terraform"

  }
}