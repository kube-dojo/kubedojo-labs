#!/bin/bash
if [ ! -f /root/.vimrc ]; then
  echo "FAIL: /root/.vimrc does not exist"
  exit 1
fi

if grep -q "expandtab" /root/.vimrc && \
   grep -q "tabstop=2" /root/.vimrc && \
   grep -q "shiftwidth=2" /root/.vimrc && \
   grep -q "autoindent" /root/.vimrc; then
  echo "PASS: .vimrc contains YAML-friendly settings"
  exit 0
else
  echo "FAIL: .vimrc should contain expandtab, tabstop=2, shiftwidth=2, and autoindent"
  exit 1
fi
