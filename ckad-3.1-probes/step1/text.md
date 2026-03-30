# Configure Liveness Probes

Liveness probes tell Kubernetes when to restart a container. If the liveness probe fails, the container is killed and restarted.

## Task

Create a pod named `liveness-http` in `probes-lab` with:
- Image: `nginx:1.25`
- An HTTP liveness probe:
  - Path: `/`
  - Port: `80`
  - `initialDelaySeconds: 5`
  - `periodSeconds: 10`

Also create a pod named `liveness-exec` in `probes-lab` with:
- Image: `busybox:1.36`
- Command: `sh -c "touch /tmp/healthy; sleep 3600"`
- An exec liveness probe:
  - Command: `cat /tmp/healthy`
  - `initialDelaySeconds: 5`
  - `periodSeconds: 5`

## Hint

HTTP probes use `httpGet` with path and port. Exec probes use `exec` with `command` array.
