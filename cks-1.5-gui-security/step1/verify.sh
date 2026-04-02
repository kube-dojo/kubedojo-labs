#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get sa dashboard-admin -n kubernetes-dashboard &>/dev/null; then
  echo "FAIL: ServiceAccount dashboard-admin not found"
  exit 1
fi
if ! kubectl get sa dashboard-readonly -n kubernetes-dashboard &>/dev/null; then
  echo "FAIL: ServiceAccount dashboard-readonly not found"
  exit 1
fi
if ! kubectl get clusterrolebinding dashboard-admin-binding &>/dev/null; then
  echo "FAIL: ClusterRoleBinding dashboard-admin-binding not found"
  exit 1
fi
if [ ! -f $USER_HOME/dashboard-risk.txt ]; then
  echo "FAIL: $USER_HOME/dashboard-risk.txt not found"
  exit 1
fi
LINES=$(wc -l < $USER_HOME/dashboard-risk.txt | tr -d ' ')
if [ "$LINES" -lt 3 ]; then
  echo "FAIL: Expected at least 3 risks"
  exit 1
fi
echo "PASS"
exit 0
