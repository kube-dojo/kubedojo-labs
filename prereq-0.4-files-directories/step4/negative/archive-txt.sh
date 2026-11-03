#!/bin/bash
# Leave only requirement archive-txt unmet after replaying the earlier steps.
set -e
cp ~/lab-workspace/docs/drafts/*.txt ~/lab-workspace/backup/
echo wrong > ~/lab-workspace/backup/notes.txt
