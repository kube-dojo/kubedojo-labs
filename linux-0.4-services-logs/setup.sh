#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
# Seed dummy logs for journalctl simulation
mkdir -p /var/log/journal
echo "Apr 01 12:00:01 server nginx[123]: Starting nginx..." > /var/log/nginx-mock.log
echo "Apr 01 12:00:02 server nginx[123]: Started nginx." >> /var/log/nginx-mock.log
# Mock journalctl to read our file
echo -e '#!/bin/bash\ncat /var/log/nginx-mock.log' > /usr/local/bin/journalctl
chmod +x /usr/local/bin/journalctl
