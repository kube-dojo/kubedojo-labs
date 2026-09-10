#!/bin/bash
set -e
mkdir -p ~/.ssh && chmod 700 ~/.ssh
rm -f ~/.ssh/kd-lab-key ~/.ssh/kd-lab-key.pub
ssh-keygen -t ed25519 -N "" -C kd-lab -f ~/.ssh/kd-lab-key
cat ~/.ssh/kd-lab-key.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
