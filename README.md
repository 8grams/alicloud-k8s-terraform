# Alibaba Cloud Kubernetes Infrastructure with Terraform

This repository contains Terraform configurations for setting up a production-ready Kubernetes infrastructure on Alibaba Cloud. The infrastructure is designed to be secure, scalable, and follows best practices for cloud-native applications.

## Architecture

The infrastructure is organized into modular components:

### 1. VPC Module
- Virtual Private Cloud (VPC) with public and private subnets
- NAT Gateway for outbound internet access from private subnets
- Elastic IP (EIP) for NAT Gateway
- SNAT entries for private subnet internet access

### 2. Security Module
- Security groups with configurable ingress/egress rules
- Default rules for Kubernetes and database access
- VPC CIDR-based rule substitution

### 3. Kubernetes Module
- Managed Kubernetes Service (ACK)
- Worker node pool with auto-scaling
- Essential addons:
  - Ingress NGINX Controller
  - CSI Plugin
  - Metrics Server
  - Cloud Monitor
  - Log Service
  - ARMS Prometheus

## Prerequisites

- Alibaba Cloud account with appropriate permissions
- Terraform v1.0.0 or later
- Alibaba Cloud CLI configured with credentials
- kubectl for Kubernetes interaction

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/alicloud-k8s-terraform.git
   cd alicloud-k8s-terraform
   ```

2. Configure your variables in `infra-services/terraform.tfvars`:
   ```hcl
   # Basic Configuration
   name_prefix = "your-prefix"
   region     = "ap-southeast-5"
   
   # VPC Configuration
   vpc_name = "your-vpc"
   vpc_cidr = "10.0.0.0/16"
   availability_zones = ["ap-southeast-5a", "ap-southeast-5b"]
   
   # Kubernetes Configuration
   k8s_version = "1.26.3"
   k8s_worker_instance_type = "ecs.g6.xlarge"
   k8s_worker_nodes_count = 2
   ```

3. Initialize Terraform:
   ```bash
   cd infra-services
   terraform init
   ```

4. Review the execution plan:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Module Structure

```
.
├── modules/
│   ├── kubernetes/         # Kubernetes cluster and node pool
│   ├── security-group/     # Security groups and rules
│   └── vpc/               # VPC, subnets, and NAT gateway
└── infra-services/        # Main infrastructure configuration
    ├── main.tf           # Module composition
    ├── variables.tf      # Variable declarations
    └── terraform.tfvars  # Variable values
```

## Security Considerations

- Private subnets for worker nodes
- NAT Gateway for controlled outbound access
- Security groups with minimal required access
- Managed Kubernetes service for security updates
- Cloud Monitor and ARMS for security monitoring

## Monitoring and Logging

The infrastructure includes:
- Cloud Monitor for basic metrics
- ARMS Prometheus for advanced monitoring
- Log Service for centralized logging
- Metrics Server for Kubernetes metrics

## Cleanup

To destroy all resources:
```bash
cd infra-services
terraform destroy
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

MIT

## Acknowledgments

- [Alibaba Cloud](https://www.alibabacloud.com/)
- [Terraform](https://www.terraform.io/)
- [ACK Documentation](https://www.alibabacloud.com/help/en/container-service-for-kubernetes)