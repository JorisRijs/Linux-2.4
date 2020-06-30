#! /bin/bash

DBuser = $1
DBpassword = $2
Nagiospassword= $3
Nagioshost = $4
MySQLrootPassword = $5

sudo -i
echo "deb https://repo.nagios.com/deb/bionic /" >:w:q /etc/apt/sources.list.d/nagios.list

apt-get update
apt-get install ncpa

sudo apt update
sudo apt install wordpress php libapache2-mod-php mysql-server php-mysql
sudo touch /etc/apache2/sites-availible/wordpress.conf
sudo echo "Alias /blog /usr/share/wordpress
<Directory /usr/share/wordpress>
    Options FollowSymLinks
    AllowOverride Limit Options FileInfo
   index.php
  Order allow,deny
  Allow from all
</Directory>
<Directory /usr/share/wordpress/wp-content>
Options FollowSymLinks
Order allow,deny
Allow from all
</Directory>" >> /etc/apache2/sites-available/wordpress.conf
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo service apache2 reload
sudo mysql -u root -p $DPpassword < CREATE DATABASE wordpress;
sudo mysql -u root -p $DBpassword < GRANT SELECT, UPDATE, DELETE, CREATE, DROP, ALTER ON wordpress.* TO $DBuser@localhost IDENTIFIED BY $DBpassword;
sudo mysql -u root -p $DBpassword < FLUSH PRIVILEGES;

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql.conf.d/mysqld.cnf
sudo service mysql start

sudo echo "<?php
define('DB_NAME', '{{pillar['DBuser']}}');
define('DB_USER', '{{pillar['DBuser']}}');
define('DB_PASSWORD', ''{{pillar['DBpassword']}});
define('DB_HOST', 'localhost');
define('DB_COLLATE', 'utf8_general_ci');
define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
?>" >> /etc/wordpress/config-localhost.php
