#!/bin/bash
set -e
ssh -p 2222 -i ~/.ssh/kd-lab-key "$(whoami)@localhost" \
  'echo "Hello from SSH!" > /tmp/kd-ssh/hello.txt; exit'
hostname > /tmp/kd-ssh/after-exit.txt
