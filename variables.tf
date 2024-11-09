# AWS Settings

# AWS region (Optional: Default is "us-west-2")
variable "region" {
  description = "The AWS region where the infrastructure will be deployed"
  type        = string
  default     = "us-west-2"
}

# CIDR block for the VPC (Optional: Default is "10.0.0.0/16")
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Number of subnets (for public/private subnets) (Optional: Default is 2)
variable "subnet_count" {
  description = "The number of subnets to create (public and private)"
  type        = number
  default     = 2
}

# EKS Cluster Configuration

# Kubernetes version for the EKS cluster (Optional: Default is "1.30")
variable "kubernetes_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.30"
}

# Scaling configuration for EKS worker nodes (Optional: Has default scaling configuration)
variable "eks_scaling_config" {
  description = "Scaling configuration for the EKS worker nodes"
  type = object({
    desired_size = number
    min_size     = number
    max_size     = number
  })
  default = {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }
}

# EC2 instance types for EKS worker nodes
# Default: ARM-compatible type ("t4g.medium"). For AMD64, you may use ["t3.medium"].
variable "node_instance_type" {
  description = "The EC2 instance types for EKS worker nodes (ARM-compatible by default; change to AMD64-compatible instances if needed)"
  type        = list(string)
  default     = ["t4g.medium"]  # Change to ["t3.medium"] for AMD64
}

# Name of the EKS cluster (Required: Must be set by user)
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

# S3 Configuration for Terraform State

# S3 bucket for Terraform state (Required: Must be an existing bucket created by the user)
variable "s3_bucket" {
  description = "The name of an existing S3 bucket for Terraform state storage (must be created manually)"
  type        = string
}

# Path for the Terraform state file in S3 (Required: Must be set by user)
variable "terraform_state_key" {
  description = "The path to the Terraform state file in the S3 bucket"
  type        = string
}

# Tagging and Environment Information

# Environment (for tagging) (Optional: Default is "dev")
variable "environment" {
  description = "The environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# Application name for tagging (Required: Must be set by user)
variable "application" {
  description = "The name of the application for tagging"
  type        = string
}

# Group name for tagging (Required: Must be set by user)
variable "group" {
  description = "The group name for tagging"
  type        = string
}

# Project name for tagging (Optional: Default is "eks-lab")
variable "project_name" {
  description = "The name of the project for tagging"
  type        = string
  default     = "eks-lab-example"
}
