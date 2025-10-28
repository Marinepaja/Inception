# use debian as the base image
FROM debian:bookworm

# Install PHP and necessary extensions
RUN apt update &&\
    apt upgrade -y &&\
    apt install -y php\
                    php-fpm \
                    php-mysql \
                    mariadb-client \
                    curl

# Expose port 9000 for accessing php-fpm
EXPOSE 9000

# Copy the configuration file for php-fpm
COPY conf/www.conf /etc/php/fpm/pool.d/

# Create the directory for the WordPress site
RUN mkdir -p /var/www/mlaporte/wordpress

# Create the directory for PHP socket files
RUN mkdir /run/php/

# Copy the WordPress configuration script
COPY tools/wpscript.sh /

# Set the appropriate permissions on the WordPress directory
RUN chown -R root:root /var/www/mlaporte/wordpress/

# Set the entrypoint for the configuration script execution
ENTRYPOINT ["sh", "/wpscript.sh"]