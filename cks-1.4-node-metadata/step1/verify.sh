#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in metadata-endpoints.txt metadata-test-before.txt pod-node.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
if ! grep -q "169.254.169.254" $USER_HOME/metadata-endpoints.txt; then
  echo "FAIL: metadata-endpoints.txt should contain 169.254.169.254"
  exit 1
fi
echo "PASS"
exit 0
