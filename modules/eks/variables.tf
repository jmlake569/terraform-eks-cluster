# modules/eks/variables.tf

# Project name for tagging (Required: Must be set by the user)
variable "project_name" {
  description = "The name of the project for tagging and resource naming"
  type        = string
}

# Kubernetes version for the EKS cluster (Optional: Default is "1.30")
variable "kubernetes_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.30"
}

# Common tags for all resources (Required: Must be set by the user)
variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
}

# VPC and Subnet Information
# List of public subnet IDs (Required: Must be set by the user)
variable "public_subnets" {
  description = "List of public subnet IDs for the EKS cluster"
  type        = list(string)
}

# List of private subnet IDs (Required: Must be set by the user)
variable "private_subnets" {
  description = "List of private subnet IDs for the EKS cluster"
  type        = list(string)
}

# EKS Worker Node Scaling Configuration (Required: Must be set by the user)
variable "eks_scaling_config" {
  description = "Scaling configuration for the EKS worker nodes"
  type = object({
    desired_size = number
    min_size     = number
    max_size     = number
  })
}

# EC2 instance types for EKS worker nodes (Required: Must be set by the user)
variable "node_instance_type" {
  description = "The instance types for the EKS worker nodes"
  type        = list(string)
}

# Amazon Machine Image (AMI) type for the EKS worker nodes
# Default: "AL2_ARM_64" (ARM). For AMD64, use "AL2_x86_64".
variable "ami_type" {
  description = "The AMI type for the EKS worker nodes (e.g., AL2_x86_64 for AMD64 or AL2_ARM_64 for ARM)"
  type        = string
  default     = "AL2_ARM_64"  # Adjust to "AL2_x86_64" for AMD64 if needed
}


# Name of the EKS cluster (Required: Must be set by the user)
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}
