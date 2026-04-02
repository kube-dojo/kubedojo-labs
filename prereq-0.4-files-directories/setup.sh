#!/bin/bash
for user_home in /root /home/ubuntu; do
  if [ -d "$user_home" ]; then
    BASE="$user_home/lab-workspace"
    mkdir -p "$BASE/docs/drafts" "$BASE/docs/archive" "$BASE/backup" "$BASE/to_delete_dir"
    echo "Quarterly sales increased by 12%." > "$BASE/docs/drafts/report.txt"
    echo "Remember to review the PR before Friday." > "$BASE/docs/drafts/notes.txt"
    echo "DEBUG: temp log entry" > "$BASE/docs/drafts/tmp_file.log"
    echo "id,name,value" > "$BASE/docs/archive/old_data.csv"
    echo "This file will be deleted." > "$BASE/to_delete_dir/file1.txt"
    echo "db_password=supersecret" > "$BASE/secret_config.cfg"
    chmod 000 "$BASE/secret_config.cfg"
    printf "#!/bin/bash\necho \"Running important script\"\n" > "$BASE/important_script.sh"
    chmod 644 "$BASE/important_script.sh"
    if [ "$user_home" == "/home/ubuntu" ]; then
      chown -R ubuntu:ubuntu "$BASE" 2>/dev/null || true
    fi
  fi
done
