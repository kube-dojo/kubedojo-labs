#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
kubectl get ingress basic-ingress -n ingress-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: Ingress basic-ingress not found"
  exit 1
fi
CLASS=$(kubectl get ingress basic-ingress -n ingress-lab -o jsonpath='{.spec.ingressClassName}' 2>/dev/null)
if [ "$CLASS" != "nginx" ]; then
  echo "FAIL: ingressClassName should be nginx"
  exit 1
fi
if [ ! -f $USER_HOME/ingress-class.txt ]; then
  echo "FAIL: $USER_HOME/ingress-class.txt not found"
  exit 1
fi
echo "PASS"
exit 0
