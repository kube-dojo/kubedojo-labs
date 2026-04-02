#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get ingress secure-ingress -n ingress-lab &>/dev/null; then
  echo "FAIL: Ingress secure-ingress not found"
  exit 1
fi
TLS_SECRET=$(kubectl get ingress secure-ingress -n ingress-lab -o jsonpath='{.spec.tls[0].secretName}')
if [ "$TLS_SECRET" != "tls-secret" ]; then
  echo "FAIL: Ingress TLS should reference tls-secret"
  exit 1
fi
if [ ! -f $USER_HOME/secure-ingress.yaml ] || [ ! -s $USER_HOME/secure-ingress.yaml ]; then
  echo "FAIL: $USER_HOME/secure-ingress.yaml missing or empty"
  exit 1
fi
echo "PASS"
exit 0
