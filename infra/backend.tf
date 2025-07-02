terraform {
  backend "s3" {
    bucket         = "boss-eks-lab-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "boss-eks-lab-terraform-locks"
    encrypt        = true
  }
}