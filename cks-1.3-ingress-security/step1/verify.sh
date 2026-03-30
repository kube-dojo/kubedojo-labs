#!/bin/bash
if [ ! -f /root/tls.crt ] || [ ! -f /root/tls.key ]; then
  echo "FAIL: TLS certificate files not found"
  exit 1
fi
if ! kubectl get secret tls-secret -n ingress-lab &>/dev/null; then
  echo "FAIL: tls-secret not found in ingress-lab"
  exit 1
fi
TYPE=$(kubectl get secret tls-secret -n ingress-lab -o jsonpath='{.type}')
if [ "$TYPE" != "kubernetes.io/tls" ]; then
  echo "FAIL: Secret type should be kubernetes.io/tls, got $TYPE"
  exit 1
fi
if [ ! -f /root/secret-type.txt ] || [ ! -s /root/secret-type.txt ]; then
  echo "FAIL: /root/secret-type.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
