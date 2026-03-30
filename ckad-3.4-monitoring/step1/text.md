# Monitor Resource Usage with kubectl top

## Task

1. Check node resource usage: `kubectl top nodes` (wait 1-2 minutes if metrics are not yet available).
2. Check pod resource usage in `monitoring-lab`: `kubectl top pods -n monitoring-lab`.
3. Save the node CPU usage output to `/root/node-metrics.txt`.
4. Save the pod metrics for `monitoring-lab` to `/root/pod-metrics.txt`.

Note: Metrics server needs 1-2 minutes to collect data. If you get "error: Metrics not available", wait and retry.

## Hint

`kubectl top nodes` shows node-level CPU and memory. `kubectl top pods -n <ns>` shows pod-level metrics. These require the metrics-server to be running.
