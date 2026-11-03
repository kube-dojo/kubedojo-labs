#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
rm -f "$USER_HOME/lab-workspace/docs/drafts/tmp_file.log"
rm -rf "$USER_HOME/lab-workspace/to_delete_dir"
