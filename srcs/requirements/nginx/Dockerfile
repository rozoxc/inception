FROM debian:bullseye
RUN apt-get update -y && apt-get install -y nginx openssl
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout  /etc/nginx/ssl/inception.key -subj "/C=MA/ST=BeniMellal/L=Khouribga/O=1337/OU=42/CN=ababdoul.42.fr/UID=ababdoul"
RUN mkdir -p /var/www/wordpress
RUN chown www-data:www-data /var/www/wordpress
COPY conf/nginx.conf /etc/nginx/nginx.conf
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]