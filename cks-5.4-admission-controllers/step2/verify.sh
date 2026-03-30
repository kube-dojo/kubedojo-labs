#!/bin/bash
for f in /etc/kubernetes/admission/image-policy.yaml /etc/kubernetes/admission/image-policy-kubeconfig.yaml; do
  if [ ! -f "$f" ] || [ ! -s "$f" ]; then
    echo "FAIL: $f missing or empty"
    exit 1
  fi
done
if ! grep -q "defaultAllow" /etc/kubernetes/admission/image-policy.yaml; then
  echo "FAIL: image-policy.yaml should contain defaultAllow"
  exit 1
fi
if [ ! -f /root/image-policy-notes.txt ] || [ ! -s /root/image-policy-notes.txt ]; then
  echo "FAIL: /root/image-policy-notes.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
