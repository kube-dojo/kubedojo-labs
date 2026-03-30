#!/bin/bash
if [ ! -f /root/practice.yaml ]; then
  echo "FAIL: /root/practice.yaml does not exist"
  exit 1
fi

if grep -q "apiVersion: v1" /root/practice.yaml && \
   grep -q "kind: Pod" /root/practice.yaml && \
   grep -q "name: test" /root/practice.yaml; then
  echo "PASS: practice.yaml contains all required fields"
  exit 0
else
  echo "FAIL: practice.yaml must contain apiVersion: v1, kind: Pod, and metadata.name: test"
  exit 1
fi
