#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
POD=$(kubectl get pod sidecar-pod -n practice -o json 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "FAIL: Pod sidecar-pod not found"
  exit 1
fi

COUNT=$(echo "$POD" | jq '.spec.containers | length')
if [ "$COUNT" -ne 2 ]; then
  echo "FAIL: Expected 2 containers, found $COUNT"
  exit 1
fi

# Check for volume sharing
V1=$(echo "$POD" | jq -r '.spec.containers[0].volumeMounts[0].name')
V2=$(echo "$POD" | jq -r '.spec.containers[1].volumeMounts[0].name')

if [ "$V1" = "$V2" ] && [ "$V1" != "null" ]; then
  echo "PASS: Multi-container pod with shared volume verified"
  exit 0
else
  echo "FAIL: Containers do not appear to share a volume"
  exit 1
fi