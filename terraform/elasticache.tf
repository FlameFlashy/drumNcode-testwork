resource "aws_security_group" "elasticache" {
  name        = "elasticache-sg"
  description = "Allow inbound traffic for elasticache"
  vpc_id      = aws_vpc.drumncode_vpc.id

  ingress {
    from_port   = 6379
    to_port     = 6379
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

resource "aws_elasticache_cluster" "elasticache" {
  cluster_id           = "dnc-redis"
  engine               = "redis"
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  subnet_group_name    = aws_elasticache_subnet_group.elasticache-subnet.name
  security_group_ids   = [aws_security_group.elasticache.id]
}

resource "aws_elasticache_subnet_group" "elasticache-subnet" {
  name       = "elasticache-subnet-group"
  subnet_ids = [aws_subnet.drumncode_vpc[0].id, aws_subnet.drumncode_vpc[1].id]

  tags = {
    Name = "elasticache-subnet-group"
  }
}
