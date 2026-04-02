#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if tmux list-sessions 2>/dev/null | grep -q "exam"; then
  echo "PASS: tmux session 'exam' exists"
  exit 0
else
  echo "FAIL: No tmux session named 'exam' found"
  exit 1
fi
