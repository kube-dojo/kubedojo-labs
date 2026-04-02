#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
SSL=$(kubectl get ingress secure-ingress -n ingress-lab -o jsonpath='{.metadata.annotations.nginx\.ingress\.kubernetes\.io/ssl-redirect}')
if [ "$SSL" != "true" ]; then
  echo "FAIL: ssl-redirect annotation not set to true"
  exit 1
fi
FORCE=$(kubectl get ingress secure-ingress -n ingress-lab -o jsonpath='{.metadata.annotations.nginx\.ingress\.kubernetes\.io/force-ssl-redirect}')
if [ "$FORCE" != "true" ]; then
  echo "FAIL: force-ssl-redirect annotation not set to true"
  exit 1
fi
if [ ! -f $USER_HOME/secure-ingress-final.yaml ] || [ ! -s $USER_HOME/secure-ingress-final.yaml ]; then
  echo "FAIL: $USER_HOME/secure-ingress-final.yaml missing or empty"
  exit 1
fi
echo "PASS"
exit 0
