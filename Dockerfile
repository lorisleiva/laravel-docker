FROM php:alpine

# Install dev dependencies
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    curl-dev \
    imagemagick-dev \
    libtool \
    libxml2-dev \
    postgresql-dev \
    sqlite-dev

# Install production dependencies
RUN apk add --no-cache \
    bash \
    curl \
    g++ \
    gcc \
    git \
    imagemagick \
    libc-dev \
    libpng-dev \
    libzip-dev \
    freetype \
    libpng \
    libjpeg-turbo \
    freetype-dev \
    libjpeg-turbo-dev \
    make \
    mysql-client \
    nodejs \
    nodejs-npm \
    openssh-client \
    postgresql-libs \
    rsync \
    python \
    py-pip \
    groff \
    zip \
    zlib-dev

# Install php extensions
RUN pecl install \
    imagick \
    xdebug
# RUN pear install PHP_CodeSniffer
RUN docker-php-ext-enable \
    imagick \
    xdebug
RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install \
    bcmath \
    exif \
    curl \
    iconv \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    pcntl \
    tokenizer \
    xml \
    zip
RUN docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/
RUN NPROC=$(getconf _NPROCESSORS_ONLN)&& docker-php-ext-install -j${NPROC} gd

# Install composer
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="./vendor/bin:$PATH"

# Install AWS CLI
RUN pip install awscli

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Setup working directory
WORKDIR /var/www
