FROM php:8.1-fpm-buster
LABEL maintainer="ucan-lab <yes@u-can.pro>"
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

# timezone environment
ENV TZ=UTC \
  # locale
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8 \
  # composer environment
  COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME=/composer

COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer

RUN apt-get update && \
  apt-get install -y gnupg2 && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8C718D3B5072E1F5 && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 467B942D3A79BD29 && \
  echo "deb http://repo.mysql.com/apt/debian/ buster mysql-8.0" > /etc/apt/sources.list.d/mysql.list && \
  cat /etc/apt/sources.list.d/mysql.list && \
  apt-get update && \
  apt-get -y install git libicu-dev libonig-dev libzip-dev unzip locales mysql-client && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  locale-gen en_US.UTF-8 && \
  localedef -f UTF-8 -i en_US en_US.UTF-8 && \
  mkdir /var/run/php-fpm && \
  docker-php-ext-install intl pdo_mysql zip bcmath && \
  pecl install redis-5.3.4 && \
  docker-php-ext-enable redis && \
  composer config -g process-timeout 3600 && \
  composer config -g repos.packagist composer https://packagist.org

COPY ./infra/docker/php/php-fpm.d/zzz-www.conf /usr/local/etc/php-fpm.d/zzz-www.conf
COPY ./infra/docker/php/php.ini /usr/local/etc/php/php.ini

COPY --chown=www-data:www-data ./backend /work/backend

WORKDIR /work/backend
