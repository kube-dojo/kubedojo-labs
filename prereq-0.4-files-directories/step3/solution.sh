#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
chmod u+x "$USER_HOME/lab-workspace/important_script.sh"
chmod 600 "$USER_HOME/lab-workspace/secret_config.cfg"
