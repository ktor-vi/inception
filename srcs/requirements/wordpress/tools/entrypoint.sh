#!/bin/bash

# Si le dossier /var/www/html est vide, alors on copie WordPress
    rm -rf /var/www/html/*
    cp -R /tmp/wordpress/* /var/www/html/
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html

echo "<?php phpinfo(); ?>" > /var/www/html/info.php
# Démarrer PHP-FPM
exec php-fpm7.4 -F
