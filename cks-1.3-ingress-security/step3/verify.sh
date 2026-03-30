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
if [ ! -f /root/secure-ingress-final.yaml ] || [ ! -s /root/secure-ingress-final.yaml ]; then
  echo "FAIL: /root/secure-ingress-final.yaml missing or empty"
  exit 1
fi
echo "PASS"
exit 0
