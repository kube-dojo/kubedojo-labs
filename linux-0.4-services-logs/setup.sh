#!/bin/bash
# Setup for Services and Logs lab

# Install nginx
apt-get update -qq && apt-get install -y -qq nginx > /dev/null 2>&1

# Stop nginx so student can start it
systemctl stop nginx 2>/dev/null || true
# Docker fallback: kill nginx process directly
pkill nginx 2>/dev/null || true

# Create a simple script for the custom service step
mkdir -p /opt/myservice
cat > /opt/myservice/run.sh << 'EOF'
#!/bin/bash
while true; do
  echo "$(date): myservice is running" >> /var/log/myservice.log
  sleep 10
done
EOF
chmod +x /opt/myservice/run.sh

echo "Setup complete."
