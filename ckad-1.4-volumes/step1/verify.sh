#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod temp-storage -n volumes-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ "$S" != "Running" ]; then
  echo "FAIL: temp-storage not Running"
  exit 1
fi

CONTENT=$(kubectl exec temp-storage -n volumes-lab -- cat /cache/greeting.txt 2>/dev/null)
if [[ "$CONTENT" != *"hello"* ]]; then
  echo "FAIL: /cache/greeting.txt should contain 'hello'"
  exit 1
fi

kubectl get pod host-storage -n volumes-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: host-storage pod not found"
  exit 1
fi

VOL_TYPE=$(kubectl get pod host-storage -n volumes-lab -o jsonpath='{.spec.volumes[0].hostPath.path}' 2>/dev/null)
if [ "$VOL_TYPE" != "/data/hostpath-demo" ]; then
  echo "FAIL: hostPath should point to /data/hostpath-demo"
  exit 1
fi

if [ ! -f /data/hostpath-demo/test.txt ]; then
  echo "FAIL: /data/hostpath-demo/test.txt not found on node"
  exit 1
fi

echo "PASS"
exit 0
