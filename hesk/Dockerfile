FROM php:7.3-apache

ENV HESK_VERSION=311

COPY ./rootfs /

RUN apt-get update \
    && apt-get install unzip \
    && docker-php-ext-install mysqli \
    && usermod -u 1000 www-data \
    && chmod +x /usr/local/bin/bootstrap.sh

CMD ["/usr/local/bin/bootstrap.sh"]
