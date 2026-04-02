#!/bin/bash
if id "ubuntu" &>/dev/null; then
  TARGET_USER="ubuntu"
  USER_HOME="/home/ubuntu"
else
  TARGET_USER="root"
  USER_HOME="/root"
fi
mkdir -p "$USER_HOME/configs"
cat > "$USER_HOME/configs/nginx.conf" << 'CONFEOF'
sever {
    listn 80;
    sever_name localhost;
    location / {
        root /var/www/html;
    }
}
CONFEOF
chown -R $TARGET_USER:$TARGET_USER "$USER_HOME/configs" 2>/dev/null || true
