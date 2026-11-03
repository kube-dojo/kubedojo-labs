#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
cp "$USER_HOME"/lab-workspace/docs/archive/*.txt "$USER_HOME/lab-workspace/backup/"
cp "$USER_HOME"/lab-workspace/docs/drafts/*.txt "$USER_HOME/lab-workspace/backup/"
