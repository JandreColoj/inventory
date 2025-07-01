FROM php:7.4-apache

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git curl libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Copiar configuración de Apache personalizada
COPY ./docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
