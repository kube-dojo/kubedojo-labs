#!/bin/bash
# Solution: Create USE checklist
cat > /root/use-checklist.txt << 'EOF'
CPU:
  Utilization: mpstat -P ALL 1 1
  Saturation: vmstat 1 1 (check 'r' column for run queue)
  Errors: dmesg | grep -i "mce"

Memory:
  Utilization: free -m
  Saturation: vmstat 1 1 (check 'si' and 'so' for swap activity)
  Errors: dmesg | grep -i "oom"

Disk:
  Utilization: iostat -xz 1 1
  Saturation: iostat -xz 1 1 (check 'avgqu-sz' for queue length)
  Errors: dmesg | grep -i "error"

Network:
  Utilization: ip -s link
  Saturation: netstat -s | grep -i "retransmit"
  Errors: ip -s link (check errors/dropped counters)
EOF
echo "USE checklist created."
