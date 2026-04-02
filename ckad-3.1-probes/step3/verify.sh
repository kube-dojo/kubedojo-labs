#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod slow-start -n probes-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done

SP=$(kubectl get pod slow-start -n probes-lab -o jsonpath='{.spec.containers[0].startupProbe.httpGet.path}' 2>/dev/null)
if [ "$SP" != "/" ]; then
  echo "FAIL: slow-start should have startup probe on /"
  exit 1
fi

LP=$(kubectl get pod slow-start -n probes-lab -o jsonpath='{.spec.containers[0].livenessProbe.httpGet.path}' 2>/dev/null)
if [ "$LP" != "/" ]; then
  echo "FAIL: slow-start should have liveness probe"
  exit 1
fi

if [ ! -f $USER_HOME/restart-count.txt ]; then
  echo "FAIL: $USER_HOME/restart-count.txt not found"
  exit 1
fi
RC=$(cat $USER_HOME/restart-count.txt | tr -d '[:space:]')
if [ "$RC" -lt 1 ] 2>/dev/null; then
  echo "FAIL: failing-probe should have restarted at least once"
  exit 1
fi
echo "PASS"
exit 0
