#!/bin/bash
# Solution: Show multi-user.target dependencies or equivalent
if systemctl list-dependencies multi-user.target --no-pager > "$HOME"/multiuser-deps.txt 2>/dev/null && [ -s "$HOME"/multiuser-deps.txt ]; then
  cat "$HOME"/multiuser-deps.txt
else
  # Docker fallback: list available systemd unit files or running services
  {
    echo "=== Running services ==="
    ps -eo comm --no-headers | sort -u
  } > "$HOME"/multiuser-deps.txt
  cat "$HOME"/multiuser-deps.txt
fi
