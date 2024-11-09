# outputs.tf

# Output the VPC ID
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC created by the VPC module"
}

# Output the IDs of public subnets
output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "A list of public subnet IDs created within the VPC"
}

# Output the IDs of private subnets
output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "A list of private subnet IDs created within the VPC"
}
