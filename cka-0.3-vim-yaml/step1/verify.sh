#!/bin/bash
FILE="/root/practice.yaml"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

python3 -c "
import yaml, sys
try:
    with open('$FILE', 'r') as f:
        data = yaml.safe_load(f)
    if data['apiVersion'] != 'v1': sys.exit(1)
    if data['kind'] != 'Pod': sys.exit(1)
    if data['metadata']['name'] != 'test': sys.exit(1)
except Exception:
    sys.exit(1)
"
if [ $? -eq 0 ]; then
  echo "PASS: practice.yaml is a valid YAML Pod"
  exit 0
else
  echo "FAIL: practice.yaml must be valid YAML and contain apiVersion: v1, kind: Pod, and metadata.name: test"
  exit 1
fi