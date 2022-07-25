provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_ami" "ubuntu" {
  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_security_group" "alura_ssh" {

  name   = "alura_ssh"
  vpc_id = "vpc-0acd7f4d25881eadf"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  # Web
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  # Allow ALL egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# O nome do resource, alura01 NÃO É o nome da VM na AWS.
resource "aws_instance" "alura01" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "alura"
  #vpc_security_group_ids = ["sg-0ec729c4693f0580b"]
  vpc_security_group_ids = [aws_security_group.alura_ssh.id]
  subnet_id              = "subnet-0a1d836f1b2d3f6de"

  # Esse bloco abaixo é melhor feito com ANSIBLE, mas bom saber que é possível
  /*
    user_data = <<-EOF
                   #!/bin/bash
                   cd /home/ubuntu
                   echo "<h1>Olá Mundo</h1>" > index.html
                   busybox httpd -f -p 8080
                   EOF
  */

  tags = {
    # O Nome da VM depende dessa tag, não do nome do resource
    Name  = "Alura-01"
    Curso = "Preparando Máquinas na AWS com Ansible e Terraform"

  }
}

resource "aws_key_pair" "ChaveSSH" {
  key_name   = "Customizada"
  public_key = file("chave.pub")
}

output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable."
  value       = aws_instance.alura01.public_ip
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = aws_instance.alura01.private_ip
}