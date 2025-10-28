# use debian as the base image
FROM debian:bookworm


## Update and install nginx
RUN apt-get update -y 
RUN apt-get install -y nginx
RUN apt-get install -y vim
RUN apt-get install -y curl
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install -y openssl

## Self-signed SSL certificate
# req - new request
# x509 - create a self-signed certificate
# nodes - no DES, do not encrypt the private key
# days - validity of the certificate in days
# keyout - output file for the private key
# out - output file for the certificate	
# subj - subject information for the certificate
# newkey rsa:2048 - generate a new RSA key of 2048 bits
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mlaporte.42.fr"

# copy the provided config file to the container
RUN mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expose port 443
EXPOSE 443

# Create a simple index.html file
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Start Nginx in the foreground
# Sets the default command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]

# Start Nginx in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]




