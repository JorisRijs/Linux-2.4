{% set pillar = pillar.get('DBinfo', {}) %}
{% set pillar = pillar.get('mysql', {}) %}
wordpress:
  cmd.run:
    - name: sudo apt update
    - name: sudo apt install wordpress php libapache2-mod-php mysql-server php-mysql
    - name: sudo touch /etc/apache2/sites-availible/wordpress.conf
    - name: sudo echo "Alias /blog /usr/share/wordpress
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
    - name: sudo a2ensite wordpress
    - name: sudo a2enmod rewrite
    - name: sudo service apache2 reload
    - name: sudo mysql -u root -p Pa$$w0rd < CREATE DATABASE wordpress;
    - name: sudo mysql -u root -p Pa$$w0rd < GRANT SELECT, UPDATE, DELETE, CREATE, DROP, ALTER ON wordpress.* TO WordPressUser@localhost IDENTIFIED BY Pa$$w0rd;
    - name: sudo mysql -u root -p Pa$$w0rd < FLUSH PRIVILEGES;
    - name: sudo echo "<?php
      define('DB_NAME', 'WordPressUser');
      define('DB_USER', 'WordPressUser');
      define('DB_PASSWORD', ''Pa$$w0rd);
      define('DB_HOST', 'localhost');
      define('DB_COLLATE', 'utf8_general_ci');
      define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
      ?>" >> /etc/wordpress/config-localhost.php
    - name: sudo service mysql start
