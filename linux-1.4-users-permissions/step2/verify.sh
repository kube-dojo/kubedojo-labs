#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify developer account is locked
status=$(passwd -S developer 2>/dev/null)
if echo "$status" | grep -qE "\s(L|LK)\s"; then
  echo "Account is locked: $status"
  exit 0
else
  echo "Account should be locked. Current status: $status"
  exit 1
fi
