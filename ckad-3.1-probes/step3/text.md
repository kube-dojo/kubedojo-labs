# Configure Startup Probes and Troubleshoot Probe Failures

Startup probes protect slow-starting applications. Once the startup probe succeeds, liveness and readiness probes take over.

## Task

1. Create a pod named `slow-start` in `probes-lab` with:
   - Image: `nginx:1.25`
   - Startup probe: HTTP GET on `/` port 80
   - `failureThreshold: 30`
   - `periodSeconds: 2`
   - Liveness probe: HTTP GET on `/` port 80, `periodSeconds: 10`

2. Create a pod named `failing-probe` in `probes-lab` with:
   - Image: `nginx:1.25`
   - Liveness probe: HTTP GET on `/nonexistent` port 80, `initialDelaySeconds: 1`, `periodSeconds: 3`, `failureThreshold: 3`

3. Wait 15 seconds then check the restart count of `failing-probe`. It should have been restarted. Save the restart count to `/root/restart-count.txt`.

## Hint

The `failing-probe` pod will restart because `/nonexistent` returns 404 which counts as a probe failure. Use `kubectl get pod failing-probe -n probes-lab -o jsonpath='{.status.containerStatuses[0].restartCount}'`.
