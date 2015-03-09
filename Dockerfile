FROM php:5.6

# Install packages and php extensions
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zip \
        git \
        apt-transport-https \
        build-essential \
        curl \
        lsb-release \
        python-all \
        rlwrap \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Install node.js and some common dependencies.
# @see https://github.com/nodesource/docker-node/blob/master/debian/jessie/node/0.12.0/Dockerfile
RUN curl https://deb.nodesource.com/node012/pool/main/n/nodejs/nodejs_0.12.0-1nodesource1~jessie1_amd64.deb > node.deb \
 && dpkg -i node.deb \
 && rm node.deb

# Update npm before we do anything else, as the one packed with node is really old.
RUN npm install -g npm
RUN npm install -g grunt-cli

WORKDIR /data