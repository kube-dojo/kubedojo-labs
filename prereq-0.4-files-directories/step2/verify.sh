#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
BASE="$USER_HOME/lab-workspace"

if [ ! -e "$BASE/docs/drafts/tmp_file.log" ] && [ ! -L "$BASE/docs/drafts/tmp_file.log" ] && [ ! -e "$BASE/to_delete_dir" ] && [ ! -L "$BASE/to_delete_dir" ]; then
  echo "PASS: Deletion verified!"
  exit 0
else
  echo "FAIL: Files/directories still exist."
  exit 1
fi
