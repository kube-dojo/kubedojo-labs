#!/bin/bash
# text.md:2
# expect-exit: 0
mkdir -p ~/.ssh
# expect-exit: 0
ssh-keygen -t ed25519 -f ~/.ssh/lab_key -N ""
