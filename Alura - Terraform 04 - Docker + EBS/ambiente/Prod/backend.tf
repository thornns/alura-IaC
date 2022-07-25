terraform {
  backend "s3" {
    # Nome do Bucket
    bucket = "terraform-state-999898949736"
    # No bucket, onde vai salvar?
    key = "Prod/04/terraform.tfstate"
    region = "us-east-1"
    profile = "default"
  }
}
