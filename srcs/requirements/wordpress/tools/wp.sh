#!/bin/bash
cd /var/www/wordpress
if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress..."

    wp core download --allow-root

    echo "configure database connection ..."

    wp config create --allow-root --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost="mariadb:3306"

    echo "Installing Wordpress core .."

    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="Inception project" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    echo "Creating standard user..."

    wp user create --allow-root \
        "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author

    echo "WordPress Setup Completed!"
fi

echo "Starting PHP-FPM..."

exec php-fpm7.4 -F
