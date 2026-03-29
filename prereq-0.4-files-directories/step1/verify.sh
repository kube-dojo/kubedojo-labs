#!/bin/bash
# Verify: report.txt copied to backup, notes.txt moved to archive, old_data.csv renamed
[ -f /home/user/lab-workspace/backup/report.txt ] && \
[ -f /home/user/lab-workspace/docs/archive/notes.txt ] && \
[ -f /home/user/lab-workspace/docs/archive/historical_data.csv ] && \
[ ! -f /home/user/lab-workspace/docs/archive/old_data.csv ] && \
exit 0 || exit 1
