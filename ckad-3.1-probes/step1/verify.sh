#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S1=$(kubectl get pod liveness-http -n probes-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  S2=$(kubectl get pod liveness-exec -n probes-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S1" = "Running" ] && [ "$S2" = "Running" ] && break
  sleep 2
done

PROBE1=$(kubectl get pod liveness-http -n probes-lab -o jsonpath='{.spec.containers[0].livenessProbe.httpGet.path}' 2>/dev/null)
if [ "$PROBE1" != "/" ]; then
  echo "FAIL: liveness-http should have httpGet probe on /"
  exit 1
fi

PROBE2=$(kubectl get pod liveness-exec -n probes-lab -o jsonpath='{.spec.containers[0].livenessProbe.exec.command[0]}' 2>/dev/null)
if [ "$PROBE2" != "cat" ]; then
  echo "FAIL: liveness-exec should have exec probe with cat command"
  exit 1
fi

echo "PASS"
exit 0
