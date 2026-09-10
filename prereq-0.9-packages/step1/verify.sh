#!/bin/bash
# Verify: the package catalog has been refreshed (htop has a real candidate).
candidate=$(apt-cache policy htop 2>/dev/null | grep -i 'Candidate:' | awk '{print $2}')
if [ -z "$candidate" ] || [ "$candidate" = "(none)" ]; then
  echo "FAIL: apt has no candidate version for htop — the catalog is still stale. Run 'sudo apt update'."
  exit 1
fi
echo "PASS: package catalog refreshed (htop candidate: $candidate)"
exit 0
