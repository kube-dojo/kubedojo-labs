#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
mkdir -p "$USER_HOME/.ssh"
if [ ! -f "$USER_HOME/.ssh/lab_key" ]; then
  ssh-keygen -t ed25519 -f "$USER_HOME/.ssh/lab_key" -N ''
else
  test -f "$USER_HOME/.ssh/lab_key.pub"
fi
