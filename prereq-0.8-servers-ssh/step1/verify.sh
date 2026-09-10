#!/bin/bash
# Verify: local context evidence matches the live system.
F=/tmp/kd-ssh/local-context.txt
if [ ! -s "$F" ]; then
  echo "FAIL: $F missing or empty — record hostname, whoami, pwd (one line each)"
  exit 1
fi
if [ "$(wc -l < "$F")" -ne 3 ]; then
  echo "FAIL: $F must contain exactly 3 lines: hostname, whoami, pwd"
  exit 1
fi
if [ "$(sed -n 1p "$F")" != "$(hostname)" ]; then
  echo "FAIL: line 1 does not match the live hostname ($(hostname))"
  exit 1
fi
if [ "$(sed -n 2p "$F")" != "$USER" ]; then
  echo "FAIL: line 2 does not match your account ($USER)"
  exit 1
fi
dir=$(sed -n 3p "$F")
if [ "${dir#/}" = "$dir" ] || [ ! -d "$dir" ]; then
  echo "FAIL: line 3 must be the absolute path of an existing directory (pwd output)"
  exit 1
fi
echo "PASS: local context recorded — machine, account, and directory match the live system"
exit 0
