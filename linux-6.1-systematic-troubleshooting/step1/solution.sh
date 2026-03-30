#!/bin/bash
# Solution: Create system report
cat > /root/system-report.txt << EOF
=== System Report ===
Hostname: $(hostname)
Kernel: $(uname -r)
Uptime: $(uptime)

=== Disk Usage ===
$(df -h)

=== Memory ===
$(free -m)
EOF
echo "Report created."
cat /root/system-report.txt
