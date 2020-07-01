# algemeen<br>
  Alle moeten worden ingericht via Saltstack<br>
  Tijdens het opstarten van een VM mag je een script (userdata) meegeven zodat<br>
  Saltstack minion serivces worden geinstalleerd<br>
  System logs moeten automatich naar de log server worden gestuurd<br>
  alle servers moeten automatich aan de logserver worden toegevoegd<br>

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
  - Docker<br>
<b>DIT ZIJN DE VOORLOPIGE SCRIPTS, HIER KUNNEN NOG VERANDERING IN WORDEN AANGEBRACHT (in overleg met Dhr. J.Bos)</b>
