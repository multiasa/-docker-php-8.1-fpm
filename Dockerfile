FROM php:8.1.1-fpm

ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev

RUN apt-get install -y zip
RUN apt-get install -y unzip
RUN apt-get install -y nano

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www