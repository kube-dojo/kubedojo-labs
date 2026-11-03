#!/bin/bash
# text.md:49-60. Choose the heredoc method for the required four-line file.
# expect-exit: 0
cat << 'EOF' > ~/configs/app.env
APP_NAME=kubedojo
APP_PORT=8080
DB_HOST=localhost
DB_PORT=5432
EOF
