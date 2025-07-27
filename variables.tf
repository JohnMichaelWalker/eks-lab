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

variable "external_dns_namespace" {
  description = "Namespace that the external dns is in"
  type = string
  default = "kube-system"
}

variable "external_dns_service_account_name" {
  description = "Service account name for the external dns"
  type = string
  default = "external-dns"
}