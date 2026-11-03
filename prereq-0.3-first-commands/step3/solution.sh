#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
grep stopped "$USER_HOME/documents/services.txt" > "$USER_HOME/projects/lab-results/stopped.txt"
