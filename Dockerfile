FROM php:5.6

# Install packages and php extensions
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zip \
        git \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Install node.js and some common dependencies.
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs
RUN npm install -g bower grunt gulp


WORKDIR /data