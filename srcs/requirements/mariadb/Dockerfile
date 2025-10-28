FROM debian:bookworm

# Install MariaDB
# Install procps to use the command 'ps' to check if MariaDB is running
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server mariadb-client
RUN apt-get install -y procps

# Copy the MariaDB configuration file
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Create necessary directories and set permissions
RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld/
RUN chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/


# Expose port 3306 for MariaDB
EXPOSE 3306

# Copy the database initialization script and make it executable
COPY ./tools/dbscript.sh ./
RUN chmod +x ./dbscript.sh

ENTRYPOINT ["bash", "./dbscript.sh"]