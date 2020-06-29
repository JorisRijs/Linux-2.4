#!/bin/bash

sudo ufw allow "apache"
sudo ufw allow "apache Full"
sudo ufw allow "apache Secure"

sudo sed -i 's/index.php/index.html/' /etc/apache2.mods-enabled/dir.conf
sudo sed -i 's/index.html/index.php/' /etc/apache2.mods-enabled/dir.conf
sudo systemctl restart apache2

mysql -h "localhost" -u "root" < "setup.sql"

sudo touch /etc/apache2/sites-available/wordpress.conf
echo "<Directory /var/www/wordpress /> AllowOverride All </Directory>"
sudo a2enmod rewrite
sudo apache2ctl configtest

cd /tmp
sudo curl -O https://wordpress.org/latest.tar.gz
sudo tar xzvf latest.tar.gz
sudo touch /tmp/worpress/.htaccess
sudo mv /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
sudo mkdir /tmp/wordpress/wp-content/upgrade
sudo cp -a /tmp/wordpress/. /var/www/wordpress

sudo chwon -R www-data:www-data /var/www/wordpress
sudo find /var/www/wordpress/ -type d -exec chmod 750 {} \;
sudo find /var/www/wordpress/ -type f -exec chmod 640 {} \;
sudo curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/wordpress/wp-config.php
sudo sed -i 's/DB_NAME/WordPressDB/' /var/www/wordpress/wp-config.php
sudo sed -i 's/DB_USER/WordPressUSER/' /var/www/wordpress/wp-config.php
sudo sed -i 's/DB_PASSWORD/Pa$$w0rd/' /var/www/wordpress/wp-config.php
echo "define('FS_METHOD', 'direct')"
