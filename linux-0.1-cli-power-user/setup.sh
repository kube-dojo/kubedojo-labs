#!/bin/bash
# Setup for CLI Power User lab

# Create sample Apache access log for text processing step
cat > /root/access.log << 'LOGEOF'
192.168.1.10 - - [29/Mar/2026:10:15:30 +0000] "GET /index.html HTTP/1.1" 200 1234
10.0.0.5 - - [29/Mar/2026:10:15:31 +0000] "POST /api/login HTTP/1.1" 200 567
192.168.1.10 - - [29/Mar/2026:10:15:32 +0000] "GET /style.css HTTP/1.1" 200 890
172.16.0.100 - - [29/Mar/2026:10:15:33 +0000] "GET /index.html HTTP/1.1" 304 0
10.0.0.5 - - [29/Mar/2026:10:15:34 +0000] "GET /dashboard HTTP/1.1" 200 4567
192.168.1.20 - - [29/Mar/2026:10:15:35 +0000] "GET /about HTTP/1.1" 200 2345
172.16.0.100 - - [29/Mar/2026:10:15:36 +0000] "POST /api/data HTTP/1.1" 201 123
10.0.0.5 - - [29/Mar/2026:10:15:37 +0000] "GET /favicon.ico HTTP/1.1" 404 0
192.168.1.10 - - [29/Mar/2026:10:15:38 +0000] "GET /images/logo.png HTTP/1.1" 200 5678
192.168.1.20 - - [29/Mar/2026:10:15:39 +0000] "GET /contact HTTP/1.1" 200 3456
LOGEOF

echo "Setup complete."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
