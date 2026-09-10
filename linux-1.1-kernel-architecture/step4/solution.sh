#!/bin/bash
# Solution: Save last 20 lines of dmesg
if sudo dmesg > /dev/null 2>&1; then
  sudo dmesg | tail -20 > "$HOME"/dmesg-tail.txt
else
  # Docker fallback: dmesg may be restricted, use /var/log/kern.log or syslog
  if [ -f /var/log/kern.log ]; then
    sudo tail -20 /var/log/kern.log > "$HOME"/dmesg-tail.txt
  else
    echo "dmesg not available in this container environment" > "$HOME"/dmesg-tail.txt
  fi
fi
cat "$HOME"/dmesg-tail.txt
