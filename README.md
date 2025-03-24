# Alibaba Cloud Kubernetes Infrastructure

This Terraform configuration sets up a complete Kubernetes infrastructure on Alibaba Cloud in the Jakarta region, using a modular approach.

## Module Structure

The infrastructure is organized into the following modules:

1. **VPC Module** (`modules/vpc/`)
   - VPC with CIDR 10.0.0.0/16
   - 4 VSwitches (2 private, 2 public) across 2 availability zones
   - NAT Gateway with EIP for outbound internet access
   - SNAT entries for private subnets

2. **Security Module** (`modules/security/`)
   - Security group with VPC CIDR ingress and all egress rules
   - RAM user for Kubernetes management
   - RAM policies for container and ECS access

3. **Database Module** (`modules/database/`)
   - ApsaraDB RDS MySQL 8.0
   - Private access within VPC
   - Configurable parameters
   - Private OSS bucket with lifecycle rules

4. **Kubernetes Module** (`modules/kubernetes/`)
   - Managed Kubernetes service
   - Worker nodes configuration
   - Network and security settings
   - Monitoring and logging configuration

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Alibaba Cloud Account](https://www.alibabacloud.com/)
- Alibaba Cloud Access Key and Secret Key with appropriate permissions

## Usage

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd alicloud-k8s-terraform
   ```

2. Create a `terraform.tfvars` file with your configuration:
   ```hcl
   name_prefix         = "your-prefix"
   vpc_cidr           = "10.0.0.0/16"
   db_account_password = "your-secure-password"
   # Add other variables as needed
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the plan:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Variables

### Common Variables
- `name_prefix`: Prefix for resource names (default: "pintar")
- `tags`: Map of tags to apply to resources

### VPC Variables
- `vpc_cidr`: CIDR block for VPC (default: "10.0.0.0/16")
- `nat_bandwidth`: Bandwidth for NAT Gateway (default: 10)

### Database Variables
- `db_instance_type`: RDS instance type (default: "mysql.n2.small.2c")
- `db_instance_storage`: RDS storage size in GB (default: 20)
- `db_account_name`: Database account name (default: "admin")
- `db_account_password`: Database account password (required)

### Kubernetes Variables
- `k8s_version`: Kubernetes version (default: "1.26.3")
- `worker_instance_type`: Worker node instance type (default: "ecs.c6.large")
- `worker_nodes_count`: Number of worker nodes (default: 2)
- `pod_cidr`: CIDR block for pods (default: "172.16.0.0/16")
- `service_cidr`: CIDR block for services (default: "172.19.0.0/20")

## Outputs

### VPC Outputs
- `vpc_id`: The ID of the VPC
- `private_vswitch_ids`: List of private vswitch IDs
- `public_vswitch_ids`: List of public vswitch IDs
- `nat_gateway_id`: The ID of the NAT Gateway

### Security Outputs
- `security_group_id`: The ID of the security group
- `k8s_access_key_id`: The access key ID for Kubernetes (sensitive)
- `k8s_access_key_secret`: The access key secret for Kubernetes (sensitive)

### Database Outputs
- `db_connection_string`: The database connection string (sensitive)
- `db_port`: The database port
- `oss_bucket_endpoint`: The OSS bucket endpoint

### Kubernetes Outputs
- `cluster_id`: The ID of the Kubernetes cluster
- `cluster_endpoint`: The cluster API endpoint
- `kubeconfig_file`: The kubeconfig file (sensitive)

## Security Considerations

- Access keys are treated as sensitive information
- Database passwords should be changed in production
- Security group rules are restricted to VPC CIDR
- All storage is encrypted
- Private networking is used where possible

## Cleanup

To destroy all created resources:
```bash
terraform destroy
```

**Note:** This will permanently delete all resources created by this configuration. 