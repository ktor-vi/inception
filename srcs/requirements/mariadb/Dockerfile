FROM debian:oldstable

# Install MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Create directory for MySQL data and fix permissions
RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

# Allow connections from any host
RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Add initialization script - make sure this file exists in the tools directory
COPY ./tools/init-db.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 3306

# The script will handle database initialization and then start MySQL
CMD ["/docker-entrypoint.sh"]
