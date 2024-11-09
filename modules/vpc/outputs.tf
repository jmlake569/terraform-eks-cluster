# outputs.tf in modules/vpc

# ID of the created VPC
output "vpc_id" {
  description = "The ID of the VPC created for EKS networking"
  value       = aws_vpc.eks_vpc.id
}

# IDs of all public subnets within the VPC
output "public_subnet_ids" {
  description = "A list of IDs for the public subnets created within the VPC"
  value       = aws_subnet.public_subnet[*].id
}

# IDs of all private subnets within the VPC
output "private_subnet_ids" {
  description = "A list of IDs for the private subnets created within the VPC"
  value       = aws_subnet.private_subnet[*].id
}
