#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
kubectl get resourcequota compute-quota -n quota-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: ResourceQuota compute-quota not found"
  exit 1
fi
for i in $(seq 1 30); do
  S=$(kubectl get pod quota-pod -n quota-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ "$S" != "Running" ]; then
  echo "FAIL: quota-pod should be Running"
  exit 1
fi
if [ ! -f $USER_HOME/used-cpu.txt ]; then
  echo "FAIL: $USER_HOME/used-cpu.txt not found"
  exit 1
fi
echo "PASS"
exit 0
