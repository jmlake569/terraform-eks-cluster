# modules/vpc/variables.tf

# CIDR block for the VPC (Required)
# Define the IP range for the VPC (e.g., "10.0.0.0/16")
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

# Number of subnets to create in each category (public/private) (Optional, Default: 2)
# This will create this number of public and private subnets.
variable "subnet_count" {
  description = "The number of subnets to create in each category (public/private)"
  type        = number
  default     = 2
}

# Common tags to apply to all resources (Required)
# A map of tags for identifying resources created within the VPC.
variable "common_tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
}

# Project name for tagging resources (Required)
# Specify the project name to be used in resource tags.
variable "project_name" {
  description = "The name of the project for tagging resources"
  type        = string
}
