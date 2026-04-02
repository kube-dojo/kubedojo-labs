#!/bin/bash
# Detect primary user
if id "ubuntu" &>/dev/null; then
  TARGET_USER="ubuntu"
  USER_HOME="/home/ubuntu"
else
  TARGET_USER="root"
  USER_HOME="/root"
fi

BASE="$USER_HOME/lab-workspace"
mkdir -p "$BASE/docs/drafts"
mkdir -p "$BASE/docs/archive"
mkdir -p "$BASE/backup"
mkdir -p "$BASE/to_delete_dir"

echo "Quarterly sales increased by 12%." > "$BASE/docs/drafts/report.txt"
echo "Remember to review the PR before Friday." > "$BASE/docs/drafts/notes.txt"
echo "DEBUG: temp log entry" > "$BASE/docs/drafts/tmp_file.log"
echo "id,name,value" > "$BASE/docs/archive/old_data.csv"
echo "This file will be deleted." > "$BASE/to_delete_dir/file1.txt"

echo "db_password=supersecret" > "$BASE/secret_config.cfg"
chmod 000 "$BASE/secret_config.cfg"

printf "#!/bin/bash\necho \"Running important script\"\n" > "$BASE/important_script.sh"
chmod 644 "$BASE/important_script.sh"

chown -R $TARGET_USER:$TARGET_USER "$BASE" 2>/dev/null || true
# Ensure the secret file is still 000
chmod 000 "$BASE/secret_config.cfg"
