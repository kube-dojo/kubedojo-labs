#!/bin/bash
# Leave only requirement notes-move unmet after replaying the earlier steps.
set -e
cp ~/lab-workspace/docs/drafts/report.txt ~/lab-workspace/backup/
cp ~/lab-workspace/docs/drafts/notes.txt ~/lab-workspace/docs/archive/
mv ~/lab-workspace/docs/archive/old_data.csv ~/lab-workspace/docs/archive/historical_data.csv
