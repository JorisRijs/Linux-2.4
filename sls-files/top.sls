base:
  '*':
    - essentialapplication
    - getGitFiles
    - ncpa
    - addncpa
  'Salt-Master-383013':
    - client_rsyslog
  'Salt-Minion-383013':
    - client_rsyslog
  'docker*':
    - client_rsyslog
    - docker
    - runcontainer
  'wordpress*':
    - client_rsyslog
    - wordpress
