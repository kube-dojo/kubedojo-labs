#!/bin/bash
# Verify app.env has 6 lines and contains LOG_LEVEL and DEBUG
[ -f /home/user/configs/app.env ] || exit 1
grep -q "LOG_LEVEL=info" /home/user/configs/app.env || exit 1
grep -q "DEBUG=false" /home/user/configs/app.env || exit 1
# Ensure original content is still there (not overwritten)
grep -q "APP_NAME=kubedojo" /home/user/configs/app.env || exit 1
[ "$(wc -l < /home/user/configs/app.env)" -ge 6 ] || exit 1
exit 0
