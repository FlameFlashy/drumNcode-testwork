[
    {
        "name": "laravel",
        "image": "637423237571.dkr.ecr.eu-central-1.amazonaws.com/flameflashy-drumncode:latest",
        "portMappings": [
            {
                "containerPort": 9000,
                "hostPort": 9000,
                "protocol": "tcp"
            }
        ],
        "essential": true,
        "environment": [
            {
                "name": "DB_DATABASE",
                "value": "drumncode_db"
            },
            {
                "name": "DB_USERNAME",
                "value": "drumncode_user"
            },
            {
                "name": "DB_HOST",
                "value": "{$db_host}"
            },
            {
                "name": "DB_PORT",
                "value": "3306"
            },
            {
                "name": "APP_NAME",
                "value": "Laravel"
            },
            {
                "name": "APP_ENV",
                "value": "local"
            },
            {
                "name": "APP_DEBUG",
                "value": "true"
            },
            {
                "name": "APP_TIMEZONE",
                "value": "UTC"
            },
            {
                "name": "APP_URL",
                "value": "http://localhost"
            },
            {
                "name": "APP_LOCALE",
                "value": "en"
            },
            {
                "name": "APP_FALLBACK_LOCALE",
                "value": "en"
            },
            {
                "name": "APP_FAKER_LOCALE",
                "value": "en_US"
            },
            {
                "name": "APP_MAINTENANCE_DRIVER",
                "value": "file"
            },
            {
                "name": "APP_MAINTENANCE_STORE",
                "value": "database"
            },
            {
                "name": "BCRYPT_ROUNDS",
                "value": "12"
            },
            {
                "name": "LOG_CHANNEL",
                "value": "stack"
            },
            {
                "name": "LOG_STACK",
                "value": "single"
            },
            {
                "name": "LOG_DEPRECATIONS_CHANNEL",
                "value": "null"
            },
            {
                "name": "LOG_DEPRECATIONS_CHANNEL",
                "value": "null"
            },
            {
                "name": "DB_CONNECTION",
                "value": "mysql"
            },
            {
                "name": "SESSION_DRIVER",
                "value": "database"
            },
            {
                "name": "SESSION_LIFETIME",
                "value": "120"
            },
            {
                "name": "SESSION_ENCRYPT",
                "value": "false"
            },
            {
                "name": "SESSION_PATH",
                "value": "/"
            },
            {
                "name": "SESSION_DOMAIN",
                "value": "null"
            },
            {
                "name": "BROADCAST_CONNECTION",
                "value": "log"
            },
            {
                "name": "FILESYSTEM_DISK",
                "value": "local"
            },
            {
                "name": "QUEUE_CONNECTION",
                "value": "database"
            },
            {
                "name": "CACHE_STORE",
                "value": "database"
            },
            {
                "name": "CACHE_PREFIX",
                "value": ""
            },
            {
                "name": "MEMCACHED_HOST",
                "value": "127.0.0.1"
            },
            {
                "name": "REDIS_CLIENT",
                "value": "127.0.0.1"
            },
            {
                "name": "REDIS_HOST",
                "value": "127.0.0.1"
            },
            {
                "name": "REDIS_PASSWORD",
                "value": "null"
            },
            {
                "name": "REDIS_PORT",
                "value": "6379"
            },
            {
                "name": "MAIL_MAILER",
                "value": "log"
            },
            {
                "name": "MAIL_HOST",
                "value": "127.0.0.1"
            },
            {
                "name": "MAIL_PORT",
                "value": "2525"
            },
            {
                "name": "MAIL_USERNAME",
                "value": "null"
            },
            {
                "name": "MAIL_PASSWORD",
                "value": "null"
            },
            {
                "name": "MAIL_ENCRYPTION",
                "value": "null"
            },
            {
                "name": "MAIL_FROM_ADDRESS",
                "value": "hello@example.com"
            },
            {
                "name": "MAIL_FROM_ADDRESS",
                "value": "hello@example.com"
            },
            {
                "name": "MAIL_FROM_NAME",
                "value": "Laravel"
            },
            {
                "name": "AWS_ACCESS_KEY_ID",
                "value": ""
            },
            {
                "name": "AWS_SECRET_ACCESS_KEY",
                "value": ""
            },
            {
                "name": "AWS_DEFAULT_REGION",
                "value": "eu-central-1"
            },
            {
                "name": "AWS_BUCKET",
                "value": ""
            },
            {
                "name": "AWS_USE_PATH_STYLE_ENDPOINT",
                "value": "false"
            },
            {
                "name": "VITE_APP_NAME",
                "value": "Laravel"
            }
        ],
        "secrets": [
            {
                "name": "APP_KEY",
                "valueFrom": "arn:aws:ssm:eu-central-1:637423237571:parameter/drumncode/APP_KEY"
            },
            {
                "name": "DB_PASSWORD",
                "valueFrom": "arn:aws:ssm:eu-central-1:637423237571:parameter/drumncode/DB_PASSWORD"
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "/ecs/laravel",
                "awslogs-region": "eu-central-1",
                "awslogs-stream-prefix": "ecs"
            }
        }
    }
]