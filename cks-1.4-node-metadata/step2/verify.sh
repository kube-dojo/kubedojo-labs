#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get networkpolicy block-metadata -n metadata-lab &>/dev/null; then
  echo "FAIL: NetworkPolicy block-metadata not found"
  exit 1
fi
YAML=$(kubectl get networkpolicy block-metadata -n metadata-lab -o yaml)
if ! echo "$YAML" | grep -q "169.254.169.254"; then
  echo "FAIL: Policy should reference metadata IP 169.254.169.254"
  exit 1
fi
if [ ! -f $USER_HOME/block-metadata.yaml ] || [ ! -s $USER_HOME/block-metadata.yaml ]; then
  echo "FAIL: $USER_HOME/block-metadata.yaml missing or empty"
  exit 1
fi
echo "PASS"
exit 0
