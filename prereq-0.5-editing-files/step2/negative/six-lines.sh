#!/bin/bash
# Leave only requirement six-lines unmet after replaying the earlier steps.
set -e
cat << 'EOF' > ~/configs/app.env
APP_NAME=kubedojo
APP_PORT=8080
DB_HOST=localhost
DB_PORT=5432
LOG_LEVEL=info
DEBUG=false
EXTRA=true
EOF
