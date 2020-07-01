#!/bin/bash
tobesettoken = $1

sudo -i
echo "deb https://repo.nagios.com/deb/bionic /" > /etc/apt/sources.list.d/nagios.list
wget -qO - https://repo.nagios.com/GPG-KEY-NAGIOS-V2 | apt-key add -

apt-get update
apt install ncpa -y

sed -i "s/my_token/$tobesettoken/" /usr/local/ncpa/etc/ncpa.cfg

