#!/bin/bash
# Setup: Create sample log files

# Apache access log
cat > /root/access.log << 'EOF'
192.168.1.10 - - [29/Mar/2026:10:00:01 +0000] "GET /index.html HTTP/1.1" 200 1234
10.0.0.5 - - [29/Mar/2026:10:00:02 +0000] "GET /api/users HTTP/1.1" 200 5678
192.168.1.10 - - [29/Mar/2026:10:00:03 +0000] "POST /api/login HTTP/1.1" 401 89
172.16.0.20 - - [29/Mar/2026:10:00:04 +0000] "GET /images/logo.png HTTP/1.1" 200 45678
10.0.0.5 - - [29/Mar/2026:10:00:05 +0000] "GET /api/products HTTP/1.1" 500 234
192.168.1.10 - - [29/Mar/2026:10:00:06 +0000] "GET /about HTTP/1.1" 200 3456
10.0.0.15 - - [29/Mar/2026:10:00:07 +0000] "GET /api/orders HTTP/1.1" 503 123
172.16.0.20 - - [29/Mar/2026:10:00:08 +0000] "GET /css/style.css HTTP/1.1" 200 8901
10.0.0.5 - - [29/Mar/2026:10:00:09 +0000] "DELETE /api/users/5 HTTP/1.1" 500 456
192.168.1.10 - - [29/Mar/2026:10:00:10 +0000] "GET /contact HTTP/1.1" 200 2345
10.0.0.5 - - [29/Mar/2026:10:00:11 +0000] "GET /api/health HTTP/1.1" 200 12
172.16.0.20 - - [29/Mar/2026:10:00:12 +0000] "GET /js/app.js HTTP/1.1" 200 67890
192.168.1.30 - - [29/Mar/2026:10:00:13 +0000] "GET /admin HTTP/1.1" 403 789
10.0.0.5 - - [29/Mar/2026:10:00:14 +0000] "POST /api/orders HTTP/1.1" 502 345
10.0.0.15 - - [29/Mar/2026:10:00:15 +0000] "GET /api/inventory HTTP/1.1" 500 567
192.168.1.10 - - [29/Mar/2026:10:00:16 +0000] "GET /faq HTTP/1.1" 200 4567
172.16.0.20 - - [29/Mar/2026:10:00:17 +0000] "GET /images/banner.jpg HTTP/1.1" 200 123456
10.0.0.5 - - [29/Mar/2026:10:00:18 +0000] "GET /api/search?q=test HTTP/1.1" 200 890
192.168.1.30 - - [29/Mar/2026:10:00:19 +0000] "POST /api/login HTTP/1.1" 200 1234
10.0.0.15 - - [29/Mar/2026:10:00:20 +0000] "GET /api/status HTTP/1.1" 502 234
EOF

# Syslog-style log
cat > /root/app.log << 'EOF'
2026-03-29T10:00:01Z INFO  Application started on port 8080
2026-03-29T10:00:05Z ERROR Database connection pool exhausted
2026-03-29T10:00:09Z WARN  Slow query detected: 2.5s for /api/users
2026-03-29T10:00:14Z ERROR Failed to process order #1234
2026-03-29T10:00:15Z ERROR Upstream service timeout: inventory-service
2026-03-29T10:00:20Z INFO  Health check passed
2026-03-29T10:01:01Z WARN  Memory usage at 85%
2026-03-29T10:01:05Z ERROR Connection refused to redis:6379
EOF

echo "Setup complete. Log files created at /root/access.log and /root/app.log"
