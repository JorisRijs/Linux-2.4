{% set pillar = pillar.get('DBinfo', {})%}
add host:
  cmd.run:
      - name: curl -XPOST "http://10.0.7.149/nagiosxi/api/v1/config/host?apikey={{pillar['Nagiostoken']}}&pretty=1" -d "host_name=$(hostname)&address=$(hostname -i)&check_command=check_ping\!3000,80%\!5000,100%&max_check_attempts=2&check_period=24x7&contacts=nagiosadmin&notification_interval=5&notification_period=24x7&applyconfig=1"
