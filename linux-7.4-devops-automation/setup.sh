#!/bin/bash
# Setup for DevOps automation lab
apt-get update -qq
apt-get install -y -qq jq curl gettext-base python3 > /dev/null 2>&1

# Config template in each learner home
_TMPL=$(mktemp)
cat > "$_TMPL" << 'EOFINNER'
server:
  host: ${APP_HOST}
  port: ${APP_PORT}
  environment: ${APP_ENV}

database:
  host: ${DB_HOST}
  port: ${DB_PORT}
  name: ${DB_NAME}

logging:
  level: ${LOG_LEVEL}
EOFINNER
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  cp "$_TMPL" "$home/app.conf.template"
done
rm -f "$_TMPL"

# Shared HTTP server (not under a single learner home)
mkdir -p /opt/api-server
cat > /opt/api-server/api.py << 'PYEOF'
import http.server
import json

class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        data = {
            "status": "healthy",
            "version": "1.2.3",
            "services": {
                "database": "connected",
                "cache": "connected",
                "queue": "degraded"
            },
            "uptime_seconds": 86400
        }
        self.wfile.write(json.dumps(data).encode())

    def log_message(self, format, *args):
        pass

if __name__ == '__main__':
    server = http.server.HTTPServer(('localhost', 8080), Handler)
    server.serve_forever()
PYEOF

# Start the API server in background
python3 /opt/api-server/api.py &
echo $! > /opt/api-server/pid

echo "Setup complete. Template in each learner home; API server at localhost:8080"

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
