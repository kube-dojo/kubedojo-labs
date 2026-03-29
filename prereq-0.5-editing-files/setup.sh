#!/bin/bash
# Create working directory and a config file with typos for step 3
mkdir -p /home/user/configs

cat > /home/user/configs/nginx.conf << 'EOF'
sever {
    listn 80;
    sever_name localhost;
    location / {
        root /var/www/html;
    }
}
EOF
