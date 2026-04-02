#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
ERRORS=0
for i in $(seq 1 5); do
  if ! id "testuser${i}" > /dev/null 2>&1; then
    echo "FAIL: testuser${i} does not exist"
    ERRORS=$((ERRORS + 1))
  fi
done

if [ "$ERRORS" -eq 0 ]; then
  echo "PASS: All 5 test users exist"
  exit 0
else
  echo "FAIL: $ERRORS users missing"
  exit 1
fi
