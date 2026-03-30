#!/bin/bash
if [ ! -f /root/strace-output.txt ]; then
  echo "FAIL: /root/strace-output.txt not found"
  exit 1
fi

if grep -qE '(open|read|write|execve|stat|mmap)' /root/strace-output.txt; then
  echo "PASS: strace output contains system calls"
  exit 0
else
  echo "FAIL: strace output does not contain expected syscalls"
  exit 1
fi
