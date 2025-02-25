#!/bin/bash

# Si le dossier /var/www/html est vide, alors on copie WordPress
    cp -R /tmp/wordpress/* /var/www/html/
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html

# Démarrer PHP-FPM
exec php-fpm7.4 -F
