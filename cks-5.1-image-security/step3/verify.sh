#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in image-sizes.txt minimal-Dockerfile image-hardening.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
if ! grep -qi "FROM" $USER_HOME/minimal-Dockerfile; then
  echo "FAIL: minimal-Dockerfile should contain FROM instruction"
  exit 1
fi
LINES=$(wc -l < $USER_HOME/image-hardening.txt | tr -d ' ')
if [ "$LINES" -lt 5 ]; then
  echo "FAIL: Expected at least 5 image hardening practices"
  exit 1
fi
echo "PASS"
exit 0
