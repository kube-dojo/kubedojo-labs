#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 60); do
  SUCCEEDED=$(kubectl get job parallel-job -n jobs-lab -o jsonpath='{.status.succeeded}' 2>/dev/null)
  [ "$SUCCEEDED" = "4" ] && break
  sleep 2
done
if [ "$SUCCEEDED" != "4" ]; then
  echo "FAIL: parallel-job should have 4 succeeded, got: $SUCCEEDED"
  exit 1
fi

COMP=$(kubectl get job parallel-job -n jobs-lab -o jsonpath='{.spec.completions}' 2>/dev/null)
if [ "$COMP" != "4" ]; then
  echo "FAIL: completions should be 4"
  exit 1
fi

PAR=$(kubectl get job parallel-job -n jobs-lab -o jsonpath='{.spec.parallelism}' 2>/dev/null)
if [ "$PAR" != "2" ]; then
  echo "FAIL: parallelism should be 2"
  exit 1
fi

if [ ! -f $USER_HOME/parallel-count.txt ]; then
  echo "FAIL: $USER_HOME/parallel-count.txt does not exist"
  exit 1
fi
COUNT=$(cat $USER_HOME/parallel-count.txt | tr -d '[:space:]')
if [ "$COUNT" != "4" ]; then
  echo "FAIL: parallel-count.txt should contain 4, got: $COUNT"
  exit 1
fi

echo "PASS"
exit 0
