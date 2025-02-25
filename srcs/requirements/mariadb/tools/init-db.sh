#!/bin/bash
set -e

# Exporter les variables d'environnement
export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
export MYSQL_DATABASE=${MYSQL_DATABASE}
export MYSQL_USER=${MYSQL_USER}
export MYSQL_PASSWORD=${MYSQL_PASSWORD}

# Si le répertoire de données est vide, initialiser la base de données
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initialisation du répertoire de données MySQL..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql

  # Démarrer temporairement le serveur MySQL
  echo "Démarrage temporaire du serveur MySQL..."
  mysqld --user=mysql &
  
  # Attendre que MySQL démarre
  until mysqladmin ping -s 2>/dev/null; do
    echo "En attente de la disponibilité de MySQL..."
    sleep 1
  done

  # Créer la base de données et l'utilisateur
  echo "Création de la base de données et de l'utilisateur..."
  mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
  mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
  mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
  mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
  mysql -e "FLUSH PRIVILEGES;"
  
  # Arrêter le serveur MySQL temporaire
  echo "Arrêt du serveur MySQL temporaire..."
  mysqladmin shutdown
  
  echo "Initialisation de MySQL terminée !"
fi

echo "Démarrage de MySQL..."
exec mysqld --user=mysql

