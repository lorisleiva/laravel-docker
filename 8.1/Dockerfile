FROM php:8.1-alpine3.15

# Add docker-php-extension-installer script
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
    mysql-client \
    nodejs \
    npm \
    yarn \
    openssh-client \
    rsync

# Install php extensions
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions \
    @composer \
    redis-stable \
    imagick-stable \
    xdebug-stable \
    bcmath \
    calendar \
    exif \
    gd \
    intl \
    pdo_mysql \
    pdo_pgsql \
    pcntl \
    soap \
    zip

# Install PHP_CodeSniffer
RUN composer global require "squizlabs/php_codesniffer=*"

# Setup working directory
WORKDIR /var/www
