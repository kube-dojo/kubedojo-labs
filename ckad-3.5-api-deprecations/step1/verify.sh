#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/api-versions.txt ]; then
  echo "FAIL: $USER_HOME/api-versions.txt not found"
  exit 1
fi
if ! grep -q "apps/v1" $USER_HOME/api-versions.txt; then
  echo "FAIL: api-versions.txt should contain apps/v1"
  exit 1
fi
if [ ! -f $USER_HOME/api-resources.txt ]; then
  echo "FAIL: $USER_HOME/api-resources.txt not found"
  exit 1
fi
if [ ! -f $USER_HOME/deployment-api.txt ]; then
  echo "FAIL: $USER_HOME/deployment-api.txt not found"
  exit 1
fi
echo "PASS"
exit 0
