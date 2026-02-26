# DevOps Assignment - AWS Infrastructure Setup

## Remote State Backend Setup
First, create S3 bucket and DynamoDB table for Terraform state locking:

```bash
# Copy and apply backend configuration
cp infrastructure/terraform/backend.tf /tmp/backend/
cd /tmp/backend
terraform init
terraform apply -auto-approve
```

This creates:
- **S3 Bucket**: Stores Terraform state files
- **DynamoDB Table**: Prevents concurrent modifications

## Environment Structure
```
infrastructure/terraform/
├── dev/
├── staging/
└── prod/
```

## Resources Created Per Environment
When you run Terraform in any environment, it creates:

| Resource | Description |
|----------|-------------|
| **VPC** | Network with public/private subnets |
| **ECS** | Fargate cluster for backend API |
| **ECR** | Docker image repository |
| **ALB** | Load balancer for backend |
| **S3** | Bucket for frontend static files |
| **CloudFront** | CDN for frontend |
| **Auto Scaling** | Scales ECS tasks based on CPU/memory |
| **IAM Roles** | Permissions for ECS and GitHub Actions |
| **CloudWatch** | Logs and container insights |

## Environment Configurations

| Setting | Dev | Staging | Prod |
|---------|-----|---------|------|
| CPU | 256 | 512 | 1024 |
| Memory | 512MB | 1GB | 2GB |
| Min Tasks | 1 | 1 | 2 |
| Max Tasks | 2 | 4 | 6 |

## Terraform Commands

### Initialize (First time only)
```bash
cd infrastructure/terraform/dev  # or staging/prod
terraform init
```

### See what will be created
```bash
terraform plan -var-file=terraform.tfvars
```

### Create infrastructure
```bash
terraform apply -var-file=terraform.tfvars -auto-approve
```

### View outputs
```bash
terraform output
```

### Delete everything
```bash
terraform destroy -var-file=terraform.tfvars -auto-approve
```

## After Deployment
You'll get these outputs:
- `ecr_repository_url` - Where to push backend Docker images
- `s3_bucket_name` - Where to upload frontend files
- `cdn_endpoint` - Frontend URL
- `ecs_service_url` - Backend API URL
- `github_actions_role_arn` - IAM role for CI/CD

## Quick Checklist
- [ ] Run `terraform init`
- [ ] Run `terraform plan` to review
- [ ] Run `terraform apply` to create
- [ ] Save the output values
- [ ] Push backend image to ECR
- [ ] Upload frontend to S3
- [ ] Test the URLs