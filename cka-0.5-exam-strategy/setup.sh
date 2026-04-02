#!/bin/bash
# Create mock exam tasks file for step 2
cat > /root/exam-tasks.txt << 'EOF'
Task A: Create a NetworkPolicy (7 points, ~10 min)
Task B: Create a Pod with specific labels (4 points, ~2 min)
Task C: Upgrade a cluster (13 points, ~20 min)
Task D: Create a ClusterRole and bind it (5 points, ~4 min)
Task E: Troubleshoot a broken deployment (8 points, ~8 min)
EOF

echo "Environment ready!"

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
