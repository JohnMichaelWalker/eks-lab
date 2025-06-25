variable "aws_region" {
  description = "AWS region to deploy into"
  type = string
  default = "eu-west-2"
}

provider "aws" {
  region = var.aws_region
  

  # Tag every resource so you can spot and delete strays
  default_tags {
    tags = {
      Project = "eks-lab"
    }
  }
}