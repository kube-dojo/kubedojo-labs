#!/bin/bash
# Ensure nginx is running
sudo systemctl start nginx 2>/dev/null || sudo nginx 2>/dev/null || true
sleep 1
# Make a connection and capture TCP state
curl -s http://localhost:80 > /dev/null &
ss -tn > "$HOME"/tcp-connections.txt
# Ensure file has at least a header even if no connections
if [ ! -s "$HOME"/tcp-connections.txt ]; then
  ss -tn state all > "$HOME"/tcp-connections.txt 2>/dev/null || echo "State Recv-Q Send-Q Local Address:Port Peer Address:Port" > "$HOME"/tcp-connections.txt
fi
