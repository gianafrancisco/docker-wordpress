service mysql start
echo "create database wordpress" >/tmp/database
mysql -u root --password=toor < /tmp/database
