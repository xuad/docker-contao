FROM alpine:3.6
MAINTAINER Patrick Mosch <info@xuad.net>

ARG APACHE_USER_ID=999
ARG APACHE_GROUP_ID=999

# Environments
ENV TERM=xterm \
    TZ=Europe/Berlin \
    APACHE_VHOST=apache.local \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_DOCUMENT_ROOT=/app/public

# -x Print commands and their arguments as they are executed
RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && apk add --no-cache \
    shadow \
    bash \
    gawk \
    sed \
    grep \
    bc \
    coreutils \
    openrc \
    curl \
    openssl \
    apache2 \
    apache2-proxy \
    apache2-ssl \
    mysql-client \
    tzdata \
    openssh && \
    set -x \
    && sed -i 's/^LoadModule proxy_fdpass_module/#LoadModule proxy_fdpass_module/' /etc/apache2/conf.d/proxy.conf \
    && sed -i "s/^#LoadModule slotmem_shm_module/LoadModule slotmem_shm_module/" /etc/apache2/httpd.conf \
    && sed -i "s/^#LoadModule rewrite_module/LoadModule rewrite_module/" /etc/apache2/httpd.conf \
    && sed -i "s/^#LoadModule expires_module/LoadModule expires_module/" /etc/apache2/httpd.conf && \
    mkdir -p /run/apache2 && \
    mkdir /app && \
    usermod -u ${APACHE_USER_ID} apache && \
    groupmod -g ${APACHE_GROUP_ID} apache

COPY conf/* /etc/apache2/conf.d/

WORKDIR /app
EXPOSE 80 443
CMD ["httpd", "-D", "FOREGROUND"]