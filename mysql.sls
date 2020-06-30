DBcreate: CREATE DATABASE wordpress;
DBgrant: GRANT SELECT, INSERT, UPDATEM DELETE, CREATE, DROP, ALTER ON
wordpress.* TO {{ pillar['DBuser']}}@localhost IDENTIFIED BY {{ pillar['DBuser']}};
DBflush: FLUSH PRIVILEGES;
