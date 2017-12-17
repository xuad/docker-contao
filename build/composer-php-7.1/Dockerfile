FROM php:7.1-cli-alpine
MAINTAINER Patrick Mosch <info@xuad.net>

ARG PHP_GROUP_ID=999
ARG PHP_USER_ID=999
ENV TERM=xterm \
    TZ=Europe/Berlin

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && apk add  --no-cache \
        bash \
        git \
        mysql-client \
        curl \
        mc \
        libintl \
        icu \
        icu-dev \
        libxml2-dev \
        libmcrypt \
        libmcrypt-dev \
        freetype \
        freetype-dev \
        libpng \
        libpng-dev \
        libjpeg-turbo \
        libjpeg-turbo-dev \
        g++ \
        make \
        autoconf \
        openssh \
    && rm /var/cache/apk/*

RUN docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd

RUN docker-php-ext-install mcrypt pdo_mysql intl && \
    docker-php-ext-configure intl && \
    addgroup -g ${PHP_GROUP_ID} php-user  && \
    adduser -D -u ${PHP_USER_ID} -G php-user php-user

COPY conf/*.ini /usr/local/etc/php/conf.d/

# Install composer global
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    mkdir /.composer

WORKDIR '/app'
CMD ["-"]
ENTRYPOINT ["composer", "--ansi"]