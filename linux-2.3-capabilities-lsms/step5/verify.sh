#!/bin/bash
# Verify: seccomp filter really blocked the syscall while the control succeeded.
MODE=/tmp/kd-caps/seccomp-mode.txt
BLOCKED=/tmp/kd-caps/seccomp-blocked.txt
if [ ! -s "$MODE" ] || [ ! -s "$BLOCKED" ]; then
  echo "FAIL: evidence files missing — record seccomp-mode.txt and seccomp-blocked.txt"
  exit 1
fi
if ! grep -Eq '^Seccomp:[[:space:]]+[0-2]$' "$MODE"; then
  echo "FAIL: seccomp-mode.txt must record the 'Seccomp:' line from /proc/self/status"
  exit 1
fi
if [ ! -d /tmp/kd-caps/allowed-dir ]; then
  echo "FAIL: allowed-dir missing — run the unfiltered control unit; without it there is no proof the filter (not a typo) blocked the other run"
  exit 1
fi
if [ -d /tmp/kd-caps/blocked-dir ]; then
  echo "FAIL: blocked-dir EXISTS — the mkdir was not run under the seccomp filter"
  exit 1
fi
if ! grep -Eq '^exit=[1-9][0-9]*$' "$BLOCKED"; then
  echo "FAIL: seccomp-blocked.txt must record a nonzero exit (exit=<n>) from the filtered run"
  exit 1
fi
echo "PASS: seccomp enforcement proven — filtered mkdir blocked, unfiltered control succeeded"
exit 0
