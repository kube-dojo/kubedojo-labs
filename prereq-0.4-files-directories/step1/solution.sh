#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
cd "$USER_HOME/lab-workspace"
cp docs/drafts/report.txt backup/
if [ -f docs/drafts/notes.txt ]; then mv docs/drafts/notes.txt docs/archive/; else test -f docs/archive/notes.txt; fi
if [ -f docs/archive/old_data.csv ]; then mv docs/archive/old_data.csv docs/archive/historical_data.csv; else test -f docs/archive/historical_data.csv; fi
