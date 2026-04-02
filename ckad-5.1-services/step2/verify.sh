#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
TYPE=$(kubectl get svc web-nodeport -n svc-lab -o jsonpath='{.spec.type}' 2>/dev/null)
if [ "$TYPE" != "NodePort" ]; then
  echo "FAIL: web-nodeport should be NodePort type"
  exit 1
fi
if [ ! -f $USER_HOME/node-port.txt ]; then
  echo "FAIL: $USER_HOME/node-port.txt not found"
  exit 1
fi
NP=$(cat $USER_HOME/node-port.txt | tr -d '[:space:]')
if [ "$NP" -lt 30000 ] || [ "$NP" -gt 32767 ]; then
  echo "FAIL: NodePort should be in range 30000-32767"
  exit 1
fi
echo "PASS"
exit 0
