#!/bin/bash
# Check .vimrc
if [ ! -f /root/.vimrc ]; then
  echo "FAIL: /root/.vimrc does not exist"
  exit 1
fi
if ! grep -q "tabstop=2" /root/.vimrc; then
  echo "FAIL: /root/.vimrc missing tabstop=2"
  exit 1
fi
if ! grep -q "expandtab" /root/.vimrc; then
  echo "FAIL: /root/.vimrc missing expandtab"
  exit 1
fi

# Check KUBE_EDITOR in bashrc
if ! grep -q "KUBE_EDITOR" /root/.bashrc; then
  echo "FAIL: KUBE_EDITOR not set in /root/.bashrc"
  exit 1
fi

# Check current-context.txt
if [ ! -f /root/current-context.txt ]; then
  echo "FAIL: /root/current-context.txt does not exist"
  exit 1
fi
CTX=$(cat /root/current-context.txt | tr -d '[:space:]')
if [ -z "$CTX" ]; then
  echo "FAIL: /root/current-context.txt is empty"
  exit 1
fi

echo "PASS: Exam environment configured"
exit 0
