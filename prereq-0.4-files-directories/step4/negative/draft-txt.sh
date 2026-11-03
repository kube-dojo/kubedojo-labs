#!/bin/bash
# Leave only requirement draft-txt unmet after replaying the earlier steps.
set -e
cp ~/lab-workspace/docs/archive/*.txt ~/lab-workspace/backup/
echo wrong > ~/lab-workspace/backup/report.txt
