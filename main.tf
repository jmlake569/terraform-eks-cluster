# Local tags for consistent tagging across resources
locals {
  common_tags = {
    Application = var.application
    Group       = var.group
  }
}

# Call the VPC module to provision the VPC and subnets
module "vpc" {
  source = "./modules/vpc"
  
  # Pass the required variables
  vpc_cidr_block = var.vpc_cidr_block
  subnet_count   = var.subnet_count
  project_name   = var.project_name

  # Tags for VPC resources
  common_tags = local.common_tags
}

# Configure the S3 Backend for Terraform state storage
terraform {
  backend "s3" {
    bucket = var.s3_bucket           # Specify the pre-existing S3 bucket name
    key    = var.terraform_state_key  # Path to the Terraform state file in the bucket
    region = var.region               # AWS region for the S3 bucket
  }
}

# Call the EKS module to provision the EKS cluster and associated IAM roles
module "eks" {
  source = "./modules/eks"

  # EKS configuration variables
  project_name       = var.project_name
  kubernetes_version = var.kubernetes_version
  eks_scaling_config = var.eks_scaling_config
  node_instance_type = var.node_instance_type
  cluster_name       = var.cluster_name
  ami_type           = var.ami_type

  # Networking variables from the VPC module
  public_subnets  = module.vpc.public_subnet_ids
  private_subnets = module.vpc.private_subnet_ids

  # Tags for EKS resources
  common_tags = local.common_tags
}

# Outputs for essential information
output "eks_cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster"
}

output "eks_cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint of the EKS Kubernetes API server"
}

output "eks_worker_group_name" {
  value       = module.eks.worker_group_name
  description = "The EKS worker group name"
}

# AMI type for worker nodes
variable "ami_type" {
  description = "The AMI type for the EKS worker nodes (e.g., AL2_x86_64, AL2_ARM_64)"
  type        = string
  default     = "AL2_ARM_64"  # Adjust as needed
}
