#!/bin/bash
# Leave only requirement no-passphrase unmet after replaying the earlier steps.
set -e
mkdir -p ~/.ssh
ssh-keygen -q -t ed25519 -f ~/.ssh/lab_key -N 'fixture-passphrase'
