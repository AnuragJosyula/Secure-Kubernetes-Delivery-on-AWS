terraform {
  backend "s3" {
    bucket = "eks-blue-green-tf"
    key    = "eks-blue-green/terraform.tfstate"
    region = "us-east-1"
  }
}