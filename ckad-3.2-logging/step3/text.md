# Stream and Search Logs

## Task

1. Create a new pod `search-app` in `logging-lab` with busybox:1.36 that generates mixed log levels:
   ```
   command: ["sh", "-c", "while true; do echo \"INFO: all good\"; echo \"ERROR: something failed\"; echo \"WARN: check this\"; sleep 3; done"]
   ```
2. Wait for it to run, then extract only ERROR lines and save to `/root/error-logs.txt`:
   ```
   kubectl logs search-app -n logging-lab | grep ERROR > /root/error-logs.txt
   ```
3. Count the ERROR lines and save the count to `/root/error-count.txt`.

## Hint

Use `grep` to filter log output. Combine with `wc -l` to count matches.
