# modules/s3-backed/variables.tf

# Name of an existing S3 bucket for Terraform state storage (Required)
variable "bucket_name" {
  description = "The name of an existing S3 bucket for Terraform state storage (must be created and configured manually)"
  type        = string
}

# Environment tag for identifying the environment (e.g., dev, staging, prod) (Required)
variable "environment" {
  description = "The environment tag for resources that reference this S3 bucket (e.g., dev, prod)"
  type        = string
}

# Common tags to apply to all resources (Required)
variable "common_tags" {
  description = "A map of common tags to apply to all resources"
  type        = map(string)
}
