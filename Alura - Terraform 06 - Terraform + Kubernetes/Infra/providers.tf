provider "aws" {
  region = "us-east-1"
  profile = "default"
}

data "aws_eks_cluster" "default" {
  name = "${var.environment}-cluster"
}

data "aws_eks_cluster_auth" "default" {
  name = "${var.environment}-cluster"
}

provider "kubernetes" {
  host = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.default.token
}