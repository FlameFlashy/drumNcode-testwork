resource "aws_security_group" "drumncode_vpc" {
  name        = "alb-sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.drumncode_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "drumncode_ecs" {
  name        = "ecs-sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.drumncode_vpc.id

  ingress {
    from_port       = 9000
    to_port         = 9000
    protocol        = "tcp"
    security_groups = [aws_security_group.drumncode_vpc.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_internal_communication" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.drumncode_vpc.id
  source_security_group_id = aws_security_group.drumncode_vpc.id
  description              = "Allow internal communication within the security group"
}

# ECS Cluster
resource "aws_ecs_cluster" "drumncode_vpc" {
  name = "ecs-cluster-flameflashy-drumncode"
}

# ECS Task Definition for laravel
resource "aws_ecs_task_definition" "laravel" {
  family                   = "laravel-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_drm.arn

  container_definitions = jsonencode([
    {
      name  = "laravel"
      image = var.docker_image
      portMappings = [
        {
          containerPort = 9000
          hostPort      = 9000
        }
      ]
      environment = [
        {
          name  = "DB_USER"
          value = var.db_user
        },
        {
          name  = "DB_PASSWORD"
          value = var.db_password
        },
        {
          name  = "DB_ENDPOINT"
          value = aws_db_instance.database.endpoint
        },
        {
          name  = "DB_NAME"
          value = var.db_name
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/laravel"
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

# ECS Service for laravel
resource "aws_ecs_service" "laravel-service" {
  name            = "laravel-service"
  cluster         = aws_ecs_cluster.drumncode_vpc.id
  task_definition = aws_ecs_task_definition.laravel.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.drumncode_vpc[0].id, aws_subnet.drumncode_vpc[1].id]
    security_groups  = [aws_security_group.drumncode_vpc.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.laravel.arn
    container_name   = "laravel"
    container_port   = 9000
  }
}

resource "aws_cloudwatch_log_group" "laravel" {
  name              = "/ecs/laravel"
  retention_in_days = 7
}

