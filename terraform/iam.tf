# IAM Role for ECS
resource "aws_iam_role" "ecs_task_execution_drm" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecr.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "fargate.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_drm" {
  role       = aws_iam_role.ecs_task_execution_drm.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_drm_ecr_access" {
  role       = aws_iam_role.ecs_task_execution_drm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecsInstanceProfile"
  role = aws_iam_role.ecs_task_execution_drm.name
}

# IAM Policy for accessing SSM Parameters and Secrets Manager
resource "aws_iam_policy" "ecs_ssm_secrets_access" {
  name        = "EcsSSMSecretsAccessPolicy"
  description = "Policy to allow ECS tasks to access SSM parameters and Secrets Manager secrets"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParameterHistory",
          "secretsmanager:GetSecretValue"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach the new policy to the ECS task execution role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_drm_ssm_secrets" {
  role       = aws_iam_role.ecs_task_execution_drm.name
  policy_arn = aws_iam_policy.ecs_ssm_secrets_access.arn
}
