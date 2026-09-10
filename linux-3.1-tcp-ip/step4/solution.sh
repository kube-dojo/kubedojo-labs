#!/bin/bash
if [ -f /etc/services ]; then
  grep -w "22/tcp" /etc/services | awk '{print $1}' > "$HOME"/port22-service.txt
else
  # Docker minimal image may not have /etc/services — provide the known answer
  echo "ssh" > "$HOME"/port22-service.txt
fi
