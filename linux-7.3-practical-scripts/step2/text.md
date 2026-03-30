# Health Check Script

A health check script monitors multiple system aspects and reports status.

## Checks to Include

1. **CPU** — load average vs number of CPUs
2. **Memory** — usage percentage
3. **Disk** — usage percentage
4. **Services** — check if a key process is running

## Your Task

Write `/root/healthcheck.sh` that:

1. Checks CPU load average (WARN if > number of CPUs)
2. Checks memory usage percentage
3. Checks disk usage percentage
4. Checks if a process (e.g., `sshd` or `bash`) is running

Each check should output a line with status:
```
[OK] CPU: Load average 0.5 (2 CPUs)
[OK] Memory: 45% used
[WARN] Disk: 85% used
[OK] Service: sshd is running
```

Make it executable and run it.
