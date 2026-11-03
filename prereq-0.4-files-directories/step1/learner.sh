#!/bin/bash
# text.md:7-15
# expect-exit: 0
cd ~/lab-workspace
# expect-exit: 0
find . -type f
# expect-exit: 0
cp docs/drafts/report.txt backup/
# expect-exit: 0
mv docs/drafts/notes.txt docs/archive/
# expect-exit: 0
mv docs/archive/old_data.csv docs/archive/historical_data.csv
