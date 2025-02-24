#!/bin/bash

# Si le dossier /var/www/html est vide, alors on copie WordPress
if [ ! "$(ls -A /var/www/html)" ]; then
    echo "📂 /var/www/html is empty, copying WordPress..."
    cp -R /tmp/wordpress/* /var/www/html/
    chown -R www-data:www-data /var/www/html
else
    echo "✅ is installed"
fi

# Démarrer PHP-FPM
exec php-fpm7.4 -F
