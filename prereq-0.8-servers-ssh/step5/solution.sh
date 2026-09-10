#!/bin/bash
set -e
echo 'ssh -p 2222 -i ~/.ssh/work_key admin@10.0.0.5' > /tmp/kd-ssh/constructed-command.txt
cat /tmp/kd-ssh/constructed-command.txt
