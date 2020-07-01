{% set pillar = pillar.get('DBinfo', {}) %}
install nagios:

  pkgrepo.managed:
      - name: deb https://repo.nagios.com/deb/bionic /
      - file: /etc/apt/sources.list.d/nagios.list
add key:
  cmd.run:
    - name: sudo -i
    - name: wget -qO - https://repo.nagios.com/GPG-KEY-NAGIOS-V2 | apt-key add -
install ncpa:
  pkg.installed:
    - pkgs:
      - ncpa
  cmd.run:
    - name: sudo -i
    - name: sed -i "s/mytoken/{{pillar['Nagiostoken']}}/" /usr/local/ncpa/etc/ncpa.cfg 
    - name: systemctl restart ncpa_listener
