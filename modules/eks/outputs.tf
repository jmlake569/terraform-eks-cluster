# outputs.tf

# Name of the EKS worker group
output "worker_group_name" {
  value       = aws_eks_node_group.eks_worker_group.node_group_name
  description = "The name of the EKS worker node group"
}

# Name of the EKS cluster
output "cluster_name" {
  value       = aws_eks_cluster.eks_cluster.name
  description = "The name of the EKS cluster"
}

# Endpoint URL of the EKS Kubernetes API server
output "cluster_endpoint" {
  value       = aws_eks_cluster.eks_cluster.endpoint
  description = "The endpoint of the EKS Kubernetes API server"
}
