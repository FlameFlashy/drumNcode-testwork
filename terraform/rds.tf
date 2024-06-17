
resource "aws_security_group" "database" {
  name        = "database-sg"
  description = "Allow inbound traffic for database"
  vpc_id      = aws_vpc.drumncode_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS PostgreSQL Database
resource "aws_db_instance" "database" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_user
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.drumncode_vpc.id]
  db_subnet_group_name   = aws_db_subnet_group.rds.name
}

resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.drumncode_vpc[0].id, aws_subnet.drumncode_vpc[1].id]

  tags = {
    Name = "rds-subnet-group"
  }
}
