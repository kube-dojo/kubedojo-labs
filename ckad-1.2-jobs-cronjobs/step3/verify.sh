#!/bin/bash
SCHED=$(kubectl get cronjob reporter -n jobs-lab -o jsonpath='{.spec.schedule}' 2>/dev/null)
if [ "$SCHED" != "*/1 * * * *" ]; then
  echo "FAIL: CronJob schedule should be '*/1 * * * *', got: $SCHED"
  exit 1
fi

if [ ! -f /root/cron-schedule.txt ]; then
  echo "FAIL: /root/cron-schedule.txt does not exist"
  exit 1
fi

for i in $(seq 1 30); do
  SUCC=$(kubectl get job reporter-manual -n jobs-lab -o jsonpath='{.status.succeeded}' 2>/dev/null)
  [ "$SUCC" = "1" ] && break
  sleep 2
done
if [ "$SUCC" != "1" ]; then
  echo "FAIL: reporter-manual job did not succeed"
  exit 1
fi

echo "PASS"
exit 0
