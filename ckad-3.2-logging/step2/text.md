# Multi-Container Pod Logs

## Task

1. View logs from the `sidecar` container in `log-generator`:
   ```
   kubectl logs log-generator -n logging-lab -c sidecar --tail=5
   ```
2. Save the sidecar logs (last 5 lines) to `/root/sidecar-logs.txt`.
3. List all container names in `log-generator` and save to `/root/container-names.txt`:
   ```
   kubectl get pod log-generator -n logging-lab -o jsonpath='{.spec.containers[*].name}'
   ```

## Hint

Use `-c <container-name>` to specify which container's logs to view. Without it, kubectl shows logs from the first container.
