variable "aws_region" {
  description = "The AWS region for all resources."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_count" {
  description = "Number of public subnets to create."
  type        = number
  default     = 2 
}

variable "private_subnet_count" {
  description = "Number of private subnets to create."
  type        = number
  default     = 2 
}
variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "eks-blue-green"
}