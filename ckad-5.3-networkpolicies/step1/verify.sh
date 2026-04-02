#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
kubectl get networkpolicy default-deny-ingress -n netpol-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: NetworkPolicy default-deny-ingress not found"
  exit 1
fi
SELECTOR=$(kubectl get networkpolicy default-deny-ingress -n netpol-lab -o jsonpath='{.spec.podSelector}' 2>/dev/null)
if [ "$SELECTOR" != "{}" ]; then
  echo "FAIL: podSelector should be empty (match all)"
  exit 1
fi
TYPES=$(kubectl get networkpolicy default-deny-ingress -n netpol-lab -o jsonpath='{.spec.policyTypes[0]}' 2>/dev/null)
if [ "$TYPES" != "Ingress" ]; then
  echo "FAIL: policyTypes should include Ingress"
  exit 1
fi
if [ ! -f $USER_HOME/deny-policy.txt ]; then
  echo "FAIL: $USER_HOME/deny-policy.txt not found"
  exit 1
fi
echo "PASS"
exit 0
