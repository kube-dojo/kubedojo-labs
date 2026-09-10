#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
TARGET_USER="${USER:-$(id -un)}"
if [ "$(id -un)" = "$TARGET_USER" ]; then
  SESSIONS=$(tmux list-sessions 2>/dev/null)
else
  SESSIONS=$(su -s /bin/bash - "$TARGET_USER" -c 'tmux list-sessions' 2>/dev/null)
fi
if echo "$SESSIONS" | grep -q "exam"; then
  echo "PASS: tmux session 'exam' exists"
  exit 0
else
  echo "FAIL: No tmux session named 'exam' found"
  exit 1
fi
