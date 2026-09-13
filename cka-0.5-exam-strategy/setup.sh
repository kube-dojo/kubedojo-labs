#!/bin/bash
# Create mock exam tasks file for step 2 (each learner home).
_TASKS=$(mktemp)
cat > "$_TASKS" << 'EOFINNER'
Task A: Create a NetworkPolicy (7 points, ~10 min)
Task B: Create a Pod with specific labels (4 points, ~2 min)
Task C: Upgrade a cluster (13 points, ~20 min)
Task D: Create a ClusterRole and bind it (5 points, ~4 min)
Task E: Troubleshoot a broken deployment (8 points, ~8 min)
EOFINNER
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  cp "$_TASKS" "$home/exam-tasks.txt"
done
rm -f "$_TASKS"

echo "Environment ready!"

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
