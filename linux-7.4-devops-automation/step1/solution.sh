#!/bin/bash
# Solution: Create deploy-config.sh
cat > "$HOME"/deploy-config.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

export APP_HOST=0.0.0.0
export APP_PORT=8080
export APP_ENV=production
export DB_HOST=db.example.com
export DB_PORT=5432
export DB_NAME=myapp_prod
export LOG_LEVEL=warn

envsubst < "$HOME"/app.conf.template > "$HOME"/app.conf
echo "Configuration deployed:"
cat "$HOME"/app.conf
SCRIPT
chmod +x "$HOME"/deploy-config.sh
"$HOME"/deploy-config.sh
