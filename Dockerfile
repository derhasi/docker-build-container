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
        locales \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip

RUN dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL C.UTF-8

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

# Installing ruby ...
RUN apt-get install -y ruby
RUN apt-get install -y ruby-dev
# ... and some essential gems
RUN gem install sass -v 3.4.9
RUN gem install sass-globbing -v 1.1.1
RUN gem install compass -v 1.0.1
RUN gem install compass-normalize -v 1.5
RUN gem install compass-rgbapng -v 0.2.1
RUN gem install toolkit  -v 2.6.0
RUN gem install breakpoint -v 2.5.0
RUN gem install oily_png -v 1.1.2
RUN gem install singularitygs -v "~>1.4"

WORKDIR /data