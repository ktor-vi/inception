#!/bin/bash
set -e

# If data directory is empty, initialize the database
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing MySQL data directory..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql

  # Start MySQL server temporarily to create databases and users
  echo "Starting MySQL server temporarily..."
  mysqld --user=mysql &
  
  # Wait for MySQL to start
  until mysqladmin ping -s 2>/dev/null; do
    echo "Waiting for MySQL to be ready..."
    sleep 1
  done

  # Now that MySQL is running, create the database and users
  echo "Creating database and user..."
  mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
  mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
  mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
  mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
  mysql -e "FLUSH PRIVILEGES;"
  
  # Shut down the temporary server
  echo "Shutting down temporary MySQL server..."
  mysqladmin shutdown
  
  echo "MySQL initialization completed!"
fi

echo "Starting MySQL server..."
exec mysqld --user=mysql
