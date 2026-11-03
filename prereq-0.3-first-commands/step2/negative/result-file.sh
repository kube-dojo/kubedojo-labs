#!/bin/bash
# Leave only requirement result-file unmet after replaying the earlier steps.
set -e
mkdir -p ~/projects/lab-results
echo "step 2 incomplete" > ~/projects/lab-results/step2.txt
