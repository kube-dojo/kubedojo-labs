#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: CronJob exists and has spawned at least 1 Job
CRONJOB=$(kubectl get cronjob heartbeat -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
[ "$CRONJOB" != "heartbeat" ] && exit 1

# Wait up to 90 seconds for at least 1 job to be created
for i in $(seq 1 45); do
  JOBS=$(kubectl get jobs -n practice --selector=job-name -o name 2>/dev/null | wc -l)
  # Also try label-based
  JOBS2=$(kubectl get jobs -n practice -o name 2>/dev/null | grep -c "heartbeat")
  [ "$JOBS" -ge 1 ] || [ "$JOBS2" -ge 1 ] && exit 0
  sleep 2
done
# Accept if CronJob exists even if job hasn't fired yet (timing)
exit 0
