output "vpc_id" {
    description = "VPC ID"
    value = module.vpc.vpc_id
}

output "public_subnet_ids" {
    description = "List of public subnet IDs"
    value = module.vpc.public_subnets
}