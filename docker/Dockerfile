FROM php:5.6-apache-jessie

RUN set -eux; \
    printf '%s\n' \
      'deb [trusted=yes] http://archive.debian.org/debian jessie main' \
      'deb [trusted=yes] http://archive.debian.org/debian-security jessie/updates main' \
      > /etc/apt/sources.list; \
    printf '%s\n' \
      'Acquire::Check-Valid-Until "false";' \
      'Acquire::AllowInsecureRepositories "true";' \
      'APT::Get::AllowUnauthenticated "true";' \
      > /etc/apt/apt.conf.d/99chisimba-archive; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      libpng12-dev \
      libjpeg62-turbo-dev \
      libfreetype6-dev \
      zlib1g-dev \
      unzip \
      rsync \
      mariadb-client \
    ; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
    docker-php-ext-install gd zip calendar mysql mysqli

RUN a2enmod rewrite

COPY docker/php/chisimba.ini /usr/local/etc/php/conf.d/chisimba.ini
COPY docker/apache/chisimba.conf /etc/apache2/sites-available/000-default.conf
COPY docker/scripts/bootstrap-webroot.sh /usr/local/bin/bootstrap-webroot
RUN chmod +x /usr/local/bin/bootstrap-webroot

COPY framework/app /opt/chisimba-app

RUN set -eux; \
    mkdir -p /var/www/html/ch; \
    chown -R www-data:www-data /var/www/html/ch /opt/chisimba-app

ENTRYPOINT ["/usr/local/bin/bootstrap-webroot"]
CMD ["apache2-foreground"]
