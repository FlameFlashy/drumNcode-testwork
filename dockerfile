# Use the official PHP 8.2 image with FPM
FROM php:8.2-fpm

# Install dependencies for installing PHP extensions
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libxml2-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    zlib1g-dev \
    git \
    unzip \
    libicu-dev \
    libpq-dev \
    libmcrypt-dev \
    libreadline-dev \
    libxslt1-dev \
    libtidy-dev \
    libssh2-1-dev \
    libghc-zlib-dev \
    pkg-config \
    libgmp-dev \
    wget

# Install necessary PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip exif pcntl bcmath gd intl opcache soap

# install grpc, protobuf и redis extensions
RUN pecl install grpc protobuf redis \
    && docker-php-ext-enable grpc protobuf redis

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set the working directory
WORKDIR /app
COPY ./laravel /app

# Install Laravel application dependencies
RUN composer install --no-dev --optimize-autoloader

# Set permissions for storage and cache directories
RUN chown -R www-data:www-data /app

CMD php artisan serve --host=0.0.0.0 --port=9000
EXPOSE 9000
