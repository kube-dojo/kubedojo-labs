#!/bin/bash
RELEASE=$(helm list -n helm-lab -o json 2>/dev/null | grep -o '"web-app"' | head -1)
if [ -z "$RELEASE" ]; then
  echo "FAIL: Helm release web-app not found in helm-lab"
  exit 1
fi
if [ ! -f /root/helm-releases.txt ]; then
  echo "FAIL: /root/helm-releases.txt not found"
  exit 1
fi
if ! grep -q "web-app" /root/helm-releases.txt; then
  echo "FAIL: helm-releases.txt should contain web-app"
  exit 1
fi
echo "PASS"
exit 0
