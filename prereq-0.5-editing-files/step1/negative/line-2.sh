#!/bin/bash
# Leave only requirement line-2 unmet after replaying the earlier steps.
set -e
cat << 'EOF' > ~/configs/app.env
APP_NAME=kubedojo
APP_PORT=8080-wrong
DB_HOST=localhost
DB_PORT=5432
EOF
