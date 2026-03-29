#!/bin/bash
# Setup lab workspace for Files and Directories lab
mkdir -p /home/user/lab-workspace/docs/drafts
mkdir -p /home/user/lab-workspace/docs/archive
mkdir -p /home/user/lab-workspace/backup
mkdir -p /home/user/lab-workspace/to_delete_dir

echo "Quarterly sales increased by 12%." > /home/user/lab-workspace/docs/drafts/report.txt
echo "Remember to review the PR before Friday." > /home/user/lab-workspace/docs/drafts/notes.txt
echo "DEBUG: temp log entry" > /home/user/lab-workspace/docs/drafts/tmp_file.log
echo "id,name,value" > /home/user/lab-workspace/docs/archive/old_data.csv
echo "This file will be deleted." > /home/user/lab-workspace/to_delete_dir/file1.txt

echo "db_password=supersecret" > /home/user/lab-workspace/secret_config.cfg
chmod 000 /home/user/lab-workspace/secret_config.cfg

echo '#!/bin/bash\necho "Running important script"' > /home/user/lab-workspace/important_script.sh
chmod 644 /home/user/lab-workspace/important_script.sh
