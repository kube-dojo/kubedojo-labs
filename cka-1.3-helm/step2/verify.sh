#!/bin/bash
if [ ! -f /root/nginx-chart.txt ]; then
  echo "FAIL: /root/nginx-chart.txt does not exist"
  exit 1
fi

if grep -q "bitnami/nginx" /root/nginx-chart.txt; then
  echo "PASS: File contains bitnami/nginx"
  exit 0
else
  echo "FAIL: File should contain 'bitnami/nginx'"
  exit 1
fi
