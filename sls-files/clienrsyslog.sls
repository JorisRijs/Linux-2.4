setting up rsyslog on clients:
  cmd.run:
      - name: sudo -i && git clone https://github.com/JorisRijs/Linux-2.4 &&
        chmod 777 /root/Linux-2.4/rsyslog.sh.sh && sh
        /root/Linux-2.4/rsyslog.sh
