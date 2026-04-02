#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get networkpolicy allow-frontend-to-api -n backend &>/dev/null; then
  echo "FAIL: NetworkPolicy allow-frontend-to-api not found"
  exit 1
fi
SELECTOR=$(kubectl get networkpolicy allow-frontend-to-api -n backend -o jsonpath='{.spec.podSelector.matchLabels.app}')
if [ "$SELECTOR" != "api" ]; then
  echo "FAIL: Policy should select app=api pods"
  exit 1
fi
if [ ! -f $USER_HOME/netpol-test-2.txt ] || [ ! -s $USER_HOME/netpol-test-2.txt ]; then
  echo "FAIL: $USER_HOME/netpol-test-2.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
