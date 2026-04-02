#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 60); do
  SUCCEEDED=$(kubectl get job countdown -n jobs-lab -o jsonpath='{.status.succeeded}' 2>/dev/null)
  [ "$SUCCEEDED" = "1" ] && break
  sleep 2
done
if [ "$SUCCEEDED" != "1" ]; then
  echo "FAIL: Job countdown did not succeed"
  exit 1
fi

if [ ! -f $USER_HOME/countdown-logs.txt ]; then
  echo "FAIL: $USER_HOME/countdown-logs.txt does not exist"
  exit 1
fi
if ! grep -q "Done" $USER_HOME/countdown-logs.txt; then
  echo "FAIL: countdown-logs.txt should contain 'Done'"
  exit 1
fi

echo "PASS"
exit 0
