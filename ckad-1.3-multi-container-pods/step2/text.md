# Implement a Sidecar Logging Pattern

A sidecar container runs alongside the main container, typically for logging, monitoring, or proxying.

## Task

Create a pod named `sidecar-log` in `multi-lab` with:

1. A main container named `app` using `busybox:1.36` that writes timestamps to a log file:
   - Command: `sh -c "while true; do date >> /var/log/app.log; sleep 5; done"`
2. A sidecar container named `log-reader` using `busybox:1.36` that tails the log:
   - Command: `sh -c "tail -f /var/log/app.log"`
3. Both containers share an `emptyDir` volume named `log-volume` mounted at `/var/log`.

After the pod is running, verify logs are flowing by running:
```
kubectl logs sidecar-log -n multi-lab -c log-reader
```

## Hint

Both containers mount the same `emptyDir` volume at `/var/log`. The app writes, the sidecar reads.
