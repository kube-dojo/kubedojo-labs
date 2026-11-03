#!/bin/bash
# Leave only requirement ed25519 unmet after replaying the earlier steps.
set -e
mkdir -p ~/.ssh
ssh-keygen -q -t rsa -f ~/.ssh/lab_key -N ''
