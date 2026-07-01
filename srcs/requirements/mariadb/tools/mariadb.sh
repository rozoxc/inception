#!/bin/bash
if [ ! -f /var/lib/mysql/${SQL_DATABASE} ]; then
    service mariadb start
    sleep 3

    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

    mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
else
    echo "mariadb database already inizialized :)"
fi
exec mysqld_safe
