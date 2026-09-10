#!/bin/bash
set -e
ssh -o StrictHostKeyChecking=accept-new -p 2222 -i ~/.ssh/kd-lab-key "$(whoami)@localhost" \
  'hostname; whoami; pwd' > /tmp/kd-ssh/remote-context.txt
cat /tmp/kd-ssh/remote-context.txt
