variable "aws_region" {
  description = "AWS region to deploy into"
  type = string
  default = "eu-west-2"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type = string
  default = "eks-lab-cluster"
}