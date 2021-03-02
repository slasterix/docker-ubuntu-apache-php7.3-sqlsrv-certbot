FROM slasterix/docker-ubuntu-apache-php7.3-sqlsrv-driver
ARG DEBIAN_FRONTEND=noninteractive
RUN \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    add-apt-repository ppa:certbot/certbot && \
    apt-get update && \
    apt-get install -y certbot python-certbot-apache python3-certbot-dns-route53
COPY crontab /etc/cron.d/certbot
RUN chmod 0644 /etc/cron.d/certbot
RUN service cron start
RUN groupadd -g 1000 www
RUN useradd -u 1000 -g www www \
    && chown -R www:www /var/www/html
RUN usermod -a -G www-data www    
USER www
