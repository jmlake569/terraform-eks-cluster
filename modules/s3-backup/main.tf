# main.tf in modules/s3-backed

# Only reference the existing S3 bucket name
# Users must create this bucket manually with versioning and lifecycle policies enabled

# Use the existing bucket for other resources, if applicable, without creating or configuring it here.
# Any required configurations, like encryption, versioning, or lifecycle rules, should be handled outside of Terraform.

# Reference the existing bucket's name, and apply tags if needed for any related resources
variable "bucket_name" {
  description = "The name of an existing S3 bucket for Terraform state storage (must be created manually)"
  type        = string
}

# Tagging example (if applicable for other resources in this module)
locals {
  bucket_tags = merge(var.common_tags, { Environment = var.environment, Name = var.bucket_name })
}

# Optionally add any other resources here that depend on the bucket name, but do not manage the bucket itself.
