#!/bin/bash
# Solution: Create and start a custom service
if command -v systemctl > /dev/null 2>&1 && systemctl is-system-running > /dev/null 2>&1; then
  # Full systemd available (Killercoda VM)
  cat > /etc/systemd/system/myservice.service << 'EOF'
[Unit]
Description=My Custom Service
After=network.target

[Service]
Type=simple
ExecStart=/opt/myservice/run.sh
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

  systemctl daemon-reload
  systemctl start myservice
  systemctl status myservice
else
  # Docker fallback: run the service script in background
  /opt/myservice/run.sh &
  echo $! > /var/run/myservice.pid
  sleep 1
  echo "myservice started (PID: $(cat /var/run/myservice.pid))"
fi
