#!/bin/bash

tee -a /etc/rsyslog.conf > /dev/null <<EOT

##Enable sending of logs over UDP add the following line:
*.* @10.0.7.202:514
##Enable sending of logs over TCP add the following line:
*.* @@10.0.7.202:514
##Set disk queue when rsyslog server will be down:
\$ActionQueueFileName queue
\$ActionQueueMaxDiskSpace 1g
\$ActionQueueSaveOnShutdown on
\$ActionQueueType LinkedList
\$ActionResumeRetryCount -1
EOT

systemctl restart rsyslog
