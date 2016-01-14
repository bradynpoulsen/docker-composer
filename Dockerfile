FROM php:7-cli

RUN apt-get update
RUN apt-get install -y curl git zlib1g-dev
RUN docker-php-ext-install json
RUN docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer

COPY bin/with-ssh-agent /bin/with-ssh-agent
RUN chmod +x /bin/with-ssh-agent

VOLUME ["/code"]
WORKDIR /code

ENTRYPOINT ["with-ssh-agent", "composer", "--ignore-platform-reqs"]
