base:
  '*':
    - essentialapplication
    - ncpa
    - addncpa
    - client_rsyslog
  'docker*':
    - docker
    - runcontainer
  '*minion*':
    - nagios
  'wordpress*':
    - wordpress
