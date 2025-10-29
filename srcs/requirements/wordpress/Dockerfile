# use debian as the base image
FROM debian:bookworm

# Install PHP and necessary extensions
RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y php-fpm \
                    php-mysql \
                    mariadb-client \
                    curl


# Copy the configuration file for php-fpm
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Create the directory for the WordPress site
RUN mkdir -p /var/www/mlaporte/wordpress

# Create the directory for PHP socket files
# RUN mkdir /run/php/

# Copy the WordPress configuration script
COPY tools/wpscript.sh ./


# Set the appropriate permissions on the WordPress directory
RUN chown -R www-data:www-data /var/www/mlaporte/wordpress
RUN chmod 755 /var/www/mlaporte/wordpress

# Expose port 9000 for accessing php-fpm
EXPOSE 9000
# Set the entrypoint for the configuration script execution
ENTRYPOINT ["bash", "/wpscript.sh"]