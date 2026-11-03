#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
mkdir -p "$USER_HOME/projects/lab-results"
echo 'step 2 complete' > "$USER_HOME/projects/lab-results/step2.txt"
