#algemeen
  Alle moeten worden ingericht via Saltstack
  Tijdens het opstarten van een VM mag je een script (userdata) meegeven zodat
  Saltstack minion serivces worden geinstalleerd
  System logs moeten automatich naar de log server worden gestuurd
  alle servers moeten automatich aan de logserver worden toegevoegd

- VM 1
  - Salt minion
  - Salt master
- VM 2
  - Salt minion
  - Nagios host
  - Syslog host
- VM 3
  - Salt minion
  - Wordpress
- VM 4
  - Salt minion
  - Docker
