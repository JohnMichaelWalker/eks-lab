provider "aws" {
  region = var.aws_region
  

  # Tag every resource so you can spot and delete strays
  default_tags {
    tags = {
      Project = "eks-lab"
    }
  }
}