FROM php:5.6-apache-jessie

ENV DEBIAN_FRONTEND=noninteractive

# Jessie is archived; PHP 5.6 images depend on old Debian repositories.
RUN set -eux; \
    sed -i \
      -e 's/deb.debian.org/archive.debian.org/g' \
      -e 's/security.debian.org/archive.debian.org/g' \
      -e 's/httpredir.debian.org/archive.debian.org/g' \
      -e '/jessie-updates/d' \
      /etc/apt/sources.list; \
    apt-get -o Acquire::Check-Valid-Until=false update; \
    apt-get install -y --no-install-recommends \
      libpng12-dev \
      libjpeg62-turbo-dev \
      libfreetype6-dev \
      zlib1g-dev \
      unzip \
      git \
      mariadb-client \
    ; \
    rm -rf /var/lib/apt/lists/*

# PHP extensions needed by the historical installer/runtime.
RUN set -eux; \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
    docker-php-ext-install gd zip calendar mysql mysqli

# PEAR packages: enough for installer checks; Chisimba also has bundled PEAR libs.
RUN set -eux; \
    pear channel-update pear.php.net || true; \
    pear install -a -f Config || true; \
    pear install -a -f Log || true; \
    pear install -a -f XML_Util || true; \
    pear install -a -f XML_Parser || true; \
    pear install -a -f XML_DTD || true; \
    pear install -a -f XML_Serializer || true; \
    pear install -a -f Structures_Graph || true; \
    pear install -a -f MDB2-2.5.0b2 || true; \
    pear install -a -f MDB2_Driver_mysql || true; \
    pear install -a -f MDB2_Driver_mysqli || true; \
    pear install -a -f MDB2_Schema || true

COPY php/chisimba.ini /usr/local/etc/php/conf.d/chisimba.ini
COPY apache/chisimba.conf /etc/apache2/sites-available/000-default.conf
COPY scripts/bootstrap-chisimba.sh /usr/local/bin/bootstrap-chisimba.sh
RUN chmod +x /usr/local/bin/bootstrap-chisimba.sh && a2enmod rewrite

WORKDIR /workspace
CMD ["/usr/local/bin/bootstrap-chisimba.sh"]
