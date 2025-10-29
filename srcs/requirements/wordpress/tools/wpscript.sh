#!/bin/bash

if [ -f "/var/www/mlaporte/wp-config.php" ]
then 
    sleep 5
else
    sleep 20

	# Download WP-CLI (WordPress Command Line Interface)
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp 

	#Download  core files for two different sites
	wp core download --allow-root --version=6.4 --path=/var/www/mlaporte


	cd /var/www/mlaporte/wordpress
	if ! wp core is-installed ; then
		# Download and set up WordPress using WP-CLI (WordPress Command Line Interface)

	wp config create --allow-root --dbname=${SQL_DATABASE} \
				--dbuser=${SQL_USER} \
				--dbpass=${SQL_PASSWORD} \
				--dbhost=${SQL_HOST} \
				--url=https://${DOMAIN_NAME};

	# Install WordPress
	wp core install	--allow-root \
				--url=https://${DOMAIN_NAME} \
				--title=${SITE_TITLE} \
				--admin_user=${ADMIN_USER} \
				--admin_password=${ADMIN_PASSWORD} \
				--admin_email=${ADMIN_EMAIL};

	# Create an additional user with author role
	wp user create		--allow-root \
				${USER1_LOGIN} ${USER1_MAIL} \
				--role=author \
				--user_pass=${USER1_PASS} ;


wp cache flush --allow-root

# it provides an easy-to-use interface for creating custom contact forms and managing submissions, as well as supporting various anti-spam techniques
wp plugin install contact-form-7 --activate

# set the site language to English
wp language core install en_US --activate

# remove default themes and plugins
wp theme delete twentynineteen twentytwenty
wp plugin delete hello

# set the permalink structure
wp rewrite structure '/%postname%/'

fi
fi

if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

# start the PHP FastCGI Process Manager (FPM) for PHP version 8.2 in the foreground
exec /usr/sbin/php-fpm8.2 -F -R