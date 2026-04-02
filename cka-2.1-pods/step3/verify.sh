#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
POD_JSON=$(kubectl get pod resource-pod -n practice -o json 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "FAIL: Pod resource-pod not found"
  exit 1
fi

CPU_REQ=$(echo "$POD_JSON" | jq -r '.spec.containers[0].resources.requests.cpu')
MEM_REQ=$(echo "$POD_JSON" | jq -r '.spec.containers[0].resources.requests.memory')
CPU_LIM=$(echo "$POD_JSON" | jq -r '.spec.containers[0].resources.limits.cpu')
MEM_LIM=$(echo "$POD_JSON" | jq -r '.spec.containers[0].resources.limits.memory')

if [ "$CPU_REQ" = "100m" ] && [ "$MEM_REQ" = "64Mi" ] && [ "$CPU_LIM" = "200m" ] && [ "$MEM_LIM" = "128Mi" ]; then
  echo "PASS: Pod has correct resource requests and limits"
  exit 0
else
  echo "FAIL: Resource values are incorrect. Expected 100m/64Mi/200m/128Mi."
  echo "Found: $CPU_REQ / $MEM_REQ / $CPU_LIM / $MEM_LIM"
  exit 1
fi