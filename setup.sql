ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Pa$$w0rd';
FLUSH PRIVILEGES;

CREATE DATABASE WordPressDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL ON WordPressDB.* TO ' WordPressUser '@'localhost' IDENTIFIED BY 'Pa$$W0rd';
FLUSH PRIVILEGES;
