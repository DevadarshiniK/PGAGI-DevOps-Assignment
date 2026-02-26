variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "devops-assignment"
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}

# VPC
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

# Backend
variable "backend_port" {
  description = "Backend container port"
  type        = number
  default     = 8000
}

# ECS Sizing - These need to be maps to support different environments
variable "task_cpu" {
  description = "CPU units for ECS task per environment"
  type        = map(number)
  default = {
    dev     = 256
    staging = 512
    prod    = 1024
  }
}

variable "task_memory" {
  description = "Memory for ECS task per environment"
  type        = map(number)
  default = {
    dev     = 512
    staging = 1024
    prod    = 2048
  }
}

variable "ecs_desired_count" {
  description = "Desired count of ECS tasks per environment"
  type        = map(number)
  default = {
    dev     = 1
    staging = 2
    prod    = 3
  }
}

variable "ecs_min_count" {
  description = "Minimum count of ECS tasks for auto-scaling per environment"
  type        = map(number)
  default = {
    dev     = 1
    staging = 1
    prod    = 2
  }
}

variable "ecs_max_count" {
  description = "Maximum count of ECS tasks for auto-scaling per environment"
  type        = map(number)
  default = {
    dev     = 2
    staging = 4
    prod    = 6
  }
}

# CDN - This should be a map with nested attributes
variable "cloudfront_ttl" {
  description = "CloudFront TTL values per environment"
  type = map(object({
    default_ttl = number
    max_ttl     = number
  }))
  default = {
    dev = {
      default_ttl = 60
      max_ttl     = 300
    }
    staging = {
      default_ttl = 300
      max_ttl     = 600
    }
    prod = {
      default_ttl = 3600
      max_ttl     = 86400
    }
  }
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 30
}

# Domain for CloudFront
variable "frontend_domain" {
  description = "Domain name for frontend"
  type        = string
  default     = ""
}

variable "github_repo_owner" {
  description = "GitHub repository owner (username or organization)"
  type        = string
  default     = "DevadarshiniK"
}

variable "github_repo_name" {
  description = "GitHub repository name"
  type        = string
  default     = "DevOps-Assignment"
}