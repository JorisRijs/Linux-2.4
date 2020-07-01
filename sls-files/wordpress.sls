{%set pillar = pillar.get('DBinfo', {})%}
wordpress:
  cmd.run:
      - name: sudo -i ; chmod 777 /root/Linux-2.4/wordpress.sh; sh /root/Linux-2.4/wordpress.sh {{pillar['DBuser'] }} {{ pillar['DBpassword'] }} {{ pillar['Nagiospassword'] }} {{pillar['Nagioshost'] }} {{ pillar['Mysqlrootpw'] }}
