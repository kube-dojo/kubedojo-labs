#!/bin/bash
# Leave only requirement line-1 unmet after replaying the earlier steps.
set -e
cat << 'EOF' > ~/configs/app.env
APP_NAME=kubedojo-wrong
APP_PORT=8080
DB_HOST=localhost
DB_PORT=5432
EOF
