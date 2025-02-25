FROM debian:oldstable

# Installer PHP et les extensions nécessaires
RUN apt-get update && \
    apt-get install -y wget php php-fpm mariadb-client php-mysqli php-curl php-xml php-mbstring && \
    rm -rf /var/lib/apt/lists/*

# Télécharger et extraire WordPress dans /tmp
RUN mkdir -p /tmp/wordpress && \
    wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xvzf /tmp/wordpress.tar.gz -C /tmp/wordpress --strip-components=1

# Créer le dossier pour PHP-FPM socket
RUN mkdir -p /run/php

# Copier le script d'entrée
COPY ./tools/entrypoint.sh /entrypoint.sh
COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/ 

RUN chmod +x /entrypoint.sh

EXPOSE 9000
# Définir le point d’entrée
ENTRYPOINT ["/entrypoint.sh"]

