#! /bin/bash

DBuser=$1
DBpassword=$2
Nagiospassword=$3
Nagioshost=$4
MySQLrootPassword1=$5

sudo -i

apt update
apt install wordpress php libapache2-mod-php mysql-server php-mysql -y
touch /etc/apache2/sites-available/wordpress.conf
echo "Alias /blog /usr/share/wordpress
<Directory /usr/share/wordpress>
    Options FollowSymLinks
    AllowOverride Limit Options FileInfo
    DirectoryIndex index.php
    Order allow,deny
    Allow from all
</Directory>
<Directory /usr/share/wordpress/wp-content>
    Options FollowSymLinks
    Order allow,deny
    Allow from all
</Directory>" >> /etc/apache2/sites-available/wordpress.conf
a2ensite wordpress
a2enmod rewrite
service apache2 reload
mysql -u root -e "CREATE DATABASE wordpress;"
mysql -u root -e "CREATE USER '$DBuser'@'localhost' IDENTIFIED BY '$DBpassword';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "GRANT SELECT, UPDATE, DELETE, CREATE, DROP, ALTER ON wordpress.* TO '$DBuser'@localhost IDENTIFIED BY '$DBpassword';"
mysql -u root -e "FLUSH PRIVILEGES;"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
service mysql start

echo d"<?php
define('DB_NAME', '$DBuser);
define('DB_USER', '$DBuser');
define('DB_PASSWORD', '$DBpassword');
define('DB_HOST', 'localhost');
define('DB_COLLATE', 'utf8_general_ci');
define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
?>" >> /etc/wordpress/config-$(hostname -i).php
