output "ecs_service_url" {
  description = "ECS Service URL (via Load Balancer - Internal)"
  value       = "http://${aws_lb.main.dns_name}"
}

output "api_gateway_url" {
  description = "API Gateway HTTPS endpoint (Public - Use this in frontend)"
  value       = aws_apigatewayv2_stage.default.invoke_url
}

output "ecr_repository_url" {
  description = "ECR Repository URL for backend"
  value       = aws_ecr_repository.backend.repository_url
}

output "s3_bucket_name" {
  description = "Frontend S3 bucket name"
  value       = aws_s3_bucket.frontend.bucket
}

output "cloudfront_domain" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.frontend.domain_name
}

output "cdn_endpoint" {
  description = "CDN endpoint URL"
  value       = "https://${aws_cloudfront_distribution.frontend.domain_name}"
}

output "github_actions_role_arn" {
  description = "GitHub Actions IAM role ARN"
  value       = aws_iam_role.github_actions.arn
}

output "alb_dns_name" {
  description = "ALB DNS name (Internal - Do not expose)"
  value       = aws_lb.main.dns_name
}

output "deployment_secret_name" {
  description = "AWS Secrets Manager secret name containing all deployment config"
  value       = try(aws_secretsmanager_secret.deployment.name, "")
}