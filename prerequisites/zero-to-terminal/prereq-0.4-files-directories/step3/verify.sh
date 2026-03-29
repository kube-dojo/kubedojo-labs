#!/bin/bash
# Verify: secret_config.cfg is 600, important_script.sh has owner execute
PERMS_SECRET=$(stat -c '%a' /home/user/lab-workspace/secret_config.cfg 2>/dev/null)
PERMS_SCRIPT=$(stat -c '%a' /home/user/lab-workspace/important_script.sh 2>/dev/null)

[ "$PERMS_SECRET" = "600" ] && \
[ "$PERMS_SCRIPT" = "744" ] && \
exit 0 || exit 1
