#!/bin/bash
# Leave only requirement line-3 unmet after replaying the earlier steps.
set -e
cat << 'EOF' > ~/configs/app.env
APP_NAME=kubedojo
APP_PORT=8080
DB_HOST=localhost-wrong
DB_PORT=5432
EOF
