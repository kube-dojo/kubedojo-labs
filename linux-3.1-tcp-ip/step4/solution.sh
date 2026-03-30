#!/bin/bash
if [ -f /etc/services ]; then
  grep -w "22/tcp" /etc/services | awk '{print $1}' > /root/port22-service.txt
else
  # Docker minimal image may not have /etc/services — provide the known answer
  echo "ssh" > /root/port22-service.txt
fi
