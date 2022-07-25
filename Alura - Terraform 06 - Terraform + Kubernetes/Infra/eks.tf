module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "${var.environment}-cluster"
  cluster_version = "1.22"
  cluster_endpoint_private_access = true
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    nodes_alura = {
      min_size     = 1
      max_size     = 10
      desired_size = 3
      vpc_security_group_ids = [aws_security_group.ssh_cluster.id]
      # disk_size = 50
      # ami_type = "AL2_x86_64"
      instance_types = ["t2.micro"]
      capacity_type  = "SPOT"
    }
  }
}