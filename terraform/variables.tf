variable "docker_image" {
  description = "The Docker image for the laravel-dnc container"
  default     = "637423237571.dkr.ecr.eu-central-1.amazonaws.com/flameflashy-drumncode:laravel-dnc"
}

variable "db_user" {
  description = "Database username"
  default     = "drumncode_user"
}

variable "db_password" {
  description = "Database password"
  default     = "drumncode_12321fds"
}

variable "db_name" {
  description = "Database name"
  default     = "drumncode_db"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}
