#!/bin/bash
if [ ! -f /root/k8s-version.txt ] || [ ! -s /root/k8s-version.txt ]; then
  echo "FAIL: /root/k8s-version.txt missing or empty"
  exit 1
fi
if [ ! -f /root/namespaces.txt ] || [ ! -s /root/namespaces.txt ]; then
  echo "FAIL: /root/namespaces.txt missing or empty"
  exit 1
fi
if [ ! -f /root/admission-plugins.txt ] || [ ! -s /root/admission-plugins.txt ]; then
  echo "FAIL: /root/admission-plugins.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
