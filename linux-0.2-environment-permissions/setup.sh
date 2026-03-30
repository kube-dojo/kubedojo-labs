#!/bin/bash
# Setup for Environment and Permissions lab

# Create /opt/myapp structure for permissions exercises
mkdir -p /opt/myapp/bin /opt/myapp/config /opt/myapp/logs
echo '#!/bin/bash' > /opt/myapp/bin/start.sh
echo 'echo "App started"' >> /opt/myapp/bin/start.sh
chmod +x /opt/myapp/bin/start.sh
echo "db_host=localhost" > /opt/myapp/config/app.conf
echo "App log entry" > /opt/myapp/logs/app.log

# Install acl package for step 4
apt-get update -qq && apt-get install -y -qq acl > /dev/null 2>&1

# Create shared.txt for ACL step
echo "This is a shared file for ACL testing." > /root/shared.txt

# Create www-data user if it doesn't exist
id www-data > /dev/null 2>&1 || useradd -r -s /usr/sbin/nologin www-data

echo "Setup complete."
