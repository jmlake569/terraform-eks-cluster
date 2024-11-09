# modules/s3-backend/outputs.tf

# Output the name of the existing S3 bucket
output "bucket_name" {
  description = "The name of the existing S3 bucket for Terraform state storage"
  value       = var.bucket_name
}
