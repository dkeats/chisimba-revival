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
      git \
      mariadb-client \
      rsync; \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd zip calendar mysql mysqli

RUN pear channel-update pear.php.net || true \
    && pear install -a -f Config Log XML_Util XML_Parser XML_DTD XML_Serializer Structures_Graph \
    && pear install -a -f MDB2-2.5.0b2 MDB2_Driver_mysql MDB2_Driver_mysqli MDB2_Schema || true

COPY php/chisimba.ini /usr/local/etc/php/conf.d/chisimba.ini
COPY apache/chisimba.conf /etc/apache2/sites-available/000-default.conf
COPY scripts/bootstrap-webroot.sh /usr/local/bin/bootstrap-webroot.sh
RUN chmod +x /usr/local/bin/bootstrap-webroot.sh && a2enmod rewrite

CMD ["bootstrap-webroot.sh"]
