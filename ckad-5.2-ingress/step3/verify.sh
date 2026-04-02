#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
kubectl get ingress host-ingress -n ingress-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: Ingress host-ingress not found"
  exit 1
fi
HOSTS=$(kubectl get ingress host-ingress -n ingress-lab -o jsonpath='{.spec.rules[*].host}' 2>/dev/null)
if [[ "$HOSTS" != *"frontend.example.com"* ]] || [[ "$HOSTS" != *"backend.example.com"* ]]; then
  echo "FAIL: Should have frontend.example.com and backend.example.com hosts"
  exit 1
fi
if [ ! -f $USER_HOME/ingress-hosts.txt ]; then
  echo "FAIL: $USER_HOME/ingress-hosts.txt not found"
  exit 1
fi
echo "PASS"
exit 0
