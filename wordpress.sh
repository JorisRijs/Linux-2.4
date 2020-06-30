#! /bin/bash

DBuser = $1
DBpassword = $2
Nagiospassword= $3
Nagioshost = $4
MySQLrootPassword = $5

sudo -i
echo "deb https://repo.nagios.com/deb/bionic /" > /etc/apt/sources.list.d/nagios.list
wget -qO - https://repo.nagios.com/GPG-KEY-NAGIOS-V2 | apt-key add -

apt-get update
apt-get install ncpa -y

apt update
apt install wordpress php libapache2-mod-php mysql-server php-mysql -y
touch /etc/apache2/sites-available/wordpress.conf
echo "Alias /blog /usr/share/wordpress
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
a2ensite wordpress
a2enmod rewrite
service apache2 reload
mysql -u root -p $DPpassword -e "CREATE DATABASE wordpress;"
mysql -u root -p $DBpassword -e "GRANT SELECT, UPDATE, DELETE, CREATE, DROP, ALTER ON wordpress.* TO $DBuser@localhost IDENTIFIED BY $DBpassword;"
mysql -u root -p $DBpassword -e "FLUSH PRIVILEGES;"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
service mysql start

echo "<?php
define('DB_NAME', '{{pillar['DBuser']}}');
define('DB_USER', '{{pillar['DBuser']}}');
define('DB_PASSWORD', ''{{pillar['DBpassword']}});
define('DB_HOST', 'localhost');
define('DB_COLLATE', 'utf8_general_ci');
define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
?>" >> /etc/wordpress/config-localhost.php
