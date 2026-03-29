#!/bin/bash
# Verify /home/user/configs/app.env exists with all 4 lines
[ -f /home/user/configs/app.env ] || exit 1
grep -q "APP_NAME=kubedojo" /home/user/configs/app.env || exit 1
grep -q "APP_PORT=8080" /home/user/configs/app.env || exit 1
grep -q "DB_HOST=localhost" /home/user/configs/app.env || exit 1
grep -q "DB_PORT=5432" /home/user/configs/app.env || exit 1
[ "$(wc -l < /home/user/configs/app.env)" -ge 4 ] || exit 1
exit 0
