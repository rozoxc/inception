FROM debian:oldstable
RUN apt-get update -y && apt-get install -y mariadb-server mariadb-client
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/mariadb.sh /usr/local/bin 
RUN chmod +x /usr/local/bin/mariadb.sh
EXPOSE 3306
ENTRYPOINT ["/usr/local/bin/mariadb.sh"]