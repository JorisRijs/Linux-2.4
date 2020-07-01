set up rsyslog:
  cmd.run:
    - name: sudo -i
    - name: echo '$ModLoad imudp
      $UDPServerRun 514
      $ModLoad imtcp
      $InputTCPServerRun 514' >> /etc/rsyslog.conf
    - name: echo '
      $AllowedSender TCP, 127.0.0.1, 192.168.0.0/24, *.example.com
      $AllowedSender UDP, 127.0.0.1, 192.168.0.0/24, *.example.com
      ' >> /etc/rsyslog.conf
    - name: sed '/\GLOBAL DIRECTIVE\/i $template remote-incoming-logs,
      "/var/log/%HOSTNAME%/%PROGRAMNAME%.log"
      *.* ?remote-incoming-logs/' /etc/rsyslog.conf
starting rsyslog:
  cmd.run:
    - name: rsyslogd -f /etc/rsyslog.conf -N1
    - name: sudo -i
    - name: systemctl restart rsyslog
