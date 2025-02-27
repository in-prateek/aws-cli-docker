FROM php:7.2-cli-stretch

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
  	git \
  	libxml2-dev \
  	libfreetype6-dev \
  	libjpeg62-turbo-dev \
  	libmcrypt-dev \
  	libicu-dev \
  	libpng-dev \
  	libxslt1-dev \
    python3 \
    python3-pip \
    rsync \
    unzip \
    ruby-dev

# PIP Installation
RUN pip3 install awscli

# DPL Installation
RUN gem install dpl

# Increasing PHP memory limit
COPY memory-limit-php.ini /usr/local/etc/php/conf.d/memory-limit-php.ini

# CURL Installation
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# PHP Extension
RUN docker-php-ext-install dom gd intl mbstring pdo_mysql xsl zip bcmath soap sockets opcache

# Install X-Debug
RUN pecl install xdebug \
  && docker-php-ext-enable xdebug

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php", "-R"]