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

resource "aws_default_subnet" "subnet_01" {
  availability_zone = "us-east-1a"
}

# O nome do resource, elastica NÃO É o nome do template na AWS.
resource "aws_launch_template" "elastica" {
  image_id = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "alura"
  security_group_names = [aws_security_group.alura.id]
  # Vem da Default VPC
  subnet_id = aws_default_subnet.subnet_01.id

  # Script de autoconfiguração da máquina (ansible playbook)
  user_data = filebase64("ansible.sh")

  tags = {
    # O Nome do template depende dessa tag, não do nome do resource
    Name  = "Alura-01-Template"
    Curso = "Preparando Máquinas na AWS com Ansible e Terraform"

  }
}

# Criando uma EC2 baseada no template
/*
resource "aws_instance" "alura01"{
  launch_template {
    id      = aws_launch_template.elastica.id
    version = "$Latest"
  }
}*/
