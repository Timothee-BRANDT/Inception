FROM alpine:3.16

ARG MYSQL_DATABASE MYSQL_USER MYSQL_ROOT_PASSWORD MYSQL_PASSWORD MYSQL_HOST

RUN apk update && apk upgrade && apk add --no-cache \
    php8 \
    php8-curl \
    php8-dom \
    php8-exif \
    php8-fileinfo \
    php8-fpm \
    php8-json \
    php8-mbstring \
    php8-mysqli \
    php8-openssl \
    php8-xml \
    php8-zip \
    wget \
    unzip && \
    sed -i "s/listen = 127.0.0.1:9000/listen = 9000/g" /etc/php8/php-fpm.d/www.conf

WORKDIR /var/www

RUN wget https://wordpress.org/latest.zip && unzip latest.zip && cp -rf wordpress/* . && rm -rf wordpress latest.zip

COPY conf/wp.sh .

# allow wordpress to write in wp-content folder
RUN sh wp.sh && rm wp.sh && chmod -R 0777 wp-content/

CMD ["php-fpm8", "--nodaemonize"]
