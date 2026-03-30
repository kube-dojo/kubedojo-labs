#!/bin/bash
# Solution: Save last 20 lines of dmesg
if dmesg > /dev/null 2>&1; then
  dmesg | tail -20 > /root/dmesg-tail.txt
else
  # Docker fallback: dmesg may be restricted, use /var/log/kern.log or syslog
  if [ -f /var/log/kern.log ]; then
    tail -20 /var/log/kern.log > /root/dmesg-tail.txt
  else
    echo "dmesg not available in this container environment" > /root/dmesg-tail.txt
  fi
fi
cat /root/dmesg-tail.txt
