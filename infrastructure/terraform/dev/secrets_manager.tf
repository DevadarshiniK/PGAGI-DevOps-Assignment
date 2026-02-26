# AWS Secrets Manager Secret for deployment configuration
resource "aws_secretsmanager_secret" "deployment" {
  name                    = "${var.project_name}-${var.environment}"
  recovery_window_in_days = 7

  tags = {
    Name = "${var.project_name}-secrets"
  }
}

# Secret version with all deployment values
resource "aws_secretsmanager_secret_version" "deployment" {
  secret_id = aws_secretsmanager_secret.deployment.id
  secret_string = jsonencode({
    alb_dns_name                 = aws_lb.main.dns_name
    ecs_cluster_name             = aws_ecs_cluster.main.name
    ecs_service_name             = aws_ecs_service.backend.name
    s3_bucket_name               = aws_s3_bucket.frontend.bucket
    cloudfront_distribution_id   = aws_cloudfront_distribution.frontend.id
    cloudfront_domain            = aws_cloudfront_distribution.frontend.domain_name
    api_gateway_invoke_url       = aws_apigatewayv2_stage.default.invoke_url
    ecr_repository_url           = aws_ecr_repository.backend.repository_url
  })
}

# Grant GitHub Actions role access to Secrets Manager
resource "aws_secretsmanager_secret_policy" "deployment" {
  secret_arn = aws_secretsmanager_secret.deployment.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "GitHubActionsReadSecret"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.github_actions.arn
        }
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "*"
      }
    ]
  })
}
