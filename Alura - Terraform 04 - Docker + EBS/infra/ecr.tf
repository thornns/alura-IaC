resource "aws_ecr_repository" "docker_repo" {
  name = var.reponame

  image_scanning_configuration {
    scan_on_push = true
  }
}