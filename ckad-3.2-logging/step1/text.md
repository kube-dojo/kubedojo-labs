# View and Filter Container Logs

## Task

1. View the last 5 log lines from the `app` container in `log-generator`:
   ```
   kubectl logs log-generator -n logging-lab -c app --tail=5
   ```
2. Save the last 10 log lines to `/root/app-logs.txt`.
3. View logs from the last 30 seconds:
   ```
   kubectl logs log-generator -n logging-lab -c app --since=30s
   ```
4. Count the number of log lines generated and save to `/root/log-line-count.txt`.

## Hint

Use `kubectl logs <pod> -c <container> --tail=N` for the last N lines. `--since=30s` shows logs from the last 30 seconds. `wc -l` counts lines.
