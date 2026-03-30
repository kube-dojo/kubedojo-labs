#!/bin/bash
# Solution: Show multi-user.target dependencies or equivalent
if systemctl list-dependencies multi-user.target --no-pager > /root/multiuser-deps.txt 2>/dev/null && [ -s /root/multiuser-deps.txt ]; then
  cat /root/multiuser-deps.txt
else
  # Docker fallback: list available systemd unit files or running services
  {
    echo "=== Running services ==="
    ps -eo comm --no-headers | sort -u
  } > /root/multiuser-deps.txt
  cat /root/multiuser-deps.txt
fi
