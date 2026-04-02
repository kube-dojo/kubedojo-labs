#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/broken.yaml"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

python3 -c "
import yaml, sys
try:
    with open('$FILE', 'r') as f:
        data = yaml.safe_load(f)
    assert data['kind'] == 'Pod'
    assert data['metadata']['name'] == 'broken-pod'
    assert data['metadata']['labels']['app'] == 'test'
    assert data['spec']['containers'][0]['image'] == 'nginx:1.27'
    assert data['spec']['containers'][0]['ports'][0]['containerPort'] == 80
except Exception:
    sys.exit(1)
"
if [ $? -eq 0 ]; then
  echo "PASS: $USER_HOME/broken.yaml verified with all required fields"
  exit 0
else
  echo "FAIL: $USER_HOME/broken.yaml is invalid or missing required fields (labels, container port, etc.)"
  exit 1
fi