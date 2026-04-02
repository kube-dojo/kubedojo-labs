#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/migrated-manifest.yaml ]; then
  echo "FAIL: $USER_HOME/migrated-manifest.yaml not found"
  exit 1
fi
if ! grep -q "apps/v1" $USER_HOME/migrated-manifest.yaml; then
  echo "FAIL: migrated-manifest.yaml should use apps/v1"
  exit 1
fi
if [ ! -f $USER_HOME/final-api-version.txt ]; then
  echo "FAIL: $USER_HOME/final-api-version.txt not found"
  exit 1
fi
VER=$(cat $USER_HOME/final-api-version.txt | tr -d '[:space:]')
if [ "$VER" != "apps/v1" ]; then
  echo "FAIL: final-api-version.txt should contain apps/v1"
  exit 1
fi
echo "PASS"
exit 0
