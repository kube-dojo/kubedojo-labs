#!/bin/bash
# Solution: Create troubleshooting report
cat > /root/troubleshooting-report.txt << 'EOF'
=== Problem ===
The broken-app.service is in a failed state. Multiple ERROR and CRITICAL
messages were found in system logs including database timeouts, port conflicts,
and authentication failures.

=== Investigation Steps ===
1. Gathered system information (hostname, kernel, uptime, disk, memory)
2. Listed failed services with systemctl list-units --failed
3. Checked broken-app.service status with systemctl status
4. Searched /var/log/syslog for ERROR and CRITICAL entries

=== Root Cause ===
The broken-app.service is configured to run /usr/local/bin/broken-app which
does not exist on the filesystem. The service fails immediately on start.

=== Fix ===
1. Install or create the /usr/local/bin/broken-app binary
2. Verify the ExecStart path in /etc/systemd/system/broken-app.service
3. Run systemctl daemon-reload && systemctl start broken-app.service
4. Address the other log errors (database, port, auth) separately
EOF
echo "Report created."
