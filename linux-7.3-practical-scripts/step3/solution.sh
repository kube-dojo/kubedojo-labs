#!/bin/bash
# Solution: Create HTML report generator
cat > /root/report.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

OUTPUT="/root/system-report.html"

cat > "$OUTPUT" << EOF
<html>
<head><title>System Report - $(hostname)</title></head>
<body>
<h1>System Report</h1>
<p>Generated: $(date)</p>

<h2>Hostname</h2>
<pre>$(hostname)</pre>

<h2>Uptime</h2>
<pre>$(uptime)</pre>

<h2>Disk Usage</h2>
<pre>$(df -h)</pre>

<h2>Memory Usage</h2>
<pre>$(free -m)</pre>

</body>
</html>
EOF

echo "Report generated: $OUTPUT"
SCRIPT
chmod +x /root/report.sh
/root/report.sh
