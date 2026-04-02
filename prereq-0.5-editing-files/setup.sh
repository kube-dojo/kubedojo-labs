#!/bin/bash
for user_home in /root /home/ubuntu; do
  if [ -d "$user_home" ]; then
    mkdir -p "$user_home/configs"
    cat > "$user_home/configs/nginx.conf" << 'CONFEOF'
sever {
    listn 80;
    sever_name localhost;
    location / {
        root /var/www/html;
    }
}
CONFEOF
    if [ "$user_home" == "/home/ubuntu" ]; then
      chown -R ubuntu:ubuntu "$user_home/configs" 2>/dev/null || true
    fi
  fi
done
