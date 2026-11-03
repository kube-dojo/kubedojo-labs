#!/bin/bash
# Leave only requirement preserved-lines unmet after replaying the earlier steps.
set -e
cat << 'EOF' > ~/configs/app.env
APP_NAME=wrong
APP_PORT=8080
DB_HOST=localhost
DB_PORT=5432
LOG_LEVEL=info
DEBUG=false
EOF
