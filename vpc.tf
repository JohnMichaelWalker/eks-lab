module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "~> 5.1"

    name = "eks-lab-vpc"
    cidr = "10.42.0.0/16"
    
    map_public_ip_on_launch = true

    azs = ["${var.aws_region}a", "${var.aws_region}b"]
    public_subnets = ["10.42.0.0/20", "10.42.16.0/20"]

    enable_nat_gateway = false

    public_subnet_tags = {
        "kubernetes.io/role/elb" = 1
    }
}