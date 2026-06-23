FROM debian:bullseye
RUN apt-get update -y && apt-get install -y \
    php7.4-fpm \
    php-mysql \
    curl \
    wget
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
RUN mkdir -p /var/www/wordpress 
RUN chown -R  www-data:www-data  /var/www/wordpress
RUN mkdir -p /run/php
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/wp.sh /usr/local/bin 
RUN chmod +x /usr/local/bin/wp.sh
EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/wp.sh"]