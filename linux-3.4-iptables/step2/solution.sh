#!/bin/bash
# Start nginx
systemctl start nginx 2>/dev/null || nginx 2>/dev/null || true
sleep 1

# Block port 8080
iptables -A INPUT -p tcp --dport 8080 -j DROP

# Verify port 80 still works
curl -s http://localhost:80 > /dev/null && echo "Port 80 is accessible"
