#!/bin/bash
# Setup: Create sample data files

# CSV data file
cat > /root/data.csv << 'EOF'
name,department,salary
Alice,Engineering,95000
Bob,Marketing,72000
Charlie,Engineering,105000
Diana,Sales,68000
Eve,Engineering,88000
Frank,Marketing,71000
Grace,Sales,82000
Hank,Engineering,97000
Ivy,Marketing,76000
Jack,Sales,91000
EOF

# Config file for sed exercise
cat > /root/app.conf << 'EOF'
database_host=localhost
database_port=5432
database_name=myapp
cache_host=localhost
cache_port=6379
log_level=info
max_connections=100
timeout=30
EOF

# Log file for combining tools
cat > /root/sample.log << 'EOF'
2026-03-29 10:00:01 the quick brown fox jumps over the lazy dog
2026-03-29 10:00:02 docker container started successfully on port 8080
2026-03-29 10:00:03 the database connection pool is ready
2026-03-29 10:00:04 kubernetes pod scheduled on node worker-1
2026-03-29 10:00:05 the service mesh proxy is healthy
2026-03-29 10:00:06 container image pulled from registry
2026-03-29 10:00:07 the load balancer health check passed
2026-03-29 10:00:08 kubernetes deployment scaled to 3 replicas
2026-03-29 10:00:09 the certificate renewal completed successfully
2026-03-29 10:00:10 docker network bridge configured
2026-03-29 10:00:11 the ingress controller updated routes
2026-03-29 10:00:12 pod health check failed for service-api
2026-03-29 10:00:13 the metrics endpoint is responding
2026-03-29 10:00:14 container restart policy set to always
2026-03-29 10:00:15 the cluster autoscaler added a new node
EOF

echo "Setup complete. Data files created in /root/"

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
