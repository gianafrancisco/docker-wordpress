FROM ubuntu

ADD fs/ /

MAINTAINER Francisco Giana <gianafrancisco@gmail.com>

RUN apt-get update && \
	apt-get -y install libmysqlclient18 php5-common php5-gd php-pear php-db libapache2-mod-php5 php-mail apache2 php5-mysql && \
        rm -f /etc/apache2/sites-available/000-default.conf && \
        mv /etc/apache2/sites-available/000-default.conf.wordpress /etc/apache2/sites-available/000-default.conf && \
	echo "mysql-server mysql-server/root_password password toor" | debconf-set-selections && \
	echo "mysql-server mysql-server/root_password_again password toor" | debconf-set-selections && \
	apt-get -y install mysql-server && \
	sh /mysqlSchema.sh && \
	cd /var/www/ && tar -zxvf latest.tar.gz && chown -R www-data.www-data wordpress

EXPOSE 80

VOLUME ["/var/lib/mysql", "/var/www/"]

ENTRYPOINT /init.sh

