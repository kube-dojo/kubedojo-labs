#!/bin/bash
# Leave only requirement key-pair unmet after replaying the earlier steps.
set -e
mkdir -p ~/.ssh
ssh-keygen -q -t ed25519 -f ~/.ssh/lab_key -N ''
ssh-keygen -q -t ed25519 -f /tmp/other-key -N ''
cp /tmp/other-key.pub ~/.ssh/lab_key.pub
