#!/bin/bash
# Leave only requirement stopped-list unmet after replaying the earlier steps.
set -e
grep stopped ~/documents/services.txt > ~/projects/lab-results/stopped.txt
grep redis ~/documents/services.txt >> ~/projects/lab-results/stopped.txt
