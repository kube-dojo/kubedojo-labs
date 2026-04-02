#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get networkpolicy deny-all-ingress -n backend &>/dev/null; then
  echo "FAIL: NetworkPolicy deny-all-ingress not found in backend"
  exit 1
fi
if ! kubectl get networkpolicy deny-all-egress -n backend &>/dev/null; then
  echo "FAIL: NetworkPolicy deny-all-egress not found in backend"
  exit 1
fi
TYPES=$(kubectl get networkpolicy deny-all-ingress -n backend -o jsonpath='{.spec.policyTypes[*]}')
if [[ "$TYPES" != *"Ingress"* ]]; then
  echo "FAIL: deny-all-ingress must have Ingress policyType"
  exit 1
fi
if [ ! -f $USER_HOME/netpol-test-1.txt ]; then
  echo "FAIL: $USER_HOME/netpol-test-1.txt not found"
  exit 1
fi
echo "PASS"
exit 0
