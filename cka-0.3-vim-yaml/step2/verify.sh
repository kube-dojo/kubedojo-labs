#!/bin/bash
if python3 -c "import yaml; yaml.safe_load(open('/root/broken.yaml'))" 2>/dev/null; then
  echo "PASS: /root/broken.yaml is valid YAML"
  exit 0
else
  echo "FAIL: /root/broken.yaml is not valid YAML"
  exit 1
fi
