#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get networkpolicy -n investigation &>/dev/null; then
  NP_COUNT=0
else
  NP_COUNT=$(kubectl get networkpolicy -n investigation --no-headers 2>/dev/null | wc -l)
fi
if [ "$NP_COUNT" -lt 1 ]; then
  echo "FAIL: No NetworkPolicy found in investigation namespace"
  exit 1
fi
if kubectl get pod suspicious-pod -n investigation &>/dev/null; then
  echo "FAIL: suspicious-pod should be deleted"
  exit 1
fi
for f in remediated-deployment.yaml incident-report.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
