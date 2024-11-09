
# Terraform-eks-cluster

This project sets up an Amazon EKS (Elastic Kubernetes Service) cluster with an associated VPC, subnets, and required IAM roles. The configuration is modular, allowing you to customize and reuse components like the VPC, EKS, and S3-backed storage modules.

## Folder Structure

```
terraform-eks-cluster/
├── main.tf                   # Main Terraform configuration
├── variables.tf              # Variables for the main configuration
├── outputs.tf                # Outputs for the main configuration
├── modules/                  # Directory for reusable Terraform modules
│   ├── eks/                  # EKS-specific resources
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── s3-backup/            # S3 bucket for Terraform state storage
│   │   ├── main.tf
│   │   └── variables.tf
│   └── vpc/                  # VPC and networking resources
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── examples/
    ├── terraform.tfvars.example  # Example configuration file for user customization
    └── s3backup-config.tfvars.example # Example configuration file for s3 config for the state file backup
```

## Prerequisites

- **Terraform**: Make sure you have Terraform installed. [Install Terraform](https://www.terraform.io/downloads.html)
- **AWS CLI**: Configure your AWS CLI with appropriate credentials. [AWS CLI Installation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- **IAM Permissions**: You need permissions to create EKS, VPC, and other AWS resources.
- **S3 Bucket**: S3 bucket for storing the state file.

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/jmlake569/terraform-eks-cluster.git
cd terraform-eks-cluster
```

### 2. Configure Variables

This setup requires certain variables to be set for proper configuration. You can do this by creating a `terraform.tfvars` file or by copying the provided example file.

```bash
cp examples/terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your desired values. Below are the key variables and their explanations:

#### Required Variables

- **`s3_bucket`**: Name of an existing S3 bucket for Terraform state storage. **This must be a unique S3 bucket name, created and configured manually.**
- **`project_name`**: A unique project name to tag resources.
- **`environment`**: The environment name (e.g., `dev`, `staging`, `prod`).
- **`cluster_name`**: The name of the EKS cluster.
- **`common_tags`**: A map of tags to be applied to all resources (e.g., `{"Project": "eks-cluster", "Owner": "your-name"}`).

#### Optional Variables with Defaults

- **`region`**: AWS region where the infrastructure will be deployed. Default is `us-west-2`.
- **`vpc_cidr_block`**: CIDR block for the VPC. Default is `10.0.0.0/16`.
- **`subnet_count`**: Number of public and private subnets to create. Default is `2`.
- **`kubernetes_version`**: Kubernetes version for the EKS cluster. Default is `1.30`.

### Architecture Selection

This setup is compatible with both ARM and AMD64 architectures. By default, it is configured for ARM. To use AMD64 instead, update the following variables in `terraform.tfvars`:

- **`ami_type`**: Set to `"AL2_x86_64"` for AMD64, or keep as `"AL2_ARM_64"` for ARM.
- **`node_instance_type`**: Use `["t4g.medium"]` for ARM or `["t3.medium"]` for AMD64.

This flexibility allows you to select the architecture that best meets your application and performance requirements.

### Example `terraform.tfvars`

```hcl
region                 = "us-west-2"
s3_bucket              = "my-unique-terraform-state-bucket"  # Must be created manually
project_name           = "eks-cluster-project"
environment            = "dev"
cluster_name           = "my-eks-cluster"
common_tags            = { Project = "eks-cluster", Owner = "your-name" }
vpc_cidr_block         = "10.0.0.0/16"
subnet_count           = 2
kubernetes_version     = "1.30"
node_instance_type     = ["t4g.medium"]   # ARM-compatible; use ["t3.medium"] for AMD64
ami_type               = "AL2_ARM_64"     # Use "AL2_x86_64" for AMD64
```

### 3. Initialize and Apply the Configuration

Initialize the configuration to set up the backend and download any required providers.

```bash
terraform init
```

After initializing, apply the configuration to create the EKS cluster and related resources:

```bash
terraform apply
```

This command will show a plan of the changes Terraform will make. Type `yes` to confirm and proceed with the deployment.

### 4. Outputs

Upon successful deployment, Terraform will output important information, including:

- **`vpc_id`**: The ID of the created VPC.
- **`public_subnet_ids`**: List of IDs for public subnets.
- **`private_subnet_ids`**: List of IDs for private subnets.
- **`cluster_name`**: The name of the EKS cluster.
- **`cluster_endpoint`**: The endpoint URL of the EKS Kubernetes API server.

## Cleaning Up

To delete all resources created by this configuration, run:

```bash
terraform destroy
```

## Troubleshooting

- **Permission Issues**: Ensure your AWS credentials have the necessary permissions to create the required resources.

## Additional Notes

- **High Availability**: This setup uses a single NAT gateway for private subnets. For high availability, consider adding a NAT gateway in each availability zone.
- **Encryption**: The S3 bucket should be configured with server-side encryption to protect your state files.

## License

This project is licensed under the MIT License.
