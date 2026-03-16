# 1. Base Image
FROM debian:bullseye

# 2. System Update & Installation
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server

# 3. Network Configuration
RUN sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# 4. Preparation
COPY ./tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

# 5. Port and Execution
EXPOSE 3306
ENTRYPOINT ["/usr/local/bin/script.sh"]
CMD ["mysqld"]