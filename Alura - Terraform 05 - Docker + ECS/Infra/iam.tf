resource "aws_iam_role" "a" {
  name = "${var.environment}-role"
  assume_role_policy = jsondecode({
    Version = "2022-07-24"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid = ""
      Principal = {
        Service = ["ec2.amazonaws.com", "ecr-tasks.amazonaws.com"]
      }
    },]
  })
}

resource "aws_iam_role_policy" "b" {
  role   = aws_iam_role.a.id

  policy = jsondecode({
    Version = "2022-07-24"
    Statement = [{
      Action = ["ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
      ]
      Effect = "Allow"
      Resource = ""
    },]
  })
}

resource "aws_iam_instance_profile" "c" {
  role = aws_iam_role.a.name
  name = "${var.environment}-perfil"

}