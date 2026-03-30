#!/bin/bash
# Solution: Create deploy-config.sh
cat > /root/deploy-config.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

export APP_HOST=0.0.0.0
export APP_PORT=8080
export APP_ENV=production
export DB_HOST=db.example.com
export DB_PORT=5432
export DB_NAME=myapp_prod
export LOG_LEVEL=warn

envsubst < /root/app.conf.template > /root/app.conf
echo "Configuration deployed:"
cat /root/app.conf
SCRIPT
chmod +x /root/deploy-config.sh
/root/deploy-config.sh
